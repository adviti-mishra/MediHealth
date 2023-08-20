import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';

Column welcomeIn2Message(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Create Your Account',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        'Fill In Your Personal Information',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1),
      )
    ],
  );
}
