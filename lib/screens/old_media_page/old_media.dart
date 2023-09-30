import 'package:flutter/material.dart';
import 'package:practice_app/screens/old_media_page/media_library.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:iconly/iconly.dart';

class OldMedia extends StatelessWidget {
  OldMedia({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void navigateToMediaLibrary(context, mediaType) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String uid = user!.uid;

    // Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MediaLibrary(mediaType: mediaType)));
  }

  InkWell mediaBubble(
      IconData mediaIcon, String mediaText, BuildContext context) {
    return InkWell(
      child: Container(
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
                fontSize: 28 * fontSizeMultiplier,
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
      ),
      onTap: () {
        navigateToMediaLibrary(context, mediaText);
      },
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Media Library",
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontFamily: "Tahoma",
                    fontSize: 40 * fontSizeMultiplier,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mediaBubble(IconlyBold.image, "Photos", context),
                    const SizedBox(width: 35),
                    mediaBubble(IconlyBold.video, "Videos", context),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mediaBubble(IconlyBold.volume_up, "Voice Memos", context),
                    const SizedBox(width: 35),
                    mediaBubble(IconlyBold.chat, "Messages", context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
