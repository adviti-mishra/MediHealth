import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:practice_app/utils/color_shades.dart';

class UserProfile extends StatefulWidget {
  final String userID;

  const UserProfile({required this.userID});

  @override
  _UserProfileState createState() => _UserProfileState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _UserProfileState extends State<UserProfile> {
  bool editMode = false;
  bool _isLoading = false;
  String phoneNumber = "";
  String name = "";
  String email = "";
  String createdAt = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });

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
    } catch (error) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget userField({required String header_in, required String content_in}) {
    return Row(
      children: [
        Text(
          header_in,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF2D3047),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Text(
          content_in,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF2D3047),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Column userInformationEditProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text(
            'Customize your profile below',
            style: TextStyle(
              color: ColorShades.text1,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Container userProfileContent() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2D3047),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Color(0xFF2D3047),
                  child: CircleAvatar(
                    radius: 78,
                    backgroundColor: Colors.yellow[700],
                    child: Icon(
                      Icons.account_circle,
                      size: 160,
                      color: Color(0xFF2D3047),
                    ),
                  ),
                ),
                if (editMode)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Handle change profile picture button click
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF2D3047),
                        child:
                            Icon(Icons.camera_alt, color: Colors.yellow[700]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Your profile code:',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF2D3047),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Share your code',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF2D3047),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.account_tree_sharp,
                    color: Color(0xFF2D3047),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Name:',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2D3047),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2D3047),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Email:',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2D3047),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                email,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2D3047),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  editMode = true;
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              label: Text(
                'Edit profile information',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2D3047),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column editProfileContent() {
    // ... (existing code for editProfileContent())
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Color(0xFF2D3047),
                child: CircleAvatar(
                  radius: 78,
                  backgroundColor: Colors.yellow[700],
                  child: Icon(
                    Icons.account_circle,
                    size: 160,
                    color: Color(0xFF2D3047),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Handle change profile picture button click
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF2D3047),
                    child: Icon(Icons.camera_alt, color: Colors.yellow[700]),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Text(
              'Change profile picture',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF2D3047),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Name:',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF2D3047),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              initialValue: name,
              decoration: InputDecoration(
                labelText: 'Click to start typing',
                labelStyle: TextStyle(
                  color: Color(0xFF2D3047),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Email:',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF2D3047),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              initialValue: email,
              decoration: InputDecoration(
                labelText: 'Click to start typing',
                labelStyle: TextStyle(
                  color: Color(0xFF2D3047),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  editMode = false;
                });
              },
              child: Text(
                'Save edits',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2D3047),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D3047),
        leading: IconButton(
          onPressed: () {
            //navigatetoMenu(context);
          },
          icon: Icon(
            Icons.menu,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        centerTitle: true,
        title: Text(
          'MediHealth',
          style: TextStyle(
            color: Colors.yellow[700],
            fontSize: 40,
            fontFamily: 'Tahoma',
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 60,
        actions: [
          Column(
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.yellow[700],
                size: 30,
              ),
              Text(
                "Help",
                style: TextStyle(
                  color: Colors.yellow[700],
                ),
              )
            ],
          ),
          const SizedBox(width: 20)
        ],
      ),
      // appBar: MediAppBar(importedKey: scaffoldKey),
      // key: scaffoldKey,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                if (!editMode) userProfileContent(),
                if (editMode) editProfileContent(),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF2D3047),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  // Handle back arrow icon click
                },
                icon: Icon(Icons.arrow_back, color: Colors.yellow[700]),
              ),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: UserProfile(userID: 'YOUR_USER_ID')));
}
