import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';
import 'package:practice_app/screens/auth/forgot_password/forgot_password_message.dart';
import 'package:practice_app/screens/auth/forgot_password/forgot_password_tile.dart';
import 'package:practice_app/screens/auth/login/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  final _ForgetPasswordFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: forgetPasswordPageContent(),
    );
  }

// Forgot Password Page Content
  Container forgetPasswordPageContent() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          verticalSpace(200),
          welcomeBackMessage(context),
          forgotPasswordTile(
              recoveryEmail: email(), submitButton: submitButton()),
          backLoginButton(),
        ],
      ),
    );
  }

  ///
  /// FORGOT PASSWORD FORM
  ///

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
  }

  void _submitForgetPasswordForm() async {
    final isValid = _ForgetPasswordFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.sendPasswordResetEmail(
          email: _emailTextController.text.trim().toLowerCase(),
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

  // Recovery email
  Form email() {
    return Form(
      key: _ForgetPasswordFormKey,
      child: emailField(),
    );
  }

  Column emailField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: Row(children: [
            Text(
              "Email",
              style: TextStyle(
                color: ColorShades.primaryColor4,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ])),
      verticalSpace(10),
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
        } else if (!email.contains('@') || !email.contains('.')) {
          return "Email address is not valid";
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

  // TO DO : implement submitButton similar to loginButton
  MaterialButton submitButton() {
    return MaterialButton(
      onPressed: _submitForgetPasswordForm,
      color: ColorShades.primaryColor4,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Submit',
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

  TextButton backLoginButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        },
        child: const Text(
          'Return to Login',
          style: TextStyle(
            color: Color(0xff102542),
            fontSize: 24,
          ),
        ));
  }
}
