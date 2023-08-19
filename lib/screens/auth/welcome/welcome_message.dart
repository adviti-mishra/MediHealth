import 'package:flutter/material.dart';

Column welcomeMessage(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
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