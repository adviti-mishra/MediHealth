import 'package:flutter/material.dart';

Column welcomeBackMessage(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'MediHealth',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Text(
        'welcome back!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Text(
        'please fill in your credentials',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      )
    ],
  );
}
