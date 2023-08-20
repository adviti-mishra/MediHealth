import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_app/screens/landing_page/landing_page.dart';
import 'package:practice_app/utils/models.dart';
import 'package:practice_app/utils/utils_all.dart';
import 'package:practice_app/screens/auth/signup/signup.dart';
import 'package:practice_app/screens/auth/signup/signup2_tile.dart';
import 'package:practice_app/screens/auth/signup/signup2_message.dart';
import 'package:practice_app/screens/auth/login/login_page.dart';

class SignUp2 extends StatefulWidget {
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController rePasswordTextController;

  const SignUp2({
    required this.emailTextController,
    required this.passwordTextController,
    required this.rePasswordTextController,
    Key? key,
  }) : super(key: key);

  @override
  _SignUpState2 createState() => _SignUpState2();
}

class _SignUpState2 extends State<SignUp2> {
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  String? _circleOwnerTextController;

  final _signUpFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isCircleOwner = false;

  String randomCircleCode() {
    String code = '';
    const alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const codeLength = 6;

    for (int i = 0; i < codeLength; i++) {
      code += alpha[Random().nextInt(26)];
    }

    return code;
  }

  String randomProfileCode() {
    String code = '';
    const alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const codeLength = 8;

    for (int i = 0; i < codeLength; i++) {
      code += alpha[Random().nextInt(26)];
    }

    return code;
  }

  Future<bool> checkCircleCode(String circleCode) async {
    final db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection('circles')
        .where('circleId', isEqualTo: circleCode)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> checkProfileCode(String profileCode) async {
    final db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection('users')
        .where('profileCode', isEqualTo: profileCode)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signUpPageContent(context),
    );
  }

  Container signUpPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          verticalSpace(60),
          welcomeIn2Message(context),
          signUp2Tile(
              namePhone: namePhone(),
              createButton: createButton(),
              backButton: backButton()),
          loginPageButton(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _phoneNumberTextController.dispose();
  }

  void _submitSignUpForm() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
          email: widget.emailTextController.text.trim().toLowerCase(),
          password: widget.passwordTextController.text,
        );
        final User? user = _auth.currentUser;
        final _uid = user!.uid;

        Timestamp now = Timestamp.now();
        String circleId = "";
        String profileCode = "";

        if (_isCircleOwner) {
          do {
            circleId = randomCircleCode();
          } while (await checkCircleCode(circleId));
        }

        do {
          profileCode = randomProfileCode();
        } while (await checkProfileCode(profileCode));

        final newUser = UserCustom(
          circleId: circleId,
          createdAt: now,
          email: widget.emailTextController.text,
          firstName: _firstNameTextController.text,
          isCircleOwner: _isCircleOwner,
          lastName: _lastNameTextController.text,
          phoneNumber: _phoneNumberTextController.text,
          profileCode: profileCode,
        );

        final db = FirebaseFirestore.instance;
        final docRef = db
            .collection('user')
            .withConverter(
              fromFirestore: UserCustom.fromFirestore,
              toFirestore: (UserCustom user, options) => user.toFirestore(),
            )
            .doc(_uid);
        await docRef.set(newUser);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LandingPage(),
          ), // Replace `YourNextPage` with the actual page you want to navigate to.
          (Route<dynamic> route) => false,
        );
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        errorPopup(context, error.toString());
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

// Name, DOB, Phone Number
  Form namePhone() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          nameField(),
          // BLANK LINE
          verticalSpace(20),
          // Phone
          phoneNumberField(),
          // BLANK LINE
          verticalSpace(20),
          // DOB
          circleOwnerField(),
        ],
      ),
    );
  }

  // Name field
  Column nameField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Full Name",
            style: TextStyle(
              color: ColorShades.primaryColor4,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        verticalSpace(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            children: [
              Expanded(
                child: firstNameValidation(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: lastNameValidation(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextFormField firstNameValidation() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _firstNameTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your first name";
        } else {
          return null;
        }
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'First Name',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      cursorColor: Colors.black,
    );
  }

  TextFormField lastNameValidation() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _lastNameTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your last name";
        } else {
          return null;
        }
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Last Name',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      cursorColor: Colors.black,
    );
  }

  // Phone Number
  Column phoneNumberField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: Row(children: [
            Text(
              "Phone Number",
              style: TextStyle(
                color: ColorShades.primaryColor4,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ])),
      verticalSpace(10),
      phoneNumberValidation(),
    ]);
  }

  // Phone Number Validation
  TextFormField phoneNumberValidation() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: _phoneNumberTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your phone number";
        } else if (value.length != 10) {
          return "Phone number must be 10 digits";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: '##########',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      cursorColor: Colors.black,
    );
  }

  // Whether you are an Owner
  Column circleOwnerField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: Row(children: [
            Text(
              "Will You Own the Circle?",
              style: TextStyle(
                color: ColorShades.primaryColor4,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ])),
      verticalSpace(10),
      circleOwnerValidation(),
    ]);
  }

  // Owner Validation
  DropdownButtonFormField<bool> circleOwnerValidation() {
    return DropdownButtonFormField<bool>(
      value: _isCircleOwner,
      onChanged: (newValue) {
        setState(() {
          _isCircleOwner = newValue!;
        });
      },
      validator: (value) {
        if (_isCircleOwner == null) {
          return "Please select an answer";
        }
        return null;
      },
      items: const [
        DropdownMenuItem<bool>(
          value: true,
          child: Text('Yes, I will own the circle'),
        ),
        DropdownMenuItem<bool>(
          value: false,
          child: Text('No, I am a participant'),
        ),
      ],
    );
  }

  MaterialButton createButton() {
    return MaterialButton(
      onPressed: _submitSignUpForm,
      color: ColorShades.primaryColor4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                color: ColorShades.primaryColor1,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.login,
              color: ColorShades.primaryColor1,
            )
          ],
        ),
      ),
    );
  }

  MaterialButton backButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignUp()));
      },
      color: ColorShades.primaryColor4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Back',
              style: TextStyle(
                color: ColorShades.primaryColor1,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Login Page Button
  TextButton loginPageButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        },
        child: Text(
          "Already have an account? Login",
          style: TextStyle(
            color: ColorShades.primaryColor1,
            fontSize: 24,
          ),
        ));
  }
}
