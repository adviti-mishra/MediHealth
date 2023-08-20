import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';

Column welcomeInMessage(BuildContext context) {
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
        'Fill In Your Login Information',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1),
      )
    ],
  );
}
