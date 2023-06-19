import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';
import 'package:practice_app/screens/auth/login/login_data_tile.dart';
import 'package:practice_app/screens/auth/login/login_message.dart';
import 'package:practice_app/screens/auth/login/forgot_password_link.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginPageContent(context),
    );
  }

  Container loginPageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        children: [
          verticalSpace(20),
          welcomeBackMessage(context),
          verticalSpace(20),
          getInfoTile(
              emailPassword: emailPassword(),
              forgotPassword: navigate_to_forgotPassword(context)),
          verticalSpace(20),
          loginButton(),
        ],
      ),
    );
  }

  ///
  /// EMAIL PASSWORD FORM
  ///

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void _submitLoginForm() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailTextController.text.trim().toLowerCase(),
            password: _passwordTextController.text);
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

  // Email and Password
  Form emailPassword() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          // Email field
          emailField(),
          // BLANK LINE
          verticalSpace(20),
          // Password field
          passwordField(),
        ],
      ),
    );
  }

  // Email field
  Column emailField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "email: ")),
      emailValidation()
    ]);
  }

  // Email validation
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
      style: TextStyle(color: ColorShades.text2),
      decoration: InputDecoration(
        hintText: 'Format: someone@example.com',
        hintStyle:
            TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorShades.text1, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        fillColor: const Color(0xFFCDD7D6),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  // Password field
  Column passwordField() {
    return Column(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: mandatoryHeader(desiredHeader: "password: ")),
      passwordValidation()
    ]);
  }

  // Password validation
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
          borderRadius: BorderRadius.circular(15.0),
        ),
        fillColor: const Color(0xFFCDD7D6),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  // TO DO : implement the login Button
  MaterialButton loginButton() {
    return MaterialButton(
      onPressed: _submitLoginForm,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [],
        ),
      ),
    );
  }
}
