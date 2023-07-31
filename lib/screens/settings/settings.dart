import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/auth/signup/signup.dart';
import '../../../../utils/utils_all.dart';
import 'package:practice_app/screens/auth/welcome/welcome_page.dart';
import 'package:flutter/gestures.dart';
import 'package:practice_app/screens/settings/settings_title.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // values for sliders
  double _fontSize = 5;
  bool textToSpeechEnabled = false;
  bool highContrastEnabled = false;
  bool somethingElseEnabled = false;
  double _speechSpeed = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: settingPageContent(context),
    );
  }

  Container settingPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          verticalSpace(80),
          settingsTitle(context),
          verticalSpace(20),
          textSize(),
          textToSpeech(),
          colorScheme(),
          backWelcomeButton(),
        ],
      ),
    );
  }

  // Text Size field
  Container textSize() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xff102542),
            width: 4.0), 
          right: BorderSide(color: Color(0xff102542),
            width: 4.0), 
          top: BorderSide(color: Color(0xff102542),
            width: 4.0), 
          bottom: BorderSide(color: Color(0xff102542),
            width: 2.0),
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
                    color: Color(0xff102542),
                    fontSize: 26,
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
                    color: Color(0xff102542),
                    fontSize: 24,
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
                Text(
                  ".5x",
                  style: TextStyle(
                    color: Color(0xff102542),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                textSizeSlider(),
                Text(
                  "2x",
                  style: TextStyle(
                    color: Color(0xff102542),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
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
  Container textSizeSlider(){
    return Container(
      width: 330,
      decoration: new BoxDecoration(
        color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      child: new Slider(
        value: _fontSize,
        activeColor: Color(0xff102542),
        inactiveColor: ColorShades.maize,
        onChanged: (double s) {
          setState(() {
            _fontSize = s;
          });
        },
        divisions: 9,
        min: 1.0,
        max: 10.0,
      ),
    );
  }

  // textToSpeech field
  Container textToSpeech() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xff102542),
            width: 4.0), 
          right: BorderSide(color: Color(0xff102542),
            width: 4.0), 
          top: BorderSide(color: Color(0xff102542),
            width: 2.0), 
          bottom: BorderSide(color: Color(0xff102542),
            width: 2.0),
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
                  "Text to Speech",
                  style: TextStyle(
                    color: Color(0xff102542),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 150),
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
                    color: Color(0xff102542),
                    fontSize: 24,
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
                Text(
                  ".5x",
                  style: TextStyle(
                    color: Color(0xff102542),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                textToSpeechSpeed(),
                Text(
                  "2x",
                  style: TextStyle(
                    color: Color(0xff102542),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
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
      activeColor: Color(0xff102542),
      inactiveTrackColor: Color.fromARGB(100, 16, 37, 66),
      inactiveThumbColor: Color(0xff102542),
      value: textToSpeechEnabled,
      onChanged: (value) {
        setState(() {
          textToSpeechEnabled = value;
        });
      },
    );
  }

  // Text To Speech Speed
  Container textToSpeechSpeed(){
    return Container(
      width: 330,
      decoration: new BoxDecoration(
        color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      child: new Slider(
        value: _speechSpeed,
        activeColor: Color(0xff102542),
        inactiveColor: ColorShades.maize,
        onChanged: (double s) {
          setState(() {
            _speechSpeed = s;
          });
        },
        divisions: 9,
        min: 1.0,
        max: 10.0,
      ),
    );
  }
    

  // Color Scheme field
Container colorScheme() {
  return Container(
    decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xff102542),
            width: 4.0), 
          right: BorderSide(color: Color(0xff102542),
            width: 4.0), 
          top: BorderSide(color: Color(0xff102542),
            width: 2.0), 
          bottom: BorderSide(color: Color(0xff102542),
            width: 4.0),
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
                  color: Color(0xff102542),
                  fontSize: 26,
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
                "High Contrast",
                style: TextStyle(
                  color: Color(0xff102542),
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 175),
              highContrastToggle(),
            ],
          ),
        ),
        verticalSpace(10),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text( 
                "Something Else",
                style: TextStyle(
                  color: Color(0xff102542),
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 154),
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
      activeColor: Color(0xff102542),
      inactiveTrackColor: Color.fromARGB(100, 16, 37, 66),
      inactiveThumbColor: Color(0xff102542),
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
      activeColor: Color(0xff102542),
      inactiveTrackColor: Color.fromARGB(100, 16, 37, 66),
      inactiveThumbColor: Color(0xff102542),
      value: somethingElseEnabled,
      onChanged: (value) {
        setState(() {
          somethingElseEnabled = value;
        });
      },
    );
  }


//WILL BE DELETED ONCE DRAWER IS PUT IN
  // Back Button
  TextButton backWelcomeButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcome()
          )
        );
      },
      child: const Text(
        "Back",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      )
    );
  }
}
