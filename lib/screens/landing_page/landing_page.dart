import 'package:flutter/material.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/color_shades.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/screens/landing_page/message_screen.dart';
import 'package:practice_app/utils/app_bar.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget userText(
      {required String message, required String imagePath, required Key key}) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(
                    imagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 40),
            MessageScreen(
              key: key,
              message: message,
            ),
          ],
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
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Hello, ____",
                style: TextStyle(
                  color: ColorShades.primaryColor1,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tahoma',
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Welcome back to your account",
                style: TextStyle(
                  color: ColorShades.primaryColor1,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tahoma',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('0'),
                    ),
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('1'),
                    ),
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('2'),
                    ),
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('3'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
