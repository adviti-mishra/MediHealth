import 'package:flutter/material.dart';
import 'package:practice_app/screens/auth/forgot_password/forgot_password_page.dart';

Row navigate_to_forgotPassword(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPassword()));
          },
          // TO DO : forgot password? formatting
          child: const Text('forgot password?')
          )
    ],
  );
}
