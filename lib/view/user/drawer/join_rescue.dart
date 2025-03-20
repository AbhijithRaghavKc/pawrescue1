import 'package:flutter/material.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';

class JoinRescueTeamPage extends StatefulWidget {
  const JoinRescueTeamPage({super.key});

  @override
  State<JoinRescueTeamPage> createState() => _JoinRescueTeamPageState();
}

class _JoinRescueTeamPageState extends State<JoinRescueTeamPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';

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
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
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
                onChanged: (value) => email = value,
                validator: (value) =>
                    value!.contains('@') ? null : 'Enter a valid email',
              ),
              SizedBox(height: 20),
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
                    backgroundColor: CustomColors.buttonColor1),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Application Submitted')),
                    );
                  }
                },
                child: const Text(
                  'Submit',
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
