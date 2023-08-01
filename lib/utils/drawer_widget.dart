import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/my_circle.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'package:practice_app/screens/landing_page/landing_page.dart';
import 'package:practice_app/screens/old_media_page/old_media.dart';
import 'package:practice_app/screens/promptPage/promptPage.dart';
import 'package:practice_app/screens/settings/settings.dart';
import 'package:practice_app/screens/auth/login/login_page.dart';
import 'color_shades.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  Container drawerMenuOption(
      {required String label, required IconData icon, required Function ftor}) {
    return Container(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          ftor();
        },
        title: Text(
          label,
          style: TextStyle(
            fontSize: 40,
            color: ColorShades.primaryColor4,
            fontFamily: 'Tahoma',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void logOutPopup(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: ColorShades.text1,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.logout, color: ColorShades.primaryColor1),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Log out',
                        style: TextStyle(color: ColorShades.text2)))
              ],
            ),
            content: Text("Do you want to log out?",
                style: TextStyle(color: ColorShades.text2)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child:
                      Text('Yes', style: TextStyle(color: ColorShades.text2))),
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child:
                      Text('No', style: TextStyle(color: ColorShades.text2))),
            ]);
      },
    );
  }

  void navigatetoUserProfileScreen(context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String uid = user!.uid;

    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const UserProfile(userID: 'YOUR USER ID')));
  }

  void navigagetoLandingPageScreen(context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String uid = user!.uid;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()),
    );
  }

  void navigatetoAccessibilityFeaturesScreen(context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings()),
    );
  }

  void navigatetoCircleScreen(context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String uid = user!.uid;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyCircle()),
    );
  }

  void navigatetoOldMediaScreen(context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String uid = user!.uid;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OldMedia()),
    );
  }

  void navigatetoPromptScreen(context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String uid = user!.uid;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PromptPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ColorShades.primaryColor1, ColorShades.primaryColor2]),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 90),
            Container(
              color: Colors.transparent,
              child: ListTile(
                title: Text(
                  "Privacy",
                  style: TextStyle(
                    color: ColorShades.primaryColor4,
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: ListTile(
                title: Text(
                  "Credits",
                  style: TextStyle(
                    color: ColorShades.primaryColor4,
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Divider(
              color: ColorShades.text1,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            drawerMenuOption(
                label: "Home Page",
                icon: Icons.perm_media,
                ftor: () {
                  navigagetoLandingPageScreen(context);
                }),
            drawerMenuOption(
                label: "Profile",
                icon: Icons.account_circle,
                ftor: () {
                  navigatetoUserProfileScreen(context);
                }),
            drawerMenuOption(
                label: "Settings",
                icon: Icons.settings,
                ftor: () {
                  navigatetoAccessibilityFeaturesScreen(context);
                }),
            drawerMenuOption(
                label: "My Circle",
                icon: Icons.people,
                ftor: () {
                  navigatetoCircleScreen(context);
                }),
            drawerMenuOption(
                label: "Old Media",
                icon: Icons.perm_media,
                ftor: () {
                  navigatetoOldMediaScreen(context);
                }),
            drawerMenuOption(
                label: "Prompt",
                icon: Icons.perm_media,
                ftor: () {
                  navigatetoPromptScreen(context);
                }),
            Divider(
              thickness: 2,
              color: ColorShades.text1,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 60),
            Container(
              color: Colors.transparent,
              child: ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 40,
                    color: ColorShades.text1,
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      logOutPopup(context);
                    }
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: ColorShades.text1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
