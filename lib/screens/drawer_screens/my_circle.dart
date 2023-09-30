import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:practice_app/screens/drawer_screens/user_profile.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfile(userID: "YOUR_USER_ID"),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorShades.primaryColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Invite members to your circle',
        style: TextStyle(
          color: ColorShades.primaryColor4,
          fontWeight: FontWeight.bold,
          fontSize: 18 * fontSizeMultiplier,
        ),
      ),
    );
  }
}

class MyCircle extends StatefulWidget {
  MyCircle({Key? key}) : super(key: key);

  @override
  _MyCircleState createState() => _MyCircleState();
}

class _MyCircleState extends State<MyCircle> {
  bool? isCircleOwner;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;

    setState(() {
      isCircleOwner = data['isCircleOwner'] as bool?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'My Circle',
                  style: TextStyle(
                    fontSize: 20 * fontSizeMultiplier,
                    color: ColorShades.primaryColor1,
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
                const SizedBox(height: 60),
                Container(
                  width: 320,
                  height: 320,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      for (int i = 0; i < 6; i++)
                        Positioned(
                          top: 130 + 130 * math.cos(i * 2 * math.pi / 6),
                          left: 127 + 130 * math.sin(i * 2 * math.pi / 6),
                          child: const ProfileCircle(size: 60.0),
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
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: isCircleOwner == true ? const InviteButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
