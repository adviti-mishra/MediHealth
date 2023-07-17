import 'package:flutter/material.dart';

Column welcomeMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'MediHealth',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 60, fontWeight: FontWeight.bold, color: Color(0xFFF8CD51)),
      ),
      SizedBox(height: 20,),
      Text(
        'Lets Heal Together',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      SizedBox(height: 20,),
      Text(
        'Welcome!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      )
    ],
  );
}