import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonColor,
      required this.text,
      required this.onPress});

  final Color buttonColor;
  final String text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: buttonColor),
        child: TextButton(
            onPressed: onPress,
            child: Text(
              text,
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )));
  }
}
