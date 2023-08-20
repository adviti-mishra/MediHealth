// TO DO : implement getInfoTile similar to getInfoTile of login page

import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';
import '../../../utils/utils_all.dart';

Center forgotPasswordTile(
    {required Form recoveryEmail, required MaterialButton submitButton}) {
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
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 45),
            child: Column(
              children: [
                // Email
                recoveryEmail,
                verticalSpace(20),
                // Submit
                submitButton,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
