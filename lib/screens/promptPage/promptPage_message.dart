import 'package:flutter/material.dart';
import 'package:practice_app/utils/color_shades.dart';

Column promptPageMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        'Prompt Will Display Here...',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xff102542)),
      ),
    ],
  );
}