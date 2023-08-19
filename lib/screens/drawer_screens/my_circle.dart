import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'package:practice_app/utils/color_shades.dart';
import 'dart:math' as math;

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({Key? key, this.size = 50.0}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorShades.primaryColor1,
      ),
      child: Center(
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: size * 0.7,
        ),
      ),
    );
  }
}

class InviteButton extends StatelessWidget {
  const InviteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the profile page here
        // You can replace "UserProfile()" with the actual route you want to navigate to
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfile(userID: "YOUR_USER_ID"),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: ColorShades.primaryColor1, // Set the button color here
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                8)), // Make the button a rectangle with rounded corners
      ),
      child: Text(
        'Invite members to your circle',
        style: TextStyle(
          color: ColorShades.primaryColor4, // Set the text color to yellow
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

class MyCircle extends StatelessWidget {
  MyCircle({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'My Circle',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF102542),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tahoma',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60), // Move the animation up

                // Move main profile circle to the middle of the screen
                Container(
                  width: 320,
                  height: 320,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Smaller circles positioned around the main profile circle
                      for (int i = 0; i < 6; i++)
                        Positioned(
                          top: 130 + 130 * math.cos(i * 2 * math.pi / 6),
                          left: 127 +
                              130 *
                                  math.sin(i *
                                      2 *
                                      math.pi /
                                      6), // Move slightly to the left
                          child: ProfileCircle(size: 60.0),
                        ),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorShades.primaryColor1,
                        ),
                      ),
                      Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorShades.primaryColor4,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100), // Increase spacing at the bottom
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: InviteButton(), // Add the InviteButton here
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
