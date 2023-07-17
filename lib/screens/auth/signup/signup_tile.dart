import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Center signUpTile({required Form nameEmailPassword, required MaterialButton createButton}) {
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
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
            child: Column(
              children: [
                // Email and Password
                nameEmailPassword,
                verticalSpace(20),
                // Sign In
                createButton,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
