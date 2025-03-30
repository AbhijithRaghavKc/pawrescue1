import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';
import 'package:pawrescue1/view/user/home.dart';

class ConfirmSignUpScreen extends StatefulWidget {
  final String email;

  const ConfirmSignUpScreen({super.key, required this.email});

  @override
  State<ConfirmSignUpScreen> createState() => _ConfirmSignUpScreenState();
}

class _ConfirmSignUpScreenState extends State<ConfirmSignUpScreen> {
  final _codeController = TextEditingController();
  bool _isConfirming = false;
  bool _isResending = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _confirmSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isConfirming = true);

    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: widget.email,
        confirmationCode: _codeController.text.trim(),
      );

      if (result.isSignUpComplete) {
        // Auto-sign-in after successful confirmation
        try {
          await _signInAfterConfirmation();
        } catch (e) {
          _navigateToHomeWithSuccess();
        }
      }
    } on AuthException catch (e) {
      _showErrorSnackbar(_parseAuthError(e));
    } finally {
      if (mounted) {
        setState(() => _isConfirming = false);
      }
    }
  }

  Future<void> _signInAfterConfirmation() async {
    try {
      await Amplify.Auth.signIn(
        username: widget.email,
        password: '', // Password not needed right after confirmation
      );
      _navigateToHomeWithSuccess();
    } on AuthException catch (e) {
      _navigateToHomeWithSuccess();
    }
  }

  void _navigateToHomeWithSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account verified successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Future<void> _resendCode() async {
    setState(() => _isResending = true);

    try {
      await Amplify.Auth.resendSignUpCode(username: widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New verification code sent.'),
          duration: Duration(seconds: 2),
        ),
      );
    } on AuthException catch (e) {
      _showErrorSnackbar(_parseAuthError(e));
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  String _parseAuthError(AuthException e) {
    switch (e.message) {
      case 'Invalid verification code provided':
        return 'The code you entered is incorrect';
      case 'Code mismatch':
        return 'Incorrect verification code';
      case 'Expired code':
        return 'This code has expired. Please request a new one';
      default:
        return 'Error: ${e.message}';
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.email_outlined,
                  size: 80,
                  color: CustomColors.buttonColor1,
                ),
                const SizedBox(height: 20),
                Text(
                  'Enter the 6-digit code sent to:',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Verification Code',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.confirmation_number),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the verification code';
                    }
                    if (value.length != 6) {
                      return 'Code must be 6 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isConfirming ? null : _confirmSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.buttonColor1,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isConfirming
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verify Account',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _isResending ? null : _resendCode,
                  child: _isResending
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Didn't receive a code? Resend",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}