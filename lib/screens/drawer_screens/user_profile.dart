import 'package:flutter/material.dart';
import 'package:practice_app/constants/color_shades.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  SizedBox verticalSpace(double desiredHeight) {
    return SizedBox(height: desiredHeight);
  }

  Text header(String desiredHeader) {
    return Text(desiredHeader,
        style: TextStyle(
          color: ColorShades.text2,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ));
  }

  Text content(String desiredContent) {
    return Text(desiredContent,
        style: TextStyle(
          color: ColorShades.text2,
          fontSize: 30,
        ));
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
                fontSize: 30,
              )),
        ),
      ],
    );
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

  MaterialButton logoutButton() {
    return MaterialButton(
      onPressed: () {
        logOutPopup(context);
      },
      color: ColorShades.primaryColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Logout',
              style: TextStyle(
                color: ColorShades.text1,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.logout,
              color: ColorShades.text1,
            )
          ],
        ),
      ),
    );
  }

  Row userField({required String header_in, required String content_in}) {
    return Row(
  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        header(header_in),
        //const SizedBox(width: 50),
        content(content_in),
        //const SizedBox(width: 50),
        const Expanded(child: Icon(Icons.edit))
      ],
    );
  }

  Container userProfileContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          //border: Border.all(color: Colors.black),
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        ColorShades.secondaryColor2,
        ColorShades.secondaryColor3,
        ColorShades.primaryColor3
      ])),
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
                      children: [
                        verticalSpace(20),
                        // First name
                        userField(
                            header_in: 'First name: ', content_in: 'Adviti'),
                        verticalSpace(20),
                        // Last name
                        userField(
                            header_in: 'Last name: ', content_in: 'Mishra'),
                        verticalSpace(20),
                        // Email
                        userField(
                            header_in: 'Email: ',
                            content_in: 'advitimishra@gmail.com'),
                        // *******************************************************
                        verticalSpace(100),
                        // Login button
                        logoutButton(),
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
                    fontFamily: 'Oleo Script Swash Caps',
                    color: ColorShades.text1,
                    fontSize: 40))),
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: ColorShades.text1),
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
