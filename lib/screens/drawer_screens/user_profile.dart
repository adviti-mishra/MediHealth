import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/utils/app_bar.dart';
import 'package:practice_app/utils/bottom_bar.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:practice_app/utils/drawer_widget.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.userID}) : super(key: key);
  final String userID;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool editMode = false;
  bool _isLoading = false;
  int phoneNumber = 0;
  String profileCode = "";
  String firstname = "";
  String lastname = "";
  String email = "";
  String createdAt = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> _changeProfilePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Here, you can handle the selected image, e.g., upload to Firebase Storage.
      // For simplicity, we'll just update the profile picture locally.
      setState(() {
        // Update the profile picture using the selected image path.
        // For example, you can use `pickedImage.path` as the new image URL.
        // Replace 'YOUR_NEW_PROFILE_PICTURE_URL' with the actual URL.
        // userProfileImageUrl = YOUR_NEW_PROFILE_PICTURE_URL;
      });
    }
  }

  void getUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();
      final data = userDoc.data() as Map<String, dynamic>;

      print((data['profileCode']));
      setState(() {
        email = data['email'];
        firstname = data['firstName'];
        lastname = data['lastName'];
        phoneNumber = data['phoneNumber'];
        profileCode = data['profileCode'];
      });
    } catch (error) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget userField({required String headerIn, required String contentIn}) {
    return Row(
      children: [
        Text(
          headerIn,
          style: TextStyle(
            fontSize: 18 * fontSizeMultiplier,
            color: ColorShades.primaryColor1,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tahoma',
          ),
        ),
        const SizedBox(width: 8),
        Text(
          contentIn,
          style: TextStyle(
            fontSize: 18 * fontSizeMultiplier,
            color: ColorShades.primaryColor1,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tahoma',
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
              fontSize: 20 * fontSizeMultiplier,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tahoma',
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20 * fontSizeMultiplier,
                    color: ColorShades.primaryColor1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tahoma',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: ColorShades.primaryColor1,
                    child: CircleAvatar(
                      radius: 78,
                      backgroundColor: ColorShades.primaryColor4,
                      child: Icon(
                        Icons.account_circle,
                        size: 160,
                        color: ColorShades.primaryColor1,
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
                          backgroundColor: ColorShades.primaryColor1,
                          child: Icon(
                            Icons.camera_alt,
                            color: ColorShades.primaryColor4,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Profile Code: ',
                  style: TextStyle(
                    fontSize: 18 * fontSizeMultiplier,
                    color: ColorShades.primaryColor1,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Tahoma',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  profileCode,
                  style: TextStyle(
                    fontSize: 18 * fontSizeMultiplier,
                    color: ColorShades.primaryColor1,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Tahoma',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                        fontSize: 18 * fontSizeMultiplier,
                        color: ColorShades.primaryColor1,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Tahoma',
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.account_tree_sharp,
                      color: ColorShades.primaryColor1,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'First Name: ',
                      style: TextStyle(
                        fontSize: 18 * fontSizeMultiplier,
                        color: ColorShades.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tahoma',
                      ),
                    ),
                    Text(
                      firstname,
                      style: TextStyle(
                        fontSize: 18 * fontSizeMultiplier,
                        color: ColorShades.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tahoma',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Last Name: ',
                      style: TextStyle(
                        fontSize: 18 * fontSizeMultiplier,
                        color: ColorShades.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tahoma',
                      ),
                    ),
                    Text(
                      lastname,
                      style: TextStyle(
                        fontSize: 18 * fontSizeMultiplier,
                        color: ColorShades.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tahoma',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Email: ',
                      style: TextStyle(
                        fontSize: 18 * fontSizeMultiplier,
                        color: ColorShades.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tahoma',
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 18 * fontSizeMultiplier,
                        color: ColorShades.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tahoma',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    editMode = true;
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: const Text(
                  'Edit profile information',
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
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView editProfileContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: ColorShades.primaryColor1,
                  child: CircleAvatar(
                    radius: 78,
                    backgroundColor: ColorShades.primaryColor4,
                    child: Icon(
                      Icons.account_circle,
                      size: 160,
                      color: ColorShades.primaryColor1,
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
                      backgroundColor: ColorShades.primaryColor1,
                      child: Icon(
                        Icons.camera_alt,
                        color: ColorShades.primaryColor4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'Change profile picture',
                style: TextStyle(
                  fontSize: 18 * fontSizeMultiplier,
                  color: ColorShades.primaryColor1,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Tahoma',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'First Name:',
                style: TextStyle(
                  fontSize: 18 * fontSizeMultiplier,
                  color: ColorShades.primaryColor1,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tahoma',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                initialValue: firstname,
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
                    firstname = value;
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Last Name:',
                style: TextStyle(
                  fontSize: 18 * fontSizeMultiplier,
                  color: ColorShades.primaryColor1,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tahoma',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                initialValue: lastname,
                decoration: InputDecoration(
                  labelText: 'Click to start typing',
                  labelStyle: TextStyle(
                    color: ColorShades.primaryColor1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tahoma',
                  ),
                ),
                onChanged: (value) => setState(() => lastname = value),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Email:',
                style: TextStyle(
                  fontSize: 18 * fontSizeMultiplier,
                  color: ColorShades.primaryColor1,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tahoma',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                    color: ColorShades.primaryColor1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tahoma',
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
          const SizedBox(height: 20),
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
                child: const Text(
                  'Save edits',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Tahoma',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorShades.primaryColor1,
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
      drawer: const DrawerWidget(),
      appBar: MediAppBar(importedKey: scaffoldKey),
      key: scaffoldKey,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                if (!editMode) userProfileContent(),
                if (editMode) editProfileContent(),
              ],
            ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
