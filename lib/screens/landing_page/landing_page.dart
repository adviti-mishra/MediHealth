import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:practice_app/utils/app_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String welcomeMessage = "Hello, ";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? currentUserCircleID;

  Future<void> fetchData() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('user').doc(uid);
      DocumentSnapshot doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        welcomeMessage = "Hello, " + data['firstName'];
        currentUserCircleID = data['circleId'];
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
          welcomeMessage,
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
        currentUserCircleID == null
            ? CircularProgressIndicator()
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .where('circleId', isEqualTo: currentUserCircleID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No users in this circle.');
                  }
                  return Column(
                    children: snapshot.data!.docs
                        .where((doc) =>
                            doc.id !=
                            FirebaseAuth.instance.currentUser!
                                .uid) // Filtering out current user
                        .map((doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      return userText(
                        message: data[
                            'firstName'], // passing only the first name to userText
                        imagePath: 'assets/images/user.png',
                        key: Key(doc.id),
                      );
                    }).toList(),
                  );
                },
              ),
      ],
    );
  }

  Widget userText(
      {required String message, required String imagePath, required Key key}) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 8),
                Text(
                  message, // Displaying the first name under the profile picture
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
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
                "I'm looking forward to seeing " + message,
                style: TextStyle(
                    color: Colors.white, fontSize: 24 * fontSizeMultiplier),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
