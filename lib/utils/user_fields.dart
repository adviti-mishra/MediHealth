import 'package:flutter/material.dart';
import 'color_shades.dart';

Text header(String desiredHeader) {
  return Text(desiredHeader,
      style: TextStyle(
        color: ColorShades.text2,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ));
}

Text content(String desiredContent) {
  return Text(desiredContent,
      style: TextStyle(
        color: ColorShades.text2,
        fontSize: 30,
      ));
}

Row userField({required String header_in, required String content_in}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      header(header_in),
      Flexible(child: content(content_in)),
    ],
  );
}

  Row userFieldIcon(
      {required String header_in,
      required String content_in,
      required IconData icon_in}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        header(header_in),
        content(content_in),
        const Spacer(),
        Expanded(child: Icon(icon_in))
      ],
    );
  }

