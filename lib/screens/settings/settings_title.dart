import 'package:flutter/material.dart';
import 'package:practice_app/utils/color_shades.dart';

Column settingsTitle(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Settings',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xff102542)),
      ),
    ],
  );
}