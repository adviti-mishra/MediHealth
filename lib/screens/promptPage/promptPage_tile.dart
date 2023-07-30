import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

Center enterResponseTile({required Form response, required MaterialButton photoButton, required MaterialButton videoButton, required MaterialButton voiceMemoButton}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        // TO DO : implement the blue box decoration
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff102542), width: 5)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // Email and Password
                response,
                verticalSpace(20),
                Text(
                  'Or submit alternative media',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20, color: Color(0xff102542)),
                ),
                verticalSpace(20),
                Row(
                  children: [
                    photoButton,
                    SizedBox(width: 36),  
                    videoButton,
                    SizedBox(width: 36), 
                    voiceMemoButton,
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
