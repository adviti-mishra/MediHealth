import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

class UserProfile extends StatefulWidget {
  final String userID;

  const UserProfile({required this.userID});
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  bool _isLoading = false;
  String phoneNumber = "";
  String name = "";
  String email = "";
  String createdAt = "";

  void getUserData() async {
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.userID)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
          phoneNumber = userDoc.get('phoneNumber');
        });
      }
    } catch (error) {} finally {
      _isLoading = false;
    }
  }

  Column userInformationEditProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text('Customize your profile below',
              style: TextStyle(
                color: ColorShades.text1,
                fontSize: 20,
              )),
        ),
      ],
    );
  }

  Container userProfileContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black),
        color: ColorShades.primaryColor3,
        /*
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        ColorShades.secondaryColor2,
        ColorShades.secondaryColor3,
        ColorShades.primaryColor3
      ])*/
      ),
      child: Column(
        children: [
          userInformationEditProfile(),
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorShades.text1,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  // constrain height of List [Email, Password]
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      // First name
                      userField(header_in: 'Name: ', content_in: name),
                      verticalSpace(20),
                      // Last name
                      userField(header_in: 'Email: ', content_in: email),
                      verticalSpace(20),
                      // Email
                      userField(
                          header_in: 'Phone number: ', content_in: phoneNumber),
                      // *******************************************************
                      verticalSpace(100),
                      // Login button
                      editButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorShades.primaryColor1,
        title: Center(
            child: Text('User information',
                style: TextStyle(color: ColorShades.text1, fontSize: 20))),
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined,
                  color: ColorShades.text1),
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
            );
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProfileContent(),
    );
  }
}
