import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';

class OldMedia extends StatelessWidget {
  OldMedia({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Container mediaBubble(IconData mediaIcon, String mediaText) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            mediaIcon,
            color: ColorShades.primaryColor4,
            size: 100,
          ),
          Text(
            mediaText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorShades.primaryColor4,
              fontFamily: "Tahoma",
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: ColorShades.primaryColor1,
        borderRadius: BorderRadius.circular(40),
      ),
      height: 240,
      width: 170,
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
        margin: const EdgeInsets.only(top: 20),
        child: Center(
            child: Column(
          children: [
            Text(
              "Media Library",
              style: TextStyle(
                color: ColorShades.primaryColor1,
                fontFamily: "Tahoma",
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mediaBubble(Icons.abc, "Photos"),
                const SizedBox(width: 20),
                mediaBubble(Icons.abc, "Videos"),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mediaBubble(Icons.abc, "Voice Memos"),
                const SizedBox(width: 20),
                mediaBubble(Icons.abc, "Messages"),
              ],
            ),
          ],
        )),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
