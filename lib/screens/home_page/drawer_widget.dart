import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/accessibility/accessibility_features.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'package:practice_app/screens/drawer_screens/emergency_contacts/emergency_contact_screen.dart';
import '../../utils/color_shades.dart';
import '../drawer_screens/personal_notes/personal_note_screen.dart';
import '../drawer_screens/statistics.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  Card drawerMenuOption(
      {required String label, required IconData icon, required Function ftor}) {
    return Card(
        //color: ColorShades.primaryColor1,
        //elevation: 16,
        child: ListTile(
            onTap: () {
              ftor();
            },
            leading: Icon(icon, color: ColorShades.text2),
            title: Text(label,
                style: TextStyle(fontSize: 20, color: ColorShades.text2))));
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

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserProfile(userID: uid)));
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

  void navigatetoStatisticsScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Statistics()));
  }

  void navigatetoAccessibilityFeaturesScreen(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AccessibilityFeatures()));
  }

  void navigatetoPersonalNotesScreen(context){
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
     Navigator.push(context,
        MaterialPageRoute(builder: (context) => PersonalNoteScreen(userID: uid)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorShades.primaryColor2,
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(color: ColorShades.text1),
          child: Image.asset('assets/images/MediHealth_logo.png'),
        ),
        // const Divider(thickness: 2.0, color: Colors.black),
        drawerMenuOption(
            label: "Account",
            icon: Icons.person,
            ftor: () {
              navigatetoUserProfileScreen(context);
            }),
        // const Divider(thickness: 2.0, color: Colors.black),
        drawerMenuOption(
            label: "Emergency contacts",
            icon: Icons.people,
            ftor: () {
              navigatetoEmergencyContactScreen(context);
            }),
        // const Divider(thickness: 2.0, color: Colors.black),
        drawerMenuOption(
            label: "Statistics on medicine usage",
            icon: Icons.auto_graph_rounded,
            ftor: () {
              navigatetoStatisticsScreen(context);
            }),
        // const Divider(thickness: 2.0, color: Colors.black),
        drawerMenuOption(
            label: "Accessibility features",
            icon: Icons.settings,
            ftor: () {
              navigatetoAccessibilityFeaturesScreen(context);
            }),
         // const Divider(thickness: 2.0, color: Colors.black),
          drawerMenuOption(
            label: "Personal note page",
            icon: Icons.note,
            ftor: () {
              navigatetoPersonalNotesScreen(context);
            }),
        // const Divider(thickness: 2.0, color: Colors.black),
        Divider(
          thickness: 2,
          color: ColorShades.text1,
        ),
        const SizedBox(height: 30),
        drawerMenuOption(
            label: "Log out",
            icon: Icons.logout_outlined,
            ftor: () {
              logOutPopup(context);
            })
      ]),
    );
  }
}
