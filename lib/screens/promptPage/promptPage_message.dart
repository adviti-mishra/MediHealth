import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Column promptPageMessage(BuildContext context, String prompt) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        prompt,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 36 * fontSizeMultiplier,
            fontWeight: FontWeight.bold,
            color: ColorShades.primaryColor1),
      ),
    ],
  );
}
