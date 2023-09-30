import 'package:flutter/material.dart';
import 'package:practice_app/screens/drawer_screens/my_circle.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class JoinCircle extends StatefulWidget {
  JoinCircle({Key? key}) : super(key: key);

  @override
  _JoinCircleState createState() => _JoinCircleState();
  final scaffoldKey = GlobalKey<ScaffoldState>();
}

void joinCircle(String code, BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (code.length != 6) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Invalid code'),
      backgroundColor: Colors.red,
    ));
    return;
  }

  if (code != "") {
    // Update Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    users.doc(user!.uid).update({'circleId': code});

  }
}

class _JoinCircleState extends State<JoinCircle> {
  String code = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Join a Circle!",
                  style: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontSize: 40 * fontSizeMultiplier,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Tahoma',
                  ),
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Click to start typing',
                        labelStyle: TextStyle(
                          color: ColorShades.primaryColor1,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tahoma',
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                    onPressed: () {
                      joinCircle(code, context);
                      if (code.length == 6) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyCircle()));
                      }
                    },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Join a Circle',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tahoma',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorShades.primaryColor1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
