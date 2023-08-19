import 'package:flutter/material.dart';
import '../../../utils/utils_all.dart';
import 'package:practice_app/screens/auth/welcome/welcome_tile.dart';
import 'package:practice_app/screens/auth/welcome/welcome_message.dart';
import 'package:practice_app/screens/auth/login/login_page.dart';
import 'package:practice_app/screens/auth/signup/signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: welcomePageContent(context),
    );
  }

  Container welcomePageContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff102542),
      ),
      child: Column(
        children: [
          verticalSpace(220),
          welcomeMessage(context),
          welcomeTile(
            loginPageButton: loginPageButton(),
            signupPageButton: signupPageButton(),
          ),
        ],
      ),
    );
  }

  MaterialButton loginPageButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      },
      color: ColorShades.primaryColor3,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log In',
              style: TextStyle(
                color: Color(0xff102542),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  MaterialButton signupPageButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignUp()));
      },
      color: ColorShades.primaryColor4,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                color: Color(0xff102542),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
