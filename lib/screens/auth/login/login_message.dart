import 'package:flutter/material.dart';

Column welcomeBackMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'MediHealth',
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
        'Welcome Back!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xff102542)),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Please Fill In Your Information',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff102542)),
      )
    ],
  );
}
