import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawrescue1/view/user/auth/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const UserSignUp()),
          (route) => false);
    });
    return Scaffold(
      body: Center(
        child: Text(
          "PAW RESCUE",
          style: GoogleFonts.poppins(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
