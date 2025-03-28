import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';
import 'package:pawrescue1/view/user/auth/signin.dart';

class ConfirmSignUpScreen extends StatefulWidget {
  final String email;

  const ConfirmSignUpScreen({super.key, required this.email});

  @override
  State<ConfirmSignUpScreen> createState() => _ConfirmSignUpScreenState();
}

class _ConfirmSignUpScreenState extends State<ConfirmSignUpScreen> {
  final _codeController = TextEditingController();

  Future<void> confirmSignUp() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: widget.email,
        confirmationCode: _codeController.text.trim(),
      );

      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-up confirmed! Please sign in.')),
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserSignIn(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Confirmation incomplete.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error confirming sign-up: $e')),
      );
    }
  }

  Future<void> resendCode() async {
    try {
      await Amplify.Auth.resendSignUpCode(username: widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Confirmation code resent.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error resending code: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Enter the confirmation code sent to ${widget.email}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Confirmation Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: confirmSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.buttonColor1,
              ),
              child: const Text('Confirm'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: resendCode,
              child: const Text('Resend Code'),
            ),
          ],
        ),
      ),
    );
  }
}
