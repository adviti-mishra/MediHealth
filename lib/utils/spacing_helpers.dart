import 'package:flutter/material.dart';
import 'package:practice_app/utils/color_shades.dart';

SizedBox verticalSpace(double desiredHeight) {
    return SizedBox(height: desiredHeight);
  }

RichText mandatoryHeader({required String desiredHeader}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: desiredHeader,
              style: TextStyle(
                color: ColorShades.text2,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          const TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

