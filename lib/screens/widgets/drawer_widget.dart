import 'package:flutter/material.dart';
import '../../constants/color_shades.dart';

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
                    child: Text('Sign out',
                        style: TextStyle(color: ColorShades.text2)))
              ],
            ),
            content: Text("Do you want to sign out?",
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
        drawerMenuOption(label: "Account", icon: Icons.person, ftor: () {}),
        const SizedBox(height: 30),
        drawerMenuOption(
            label: "Emergency contacts", icon: Icons.people, ftor: () {}),
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
            label: "Logout",
            icon: Icons.logout_outlined,
            ftor: () {
              logOutPopup(context);
            })
      ]),
    );
  }
}
