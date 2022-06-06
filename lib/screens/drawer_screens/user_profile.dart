import 'package:flutter/material.dart';
import 'package:practice_app/utils/utils_all.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
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
      ])*/),
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
                      userField(
                          header_in: 'First name: ', content_in: 'Adviti'),
                      verticalSpace(20),
                      // Last name
                      userField(header_in: 'Last name: ', content_in: 'Mishra'),
                      verticalSpace(20),
                      // Email
                      userField(
                          header_in: 'Email: ',
                          content_in: 'advitimishra@gmail.com'),
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
                style: TextStyle(
                    color: ColorShades.text1,
                    fontSize: 20))),
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
      body: userProfileContent(),
    );
  }
}
