import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/auth/signup/signup.dart';
import 'package:practice_app/screens/promptPage/promptPage.dart';
import '../../../utils/utils_all.dart';
import 'package:practice_app/screens/auth/login/login_data_tile.dart';
import 'package:practice_app/screens/auth/login/login_message.dart';
import 'package:practice_app/screens/auth/welcome/welcome_page.dart';
import 'package:practice_app/screens/auth/forgot_password/forgot_password_page.dart';

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
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          verticalSpace(80),
          welcomeBackMessage(context),
          getInfoTile(
              emailPassword: emailPassword(), loginButton: loginButton()),
          forgotButton(),
          signupPageButton(),
          backWelcomeButton(),
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

        // Navigate to another page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const PromptPage()), // Replace `YourNextPage` with the actual page you want to navigate to.
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
    return Column(
      children: [
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
        emailValidation(),
      ],
    );
  }

  // Email validation
  TextFormField emailValidation() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      validator: (email) {
        if (email!.isEmpty || !email.contains('@') || !email.contains('@')) {
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

  // Password field
  Column passwordField() {
    return Column(
      children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Row(children: [
              Text(
                "Password",
                style: TextStyle(
                  color: ColorShades.primaryColor4,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])),
        verticalSpace(10),
        passwordValidation(),
      ],
    );
  }

  // Password validation
  TextFormField passwordValidation() {
    return TextFormField(
      obscureText: _obscureText,
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
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xff102542)),
        ),
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

  // TO DO : implement the login Button
  MaterialButton loginButton() {
    return MaterialButton(
      onPressed: _submitLoginForm,
      color: ColorShades.primaryColor4,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                color: Color(0xff102542),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
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

  // Forgot Button
  TextButton forgotButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ForgotPassword()));
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Color(0xff102542),
            fontSize: 24,
          ),
        ));
  }

  // Signup Page Button
  TextButton signupPageButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignUp()));
        },
        child: const Text(
          "Don't have an account? Sign Up",
          style: TextStyle(
            color: Color(0xff102542),
            fontSize: 24,
          ),
        ));
  }

  // Back Button
  TextButton backWelcomeButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Welcome()));
        },
        child: const Text(
          "Back",
          style: TextStyle(
            color: Color(0xff102542),
            fontSize: 24,
          ),
        ));
  }
}
