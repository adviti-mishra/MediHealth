import 'package:flutter/material.dart';

Column welcomeInMessage(BuildContext context) {
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
        'Fill In Your Login Information',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff102542)),
      )
    ],
  );
}
