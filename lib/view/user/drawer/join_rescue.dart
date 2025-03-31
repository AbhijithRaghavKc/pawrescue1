import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';

class JoinRescueTeamPage extends StatefulWidget {
  const JoinRescueTeamPage({super.key});

  @override
  State<JoinRescueTeamPage> createState() => _JoinRescueTeamPageState();
}

class _JoinRescueTeamPageState extends State<JoinRescueTeamPage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  bool _isSubmitting = false;
  
  // Form fields
  String name = '';
  String email = '';
  String phone = '';
  String? userId;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final attributes = await Amplify.Auth.fetchUserAttributes();
      
      setState(() {
        userId = user.userId;
        // Extract email from attributes
        userEmail = attributes.firstWhere(
          (attr) => attr.userAttributeKey.key == AuthUserAttributeKey.email.key,
          orElse: () => AuthUserAttribute(
            userAttributeKey: AuthUserAttributeKey.email,
            value: '',
          ),
        ).value;
      });
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      // Use the email from form if provided, otherwise use Cognito email
      final applicationEmail = email.isNotEmpty ? email : userEmail ?? '';
      
      await _firestore.collection('rescue_team_applications').add({
        'userId': userId,
        'name': name,
        'email': applicationEmail,
        'phone': phone,
        'status': 'pending',
        'submittedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Application submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Clear form after submission
      _formKey.currentState?.reset();
      setState(() {
        name = '';
        email = '';
        phone = '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting application: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Rescue Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.buttonColor1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.buttonColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: CustomColors.buttonColor1, width: 2.0),
                  ),
                ),
                onChanged: (value) => name = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: userEmail ?? '', // Show Cognito email as hint
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.buttonColor1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.buttonColor1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: CustomColors.buttonColor1, width: 2.0),
                  ),
                ),
                onChanged: (value) => email = value,
                validator: (value) {
                  if (value!.isEmpty && userEmail == null) {
                    return 'Please enter your email';
                  }
                  if (value!.isNotEmpty && !value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.buttonColor1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.buttonColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: CustomColors.buttonColor1, width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => phone = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor1,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _isSubmitting ? null : _submitApplication,
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Submit Application',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}