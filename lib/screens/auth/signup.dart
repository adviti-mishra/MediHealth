import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:practice_app/screens/auth/login.dart';
import '../../utils/utils_all.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailTextController =
      TextEditingController();
  final TextEditingController _passwordTextController =
      TextEditingController();
  final TextEditingController _firstnameTextController =
      TextEditingController();
  final TextEditingController _lastnameTextController =
      TextEditingController();

  bool _obscureText = true;
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _firstnameTextController.dispose();
    _lastnameTextController.dispose();
  }

  void _submitSignUpForm() {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {}
  }

// ________________________________________________________________________
// Login                              Don't have an account? Register here
// ________________________________________________________________________

  Column signUpWelcome() {
    return Column(
      children: [
        // Login
        Center(
            child: Text('Sign Up',
                style: TextStyle(
                  color: ColorShades.text1,
                  fontSize: 60,
                ))),
        Center(
          child: Text('Welcome to MediHealth!',
              style: TextStyle(
                color: ColorShades.text1,
                fontSize: 30,
              )),
        ),
        Center(
          child: Text('Please fill the following fields',
              style: TextStyle(
                color: ColorShades.text1,
                fontSize: 30,
              )),
        ),
      ],
    );
  }

  RichText loginHere() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Already have an account?',
              style: TextStyle(
                  color: ColorShades.text2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const TextSpan(text: '    '),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Login()));
                },
              text: 'Login here',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: ColorShades.text2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))
        ],
      ),
    );
  }

  Form firstnameLastnameEmailPassword() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          // First name
          firstnameField(),
          // BLANK LINE
          verticalSpace(20),
          // Last name
          lastnameField(),
          // BLANK LINE
          verticalSpace(20),
          // Email
          emailField(),
          // BLANK LINE
          verticalSpace(20),
          // Password
          passwordField(),
        ],
      ),
    );
  }

  Column firstnameField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "First name: ")),
      firstnameValidation()
    ]);
  }

  TextFormField firstnameValidation() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _firstnameTextController,
      validator: (value) {
        if ((value!.isEmpty)) {
          return "Please enter your first name";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: ColorShades.text1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  Column lastnameField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "Last name: ")),
      lastnameValidation()
    ]);
  }

  TextFormField lastnameValidation() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _lastnameTextController,
      validator: (value) {
        if ((value!.isEmpty)) {
          return "Please enter your last name";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: ColorShades.text1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  Column emailField() {
    return Column(children: [
      Align(alignment: Alignment.bottomLeft, child: mandatoryHeader(desiredHeader: "Email: ")),
      emailValidation()
    ]);
  }

  TextFormField emailValidation() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      validator: (email) {
        if (email != null || (email != null && !email.contains('@'))) {
          return "Please enter a valid email address";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: 'Format: someone@example.com',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(
          borderSide:  BorderSide(color: ColorShades.text1, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: ColorShades.text1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  Column passwordField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "Password: ")),
      passwordValidation()
    ]);
  }

  TextFormField passwordValidation() {
    return TextFormField(
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordTextController,
      validator: (value) {
        if (value!.isEmpty || value.length < 8) {
          return "Please enter a password containing more than 8 characters";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: ColorShades.text1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  MaterialButton signUpButton() {
    return MaterialButton(
      onPressed: _submitSignUpForm,
      color: ColorShades.primaryColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign up',
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
              Icons.person_add,
              color: ColorShades.text1,
            )
          ],
        ),
      ),
    );
  }

  Container signUpPageContent() {
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
          Center(child: signUpWelcome()),
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
                  child: SizedBox(
                    height: 600, // constrain height of List [Email, Password]
                    child: ListView(
                      children: [
                        verticalSpace(20),
                        // Already have an account? Login here
                        Center(child: loginHere()),
                        verticalSpace(20),
                        // First name, Last name, Email, Password
                        firstnameLastnameEmailPassword(),
                        // *******************************************************
                        verticalSpace(40),
                        // Sign Up button
                        signUpButton(),
                      ],
                    ),
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
      //MEDIHEALTH
      //appBar: banner(),
      body: signUpPageContent(),
    );
  }
}
