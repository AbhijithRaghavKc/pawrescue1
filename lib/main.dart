import 'package:flutter/material.dart';
import 'package:pawrescue1/view/splash.dart';
import 'package:pawrescue1/view/user/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
