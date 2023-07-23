import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/accessibility/accessibility_features.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'package:practice_app/screens/drawer_screens/emergency_contacts/emergency_contact_screen.dart';
import '../../utils/color_shades.dart';
import '../drawer_screens/personal_notes/personal_note_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  Container drawerMenuOption(
      {required String label, required IconData icon, required Function ftor}) {
    return Container(
      color: Colors.transparent,
      //elevation: 16,
      child: ListTile(
        onTap: () {
          ftor();
        },
        // leading: Icon(icon, color: ColorShades.text2),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 40,
            color: Color(0xFFF8CD51),
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
                    _auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
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
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserProfile(userID: uid)));
  }

  void navigatetoEmergencyContactScreen(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmergencyContactScreen(userID: uid)));
  }

  void navigatetoAccessibilityFeaturesScreen(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AccessibilityFeatures()));
  }

  void navigatetoPersonalNotesScreen(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonalNoteScreen(userID: uid)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2D3047), Color(0xFFACBED8)]),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 90),
            Container(
              color: Colors.transparent,
              child: const ListTile(
                title: Text(
                  "Privacy",
                  style: TextStyle(
                    color: Color(0xFFF8CD51),
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: const ListTile(
                title: Text(
                  "Credits",
                  style: TextStyle(
                    color: Color(0xFFF8CD51),
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(
              color: Colors.white,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            drawerMenuOption(
                label: "Profile",
                icon: Icons.account_circle,
                ftor: () {
                  navigatetoEmergencyContactScreen(context);
                }),
            drawerMenuOption(
                label: "Accessibility",
                icon: Icons.settings,
                ftor: () {
                  navigatetoAccessibilityFeaturesScreen(context);
                }),
            drawerMenuOption(
                label: "My Circle",
                icon: Icons.people,
                ftor: () {
                  navigatetoPersonalNotesScreen(context);
                }),
            drawerMenuOption(
                label: "Old Media",
                icon: Icons.perm_media,
                ftor: () {
                  navigatetoPersonalNotesScreen(context);
                }),
            const Divider(
              thickness: 2,
              color: Color(0xFFFFFFFF),
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 60),
            Container(
              color: Colors.transparent,
              child: ListTile(
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_outlined,
                      color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
