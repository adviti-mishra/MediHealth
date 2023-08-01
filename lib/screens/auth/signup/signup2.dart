import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/utils_all.dart';
import 'package:flutter/gestures.dart';
import 'package:practice_app/screens/auth/signup/signup.dart';
import 'package:practice_app/screens/auth/signup/signup2_tile.dart';
import 'package:practice_app/screens/auth/signup/signup2_message.dart';
import 'package:practice_app/screens/auth/login/login_page.dart';


class SignUp2 extends StatefulWidget {
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController rePasswordTextController;


  SignUp2({
    required this.emailTextController,
    required this.passwordTextController,
    required this.rePasswordTextController,
    Key? key,
  }) : super(key: key);

  @override
  _SignUpState2 createState() => _SignUpState2();
}

class _SignUpState2 extends State<SignUp2> {
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  final TextEditingController _dobTextController = TextEditingController();
  
  final _signUpFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signUpPageContent(context),
    );
  }

  Container signUpPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          verticalSpace(60),
          welcomeIn2Message(context),
          signUp2Tile(
            nameDOBPhone: nameDOBPhone(),
            createButton: createButton(),
            backButton: backButton()
          ),
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
    _dobTextController.dispose();
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

        FirebaseFirestore.instance.collection('user').doc(_uid).set({
          'id': _uid,
          'firstName': _firstNameTextController.text,
          'lastName': _lastNameTextController.text,
          'email': widget.emailTextController.text,
          'phoneNumber': _phoneNumberTextController.text,
          'dob': _dobTextController.text,
          'createdAt': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
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
  Form nameDOBPhone() {
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
          dobField(),
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
              SizedBox(width: 16),
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
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'First Name',
        hintStyle: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: TextStyle(
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
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Last Name',
        hintStyle: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: TextStyle(
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
        child: Row(
          children: [
            Text(
              "Phone Number",
              style: TextStyle(
                color: ColorShades.primaryColor4,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        )
      ),
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
        }
        else if (value.length != 10) {
          return "Phone number must be 10 digits";
        }
        else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: '##########',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
    cursorColor: Colors.black,
    );
  }

  // DOB Number
  Column dobField() {
    return Column(children: [
      Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Text(
              "Date of Birth",
              style: TextStyle(
                color: ColorShades.primaryColor4,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        )
      ),
      verticalSpace(10),
      dobValidation(),
    ]);
  }

  // DOB Validation
  TextFormField dobValidation() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: _dobTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your date of birth";
        }
        else if (value.length != 8) {
          return "Enter in format MMDDYYYY";
        }
        else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: 'MM/DD/YYYY',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
    cursorColor: Colors.black,
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
          children: const [
            Text(
              'Create Account',
              style: TextStyle(
                color: Color(0xff102542),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.login,
              color: Color(0xff102542),
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
          context,
          MaterialPageRoute(
            builder: (context) => const SignUp()
          )
        );
      },
      color: ColorShades.primaryColor4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Back',
              style: TextStyle(
                color: Color(0xff102542),
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
          context,
          MaterialPageRoute(
            builder: (context) => const Login()
          )
        );
      },
      child: const Text(
        "Already have an account? Login",
        style: TextStyle(
          color: Color(0xff102542),
          fontSize: 24,
        ),
      )
    );
  }
}
