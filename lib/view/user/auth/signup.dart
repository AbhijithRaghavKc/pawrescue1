import 'package:flutter/material.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: CustomColors.buttonColor1)),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: CustomColors.buttonColor1)),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: CustomColors.buttonColor1)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: CustomColors.buttonColor1),
                    child: TextButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            "Create",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
