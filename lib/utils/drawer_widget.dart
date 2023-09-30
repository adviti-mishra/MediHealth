import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/my_circle.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'package:practice_app/screens/join_a_circle/join_circle.dart';
import 'package:practice_app/screens/landing_page/landing_page.dart';
import 'package:practice_app/screens/old_media_page/old_media.dart';
import 'package:practice_app/screens/promptPage/promptPage.dart';
import 'package:practice_app/screens/settings/settings.dart' as settings;
import 'package:practice_app/screens/auth/login/login_page.dart';
import 'color_shades.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool owner = false;
  String circleID = "";
  bool hasCircle = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final db = FirebaseFirestore.instance;
    final docRef = db.collection('user').doc(uid);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;

    setState(() {
      owner = data['isCircleOwner'];
      circleID = data['circleId'];
      if (circleID == "") {
        hasCircle = false;
      } else {
        hasCircle = true;
      }
    });
  }

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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
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
      MaterialPageRoute(builder: (context) => const LandingPage()),
    );
  }

  void navigatetoAccessibilityFeaturesScreen(context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const settings.Settings()),
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

  void navigatetoJoinCircleScreen(context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String uid = user!.uid;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JoinCircle()),
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
                  if (owner) {
                    navigagetoLandingPageScreen(context);
                  } else {
                    navigatetoPromptScreen(context);
                  }
                }),
            drawerMenuOption(
                label: "Profile",
                icon: Icons.account_circle,
                ftor: () {
                  navigatetoUserProfileScreen(context);
                }),
            drawerMenuOption(
                label: "My Circle",
                icon: Icons.people,
                ftor: () {
                  if (owner) {
                    navigatetoCircleScreen(context);
                  } else {
                    if (hasCircle) {
                      navigatetoCircleScreen(context);
                    } else {
                      navigatetoJoinCircleScreen(context);
                    }
                  }
                }),
            drawerMenuOption(
                label: "Old Media",
                icon: Icons.perm_media,
                ftor: () {
                  navigatetoOldMediaScreen(context);
                }),
            drawerMenuOption(
                label: "Settings",
                icon: Icons.settings,
                ftor: () {
                  navigatetoAccessibilityFeaturesScreen(context);
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
