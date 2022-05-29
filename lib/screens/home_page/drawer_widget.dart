import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'package:practice_app/screens/drawer_screens/emergency_contacts/emergency_contact_screen.dart';
import '../../utils/color_shades.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  ListTile drawerMenuOption(
      {required String label, required IconData icon, required Function ftor}) {
    return ListTile(
        onTap: () {
          ftor();
        },
        leading: Icon(icon, color: ColorShades.text2),
        title: Text(label,
            style: TextStyle(fontSize: 20, color: ColorShades.text2)));
  }

  void logOutPopup(context) {
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
                  onPressed: () {},
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UserProfile()));
  }

  void navigatetoEmergencyContactScreen(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EmergencyContactScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorShades.text1,
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(color: ColorShades.text1),
          child: Image.network('assets/images/MediHealth_logo.png'),
        ),
        const SizedBox(height: 30),
        drawerMenuOption(
            label: "Account",
            icon: Icons.person,
            ftor: () {
              navigatetoUserProfileScreen(context);
            }),
        const SizedBox(height: 30),
        drawerMenuOption(
            label: "Emergency contacts",
            icon: Icons.people,
            ftor: () {
              navigatetoEmergencyContactScreen(context);
            }),
        const SizedBox(height: 30),
        drawerMenuOption(
            label: "Statistics on medicine usage",
            icon: Icons.auto_graph_rounded,
            ftor: () {}),
        const SizedBox(height: 30),
        drawerMenuOption(
            label: "Accessibility features", icon: Icons.settings, ftor: () {}),
        const SizedBox(height: 30),
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
