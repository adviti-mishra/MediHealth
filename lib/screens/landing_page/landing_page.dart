import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:practice_app/screens/landing_page/message_screen.dart';
import 'package:practice_app/utils/app_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String welcomeMessage = "Hello, ";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchData() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('user').doc(uid);
      DocumentSnapshot doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      String firstName = data['firstName'];
      String message = firstName;
      setState(() {
        welcomeMessage = message;
      });
    } catch (e) {
      print("Error getting document: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget userText(
      {required String message, required String imagePath, required Key key}) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(
                    imagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 40),
            Container(
              width: 250,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ColorShades.primaryColor1,
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                    color: Colors.white, fontSize: 24 * fontSizeMultiplier),
              ),
            ),
            // MessageScreen(
            //   key: key,
            //   message: message,
            // ),
          ],
        ),
      ],
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
            child: landingPageContent(),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget landingPageContent() {
    return Column(
      children: [
        Text(
          "Hello, " + welcomeMessage,
          style: TextStyle(
            color: ColorShades.primaryColor1,
            fontSize: 40 * fontSizeMultiplier,
            fontWeight: FontWeight.w700,
            fontFamily: 'Tahoma',
          ),
        ),
        const SizedBox(height: 30),
        Text(
          "Welcome back to your account",
          style: TextStyle(
            color: ColorShades.primaryColor1,
            fontSize: 24 * fontSizeMultiplier,
            fontWeight: FontWeight.w400,
            fontFamily: 'Tahoma',
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Center(
            child: Column(
              children: [
                userText(
                  message: "I'm looking forward to seeing...",
                  imagePath: 'assets/images/user.png',
                  key: const Key('0'),
                ),
                userText(
                  message: "I'm looking forward to seeing...",
                  imagePath: 'assets/images/user.png',
                  key: const Key('1'),
                ),
                userText(
                  message: "I'm looking forward to seeing...",
                  imagePath: 'assets/images/user.png',
                  key: const Key('2'),
                ),
                userText(
                  message: "I'm looking forward to seeing...",
                  imagePath: 'assets/images/user.png',
                  key: const Key('3'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
