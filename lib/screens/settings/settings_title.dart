import 'package:flutter/material.dart';
import '../../../../utils/utils_all.dart';

Column settingsTitle(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Settings',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 48 * fontSizeMultiplier, fontWeight: FontWeight.bold, color: ColorShades.primaryColor1),
      ),
    ],
  );
}