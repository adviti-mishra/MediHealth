import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Column welcomeBackMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Forgot Password?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: ColorShades.primaryColor1,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
          "No Problem! Fill in you're email and we'll send you the next steps.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1,
          ))
    ],
  );
}
