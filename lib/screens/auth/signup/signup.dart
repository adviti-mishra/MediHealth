import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';
import 'package:flutter/gestures.dart';
import 'package:practice_app/screens/auth/signup/signup_message.dart';
import 'package:practice_app/screens/auth/signup/signup_tile.dart';
import 'package:practice_app/screens/auth/welcome/welcome_page.dart';
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
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();

  bool _obscureText = true;
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
            nameEmailPassword: nameEmailPassword(),
            createButton: createButton()
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

// Name, Email, Password
  Form nameEmailPassword() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          // Name
          nameField(),
          // BLANK LINE
          verticalSpace(5),
          // Email
          emailField(),
          // BLANK LINE
          verticalSpace(5),
          // Password
          passwordField(),
          // BLANK LINE
          verticalSpace(5),
          // Password
          rePasswordField(),
          // BLANK LINE
          verticalSpace(5),
          // Phone number
          phoneNumberField(),
        ],
      ),
    );
  }

  // Name field
  Column nameField() {
    return Column(children: [
      Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Text(
              "Full Name",
              style: TextStyle(
                color: ColorShades.maize,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        )
      ),
      nameValidation(),
    ]);
  }
  
  // Name validation
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
        hintText: 'FirstName LastName',
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
                color: ColorShades.maize,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        )
      ),
      phoneNumberValidation(),
    ]);
  }

  // Phone Number Validation
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
                  color: ColorShades.maize,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          )
        ),
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
        } else {
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
                  color: ColorShades.maize,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          )
        ),
        passwordValidation(),
      ],
    );
  }

  TextFormField passwordValidation() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordTextController,
      validator: (value) {
        if (value!.isEmpty || value.length < 8) {
          return "Please enter password with at least 8 characters";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
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
                  color: ColorShades.maize,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          )
        ),
        rePasswordValidation(),
      ],
    );
  }

  TextFormField rePasswordValidation() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: _rePasswordTextController,
      validator: (value) {
        if (value!.isEmpty || value != _passwordTextController) {
          return "Please make sure passwords match";
        } else {
          return null;
        }
      },
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
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
      color: ColorShades.maize,
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
          fontSize: 20,
        ),
      )
    );
  }

  // Back Button
  TextButton backWelcomeButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcome()
          )
        );
      },
      child: const Text(
        "Back",
        style: TextStyle(
          color: Color(0xff102542),
          fontSize: 24,
        ),
      )
    );
  }
}
