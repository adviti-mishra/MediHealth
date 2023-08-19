import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';
import 'package:flutter/gestures.dart';
import 'package:practice_app/screens/auth/signup/signup_message.dart';
import 'package:practice_app/screens/auth/signup/signup_tile.dart';
import 'package:practice_app/screens/auth/signup/signup2.dart';
import 'package:practice_app/screens/auth/login/login_page.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _rePasswordTextController = TextEditingController();
  final TextEditingController _dobTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();

  bool _passwordObscureText = true;
  bool _rePasswordObscureText = true;
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
          verticalSpace(80),
          welcomeInMessage(context),
          signUpTile(
            emailPasswords: emailPasswords(),
            nextButton: nextButton()
          ),
          loginPageButton(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _dobTextController.dispose();
    _nameTextController.dispose();
    _phoneNumberTextController.dispose();
  }

// Email and Password
  Form emailPasswords() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          // Email
          emailField(),
          // BLANK LINE
          verticalSpace(20),
          // Password number
          passwordField(),
          // BLANK LINE
          verticalSpace(20),
          // Repeeat Password number
          rePasswordField(),
        ],
      ),
    );
  }

  Column emailField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text(
                "Email",
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
        emailValidation(),
      ],
    );
  }

  TextFormField emailValidation() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      validator: (email) {
        if (email!.isEmpty) {
          return "Please enter a valid email address";
        } 
        else if (!email.contains('@') || !email.contains('.')) {
          return "Email address is not valid";
        }
        else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: 'name@example.com',
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

  Column passwordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text(
                "Password",
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
        passwordValidation(),
      ],
    );
  }

  TextFormField passwordValidation() {
    return TextFormField(
      obscureText: _passwordObscureText,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a password";
        } 
        else if (value.length < 8) {
          return "Password must contain at least 8 characters";
        }
        else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _passwordObscureText = !_passwordObscureText;
            });
          },
          child: Icon(
            _passwordObscureText ? Icons.visibility_off : Icons.visibility, 
            color: Color(0xff102542)
          ),
        ),
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

  Column rePasswordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text(
                "Repeat Password",
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
        rePasswordValidation(),
      ],
    );
  }

  TextFormField rePasswordValidation() {
    return TextFormField(
      obscureText: _rePasswordObscureText,
      keyboardType: TextInputType.visiblePassword,
      controller: _rePasswordTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please repeat password";
        } 
        else if (value != _passwordTextController.text) {
          return "Password does not match";
        }
        else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _rePasswordObscureText = !_rePasswordObscureText;
            });
          },
          child: Icon(
            _rePasswordObscureText ? Icons.visibility_off : Icons.visibility, 
            color: Color(0xff102542)
          ),
        ),
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

  MaterialButton nextButton() {
  return MaterialButton(
    onPressed: () {
      if (_signUpFormKey.currentState!.validate()) {
        // All fields are valid, proceed to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp2(
              emailTextController: _emailTextController,
              passwordTextController: _passwordTextController,
              rePasswordTextController: _rePasswordTextController,
            ),
          ),
        );
      }
    },
    color: ColorShades.primaryColor4,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Next',
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
