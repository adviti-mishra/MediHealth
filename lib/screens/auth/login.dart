import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'forgotpassword.dart';
import '../../utils/utils_all.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailTextController =
      TextEditingController();
  final TextEditingController _passwordTextController =
      TextEditingController();
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void _submitLoginForm() {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {}
  }

// ________________________________________________________________________
//                                Login                             
//                            Welcome back!
//                    Please fill your credentials 
// ________________________________________________________________________

  Column loginWelcomeBack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Login
        Center(
            child: Text('Login',
                style: TextStyle(
                  color: ColorShades.text1,
                  fontSize: 60,
                ))),
        Center(
          child: Text('Welcome back!',
              style: TextStyle(
                color: ColorShades.text1,
                fontSize: 30,
              )),
        ),
        Center(
          child: Text('Please fill your credentials',
              style: TextStyle(
                color: ColorShades.text1,
                fontSize: 30,
              )),
        ),
      ],
    );
  }

  RichText registerHere() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Don\'t have an account?',
              style: TextStyle(
                  color: ColorShades.text2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const TextSpan(text: '    '),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp())),
              text: 'Register here',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: ColorShades.text2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))
        ],
      ),
    );
  }

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
          child: mandatoryHeader(desiredHeader:"Password: ")),
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

  Row forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()));
            },
            child: Text(
              'Forgot password?',
              style: TextStyle(
                color: ColorShades.text2,
                fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  ),
            )),
      ],
    );
  }

  MaterialButton loginButton() {
    return MaterialButton(
      onPressed: _submitLoginForm,
      color: ColorShades.primaryColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
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
              Icons.login,
              color: ColorShades.text1,
            )
          ],
        ),
      ),
    );
  }

  Container loginPageContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorShades.primaryColor3,
          //border: Border.all(color: Colors.black),
         ),
      child: Column(
        children: [
          verticalSpace(60),
          loginWelcomeBack(),
          verticalSpace(40),
          Expanded(
            child: Container(
              decoration:  BoxDecoration(
                  color:  ColorShades.primaryColor2,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  // constrain height of List [Email, Password]
                  child: Column(
                    children: [
                      verticalSpace(20),
                      // Don't have an account? Register here
                      Center(child: registerHere()),
                      verticalSpace(20),
                      // Email and Password
                      emailPassword(),
                      // Forgot Password?
                      verticalSpace(20),
                      forgotPassword(),
                      // *******************************************************
                      verticalSpace(100),
                      // Login button
                      loginButton(),
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
      body: loginPageContent(),
    );
  }
}
