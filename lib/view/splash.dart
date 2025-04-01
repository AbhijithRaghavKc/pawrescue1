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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Icon
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(144, 136, 228, 1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.pets,
                color: Colors.white,
                size: 80,
              ),
            ),
            const SizedBox(height: 24),

            // App Title
            Text(
              "Paw Rescue",
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(144, 136, 228, 1),
              ),
            ),
            const SizedBox(height: 12),

            // Tagline
            Text(
              "Every Paw Matters!",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Color.fromRGBO(144, 136, 228, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
