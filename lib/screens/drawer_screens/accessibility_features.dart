import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

class AccessibilityFeatures extends StatefulWidget {
  const AccessibilityFeatures({Key? key}) : super(key: key);
  @override
  _AccessibilityFeatures createState() => _AccessibilityFeatures();
}

class _AccessibilityFeatures extends State<AccessibilityFeatures> {
  Column accessibilityContent() {
    return Column(
      children: const [
        Text('1. color schemes/font size adjustment for various visibility-related disabilities,'),
        Text('2. text-to-speech button for audio disability,'),
        Text('3. Multiple languages'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorShades.primaryColor1,
        title: Center(
            child: Text('Accessibility features',
                style: TextStyle(
                    color: ColorShades.text1,
                    fontSize: 40))),
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined,
                  color: ColorShades.text1),
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
            );
          },
        ),
      ),
      body: accessibilityContent(),
    );
  }
}
