import 'package:flutter/material.dart';

Column welcomeBackMessage(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Forgot Password?',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xff102542)),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "No Problem! Fill in you're email and we'll send you the next steps.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff102542)),
      )
    ],
  );
}
