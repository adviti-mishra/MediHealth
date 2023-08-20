import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Center signUp2Tile(
    {required Form namePhone,
    required MaterialButton createButton,
    required MaterialButton backButton}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        // TO DO : implement the blue box decoration
        decoration: BoxDecoration(
          color: ColorShades.primaryColor1,
          borderRadius: BorderRadius.circular(32),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
            child: Column(
              children: [
                // Name and Email and Password
                namePhone,
                // Blank Line
                verticalSpace(40),
                // Sign In
                createButton,
                // Blank Line
                verticalSpace(20),
                // Back
                backButton,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
