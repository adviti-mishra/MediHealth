import 'package:flutter/material.dart';

Column welcomeIn2Message(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Create Your Account',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xff102542)),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Fill In Your Personal Information',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff102542)),
      )
    ],
  );
}
