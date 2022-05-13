import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//import 'package:email_validator/email_validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextController =
      TextEditingController(text: ' ');
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
  }

  void _submitLoginForm() {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {}
  }

  //  <
  AppBar banner() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text('MediHealth',
          style: TextStyle(fontFamily: 'Oleo Script Swash Caps')),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

// ________________________________________________________________________
// Login                              Don't have an account? Register here
// ________________________________________________________________________

  Column forgotpasswordDontworryFillemail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        // Login
        Center(
            child: Text('Forgot password?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ))),
        Center(
          child: Text('Don\'t worry!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )),
        ),
        Center(
          child: Text('Fill in your email and we will send the steps',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )),
        ),
      ],
    );
  }

  SizedBox verticalSpace(double desiredHeight) {
    return SizedBox(height: desiredHeight);
  }

  RichText mandatoryHeader(String desiredHeader) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: desiredHeader,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          const TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Form email() {
    return Form(
      key: _loginFormKey,
      child: emailField(),
    );
  }

  Column emailField() {
    return Column(children: [
      Align(alignment: Alignment.bottomLeft, child: mandatoryHeader("Email: ")),
      emailValidation()
    ]);
  }

  TextFormField emailValidation() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      validator: (email) {
        if (email!.isEmpty || !email.contains('@')) {
          return "Please enter a valid email address";
        } else {
          return null;
        }
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Format: someone@example.com',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  MaterialButton submitButton() {
    return MaterialButton(
      onPressed: _submitLoginForm,
      color: const Color(0xFFc70039),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.ads_click_outlined,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  RichText backToLogin() {
    return RichText(
      text: TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap =
              () => Navigator.canPop(context) ? Navigator.pop(context) : null,
        text: 'Back to login',
        style: const TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }

  Container loginPageContent() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          //border: Border.all(color: Colors.black),
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Color(0xFFFF0000),
        Color(0xFFFFA500),
        Color(0xFFFFD700)
      ])),
      child: Column(
        children: [
          forgotpasswordDontworryFillemail(),
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  // constrain height of List [Email, Password]
                  child: Column(
                    children: [
                      verticalSpace(20),
                       // Back to Login
                      backToLogin(),
                      // Email
                      email(),
                      // *******************************************************
                      verticalSpace(100),
                      // Submit button
                      submitButton(),
                     
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
      //MEDIHEALTH
      //appBar: banner(),
      body: loginPageContent(),
    );
  }
}
