import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';

Column welcomeBackMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'MediHealth',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        'Welcome Back!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        'Please Fill In Your Information',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1),
      )
    ],
  );
}
