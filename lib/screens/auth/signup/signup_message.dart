import 'package:flutter/material.dart';

Column welcomeInMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Create Your Account',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xff102542)),
      ),
      SizedBox(height: 5,),
      Text(
        'Please Fill In Your Information',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff102542)),
      )
    ],
  );
}