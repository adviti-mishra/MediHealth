// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import '../../../../utils/utils_all.dart';
import 'package:practice_app/screens/settings/settings_title.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // values for sliders
  bool textToSpeechEnabled = false;
  bool highContrastEnabled = false;
  bool somethingElseEnabled = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: SingleChildScrollView(child: settingPageContent(context),),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Container settingPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorShades.text1,
      ),
      child: Column(
        children: [
          verticalSpace(20),
          settingsTitle(context),
          verticalSpace(20),
          textSize(),
          textToSpeech(),
          colorScheme(),
        ],
      ),
    );
  }

  // Text Size field
  Container textSize() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorShades.primaryColor1, width: 4.0),
          bottom: BorderSide(color: ColorShades.primaryColor1, width: 2.0),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Text(
                  "Text Size",
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontSize: 26 * fontSizeMultiplier,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(20),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Text(
                  "Size",
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontSize: 24 * fontSizeMultiplier,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Aa",
                      style: TextStyle(
                        color: ColorShades.primaryColor1,
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: textSizeSlider(),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Aa",
                      style: TextStyle(
                        color: ColorShades.primaryColor1,
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Text Size slider content
  Container textSizeSlider() {
    return Container(
      width: 330,
      decoration: new BoxDecoration(
        color: ColorShades.text1,
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      child: new Slider(
        value: fontSizeMultiplier,
        activeColor: ColorShades.primaryColor1,
        inactiveColor: ColorShades.primaryColor4,
        onChanged: (double s) {
          setState(() {
            fontSizeMultiplier = s;
          });
        },
        divisions: 10,
        min: .5,
        max: 2,
      ),
    );
  }

  // textToSpeech field
  Container textToSpeech() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorShades.primaryColor1, width: 2.0),
          bottom: BorderSide(color: ColorShades.primaryColor1, width: 2.0),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Text to Speech",
                    style: TextStyle(
                      color: ColorShades.primaryColor1,
                      fontSize: 26 * fontSizeMultiplier,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                textToSpeechToggle(),
              ],
            ),
          ),
          verticalSpace(20),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Text(
                  "Speed",
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontSize: 24 * fontSizeMultiplier,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ".5x",
                      style: TextStyle(
                        color: ColorShades.primaryColor1,
                        fontSize: 18 * fontSizeMultiplier,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: fontSizeMultiplier > 1.0 ? (11 / fontSizeMultiplier).toInt() : 10,
                  child: textToSpeechSpeed(),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "2x",
                      style: TextStyle(
                        color: ColorShades.primaryColor1,
                        fontSize: 18 * fontSizeMultiplier,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Text To Speech Toggle
  Switch textToSpeechToggle() {
    return Switch(
      activeTrackColor: Color.fromARGB(200, 16, 37, 66),
      activeColor: ColorShades.primaryColor1,
      inactiveTrackColor: Color.fromARGB(100, 16, 37, 66),
      inactiveThumbColor: ColorShades.primaryColor1,
      value: textToSpeechEnabled,
      onChanged: (value) {
        setState(() {
          textToSpeechEnabled = value;
        });
      },
    );
  }

  // Text To Speech Speed
  Container textToSpeechSpeed() {
    return Container(
      width: 330,
      decoration: new BoxDecoration(
        color: ColorShades.text1,
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      child: new Slider(
        value: speechSpeed,
        activeColor: ColorShades.primaryColor1,
        inactiveColor: ColorShades.primaryColor4,
        onChanged: (double s) {
          setState(() {
            speechSpeed = s;
          });
        },
        divisions: 10,
        min: .5,
        max: 2,
      ),
    );
  }

  // Color Scheme field
  Container colorScheme() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorShades.primaryColor1, width: 2.0),
          bottom: BorderSide(color: ColorShades.primaryColor1, width: 4.0),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Text(
                  "Color Scheme",
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontSize: 26 * fontSizeMultiplier,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(20),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "High Contrast",
                    style: TextStyle(
                      color: ColorShades.primaryColor1,
                      fontSize: 24 * fontSizeMultiplier,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                highContrastToggle(),
              ],
            ),
          ),
          verticalSpace(10),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Something Else",
                    style: TextStyle(
                      color: ColorShades.primaryColor1,
                      fontSize: 24 * fontSizeMultiplier,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                somethingElseToggle(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Switch highContrastToggle() {
    return Switch(
      activeTrackColor: Color.fromARGB(200, 16, 37, 66),
      activeColor: ColorShades.primaryColor1,
      inactiveTrackColor: Color.fromARGB(100, 16, 37, 66),
      inactiveThumbColor: ColorShades.primaryColor1,
      value: highContrastEnabled,
      onChanged: (value) {
        setState(() {
          highContrastEnabled = value;
        });
      },
    );
  }

  Switch somethingElseToggle() {
    return Switch(
      activeTrackColor: Color.fromARGB(200, 16, 37, 66),
      activeColor: ColorShades.primaryColor1,
      inactiveTrackColor: Color.fromARGB(100, 16, 37, 66),
      inactiveThumbColor: ColorShades.primaryColor1,
      value: somethingElseEnabled,
      onChanged: (value) {
        setState(() {
          somethingElseEnabled = value;
        });
      },
    );
  }
}
