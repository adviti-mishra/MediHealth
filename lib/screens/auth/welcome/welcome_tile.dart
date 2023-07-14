import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Center welcomeTile({required MaterialButton loginPageButton, required MaterialButton signupPageButton}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        // TO DO : implement the blue box decoration
        decoration: BoxDecoration(
          color: Color(0xff102542),
          borderRadius: BorderRadius.circular(32),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 45),
            child: Column(
              children: [
                Text(
                  'Login or Sign Up Below',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                verticalSpace(20),
                // Log In Button
                loginPageButton,
                verticalSpace(20),
                // Sign In Button
                signupPageButton,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
