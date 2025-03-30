import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawrescue1/view/user/auth/signup.dart';
import 'package:pawrescue1/view/user/home.dart'; // Import Home Page

String uid = '';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  // **Function to Check if User is Logged In**
  void _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Show splash for 3 sec

    try {
      final session = await Amplify.Auth.fetchAuthSession();
      bool isSignedIn = (session.isSignedIn);

      if (isSignedIn) {
        // **User is signed in → Navigate to Home Page**
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        final user = await Amplify.Auth.getCurrentUser();
        uid = user.userId;
      } else {
        // **User is NOT signed in → Navigate to Sign-Up Page**
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserSignUp()),
        );
      }
    } catch (e) {
      print("Error checking auth session: $e");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserSignUp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
