import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Column welcomeBackMessage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // MediHealth
      Center(
          child: normalText(
              desiredContent: 'MediHealth',
              desiredColor: Theme.of(context).colorScheme.secondary,
              desiredFontWeight: FontWeight.bold,
              desiredFontSize: 48)),
      // TO DO: Welcome back!
      // TO DO: please fill in your credentials
    ],
  );
}
