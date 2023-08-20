import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Column welcomeMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'MediHealth',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor4),
      ),
      const SizedBox(
        height: 20,
      ),
      const Text(
        'Lets Heal Together',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      const SizedBox(
        height: 20,
      ),
      const Text(
        'Welcome!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      )
    ],
  );
}
