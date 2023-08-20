import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';

class MediaLibrary extends StatelessWidget {
  MediaLibrary({Key? key, required this.mediaType}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String mediaType;

  Widget entry(String prompt, String answer, String date) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    prompt,
                    style: TextStyle(
                      color: ColorShades.primaryColor4,
                      fontSize: 24 * fontSizeMultiplier,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tahoma',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: TextStyle(
                      color: ColorShades.primaryColor4,
                      fontSize: 24 * fontSizeMultiplier,
                      fontFamily: 'Tahoma',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                answer,
                style: TextStyle(
                  color: ColorShades.text1,
                  fontSize: 18 * fontSizeMultiplier,
                  fontFamily: 'Tahoma',
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          decoration: BoxDecoration(
            color: ColorShades.primaryColor1,
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  mediaType,
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontSize: 40 * fontSizeMultiplier,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Tahoma',
                  ),
                ),
                entry(
                    "How do you feel?",
                    "Lorem ipsum dolor, sit amet, consectetur adipiscing elit. Duis vitae tincidunt ipsum, nec semper tellus. Nam semper ex in accumsan sollicitudin. Vestibulum dictum ut ipsum ut viverra. Phasellus tincidunt feugiat bibendum. Ut sapien erat, ornare eu auctor hendrerit, finibus non sapien. Nulla eleifend ante id fringilla bibendum. Donec facilisis, tortor.",
                    "08/02/23"),
                entry(
                    "How do you feel?",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tincidunt ipsum, nec semper tellus. Nam semper ex in accumsan sollicitudin. Vestibulum dictum ut ipsum ut viverra. Phasellus tincidunt feugiat bibendum. Ut sapien erat, ornare eu auctor hendrerit, finibus non sapien. Nulla eleifend ante id fringilla bibendum. Donec facilisis, tortor.",
                    "08/02/23"),
                entry(
                    "How do you feel?",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tincidunt ipsum, nec semper tellus. Nam semper ex in accumsan sollicitudin. Vestibulum dictum ut ipsum ut viverra. Phasellus tincidunt feugiat bibendum. Ut sapien erat, ornare eu auctor hendrerit, finibus non sapien. Nulla eleifend ante id fringilla bibendum. Donec facilisis, tortor.",
                    "08/02/23"),
                entry(
                    "How do you feel?",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tincidunt ipsum, nec semper tellus. Nam semper ex in accumsan sollicitudin. Vestibulum dictum ut ipsum ut viverra. Phasellus tincidunt feugiat bibendum. Ut sapien erat, ornare eu auctor hendrerit, finibus non sapien. Nulla eleifend ante id fringilla bibendum. Donec facilisis, tortor.",
                    "08/02/23")
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
