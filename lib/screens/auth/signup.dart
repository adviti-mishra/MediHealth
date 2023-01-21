import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:practice_app/screens/auth/login/login_page.dart';
import 'package:practice_app/screens/home_page/medicine/medicine_screen.dart';
import '../../utils/utils_all.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();

  bool _obscureText = true;
  final _signUpFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameTextController.dispose();
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
            email: _emailTextController.text.trim().toLowerCase(),
            password: _passwordTextController.text);
        final User? user = _auth.currentUser;
        final _uid = user!.uid;

        FirebaseFirestore.instance.collection('user').doc(_uid).set({
          'id': _uid,
          'name': _nameTextController.text,
          'email': _emailTextController.text,
          'phoneNumber': _phoneNumberTextController.text,
          'createdAt': Timestamp.now(),
        });
        /*
            FirebaseFirestore.instance.collection('user').doc(_uid).collection('emergencyContacts').doc().set({
              'name': "",
          'email': "",
          'phoneNumber': "",
        
            }
           
            
            );
   */

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
          child: Text('Please fill the following',
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
          // Name
          nameField(),
          // BLANK LINE
          verticalSpace(20),
          // Email
          emailField(),
          // BLANK LINE
          verticalSpace(20),
          // Password
          passwordField(),
          verticalSpace(20),
          // Phone number
          phoneNumberField(),
        ],
      ),
    );
  }

  Column nameField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "Name: ")),
      nameValidation()
    ]);
  }

  TextFormField nameValidation() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _nameTextController,
      validator: (value) {
        if ((value!.isEmpty)) {
          return "Please enter your name";
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

  Column phoneNumberField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "Phone number: ")),
      phoneNumberValidation()
    ]);
  }

  TextFormField phoneNumberValidation() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _phoneNumberTextController,
      validator: (value) {
        if ((value!.isEmpty)) {
          return "Please enter your phone number";
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
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "Email: ")),
      emailValidation()
    ]);
  }

  TextFormField emailValidation() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      validator: (email) {
        if (email!.isEmpty) {
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
          borderSide: BorderSide(color: ColorShades.text1, width: 2.0),
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

  Widget signUpButton() {
    return _isLoading
        ? Center(
            child: Container(
                width: 70,
                height: 70,
                child: const CircularProgressIndicator()))
        : MaterialButton(
            onPressed: _submitSignUpForm,
            color: ColorShades.primaryColor1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
      decoration: BoxDecoration(color: ColorShades.primaryColor3
          //border: Border.all(color: Colors.black),
          ),
      child: Column(
        children: [
          verticalSpace(60),
          signUpWelcome(),
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorShades.primaryColor2,
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
      body: signUpPageContent(),
    );
  }
}
