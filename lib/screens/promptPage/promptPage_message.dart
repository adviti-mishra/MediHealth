import 'package:flutter/material.dart';
import 'package:practice_app/screens/settings/settings.dart';
import 'package:practice_app/utils/color_shades.dart';
import 'package:practice_app/utils/utils_all.dart';

Column promptPageMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Prompt Will Display Here...',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 36 * fontSizeMultiplier, fontWeight: FontWeight.bold, color: ColorShades.primaryColor1),
      ),
    ],
  );
}