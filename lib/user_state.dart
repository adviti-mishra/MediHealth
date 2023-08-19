import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/auth/welcome/welcome_page.dart';
import 'package:practice_app/screens/landing_page/landing_page.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // Stream that checks whether user is signed in or not
        // Listens to any changes in the authentication state
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          // case 1 : user is not logged in
          if (userSnapshot.data == null) {
            // print('User has not logged in yet');
            // return Login page
            // return LandingPage();
            return const Welcome();
          }
          // case 2 : user is already logged in
          else if (userSnapshot.hasData) {
            // print('User is already logged in in');
            // return Landing page
            return LandingPage();
          }
          // case 3 : error occurs during authentication process
          else if (userSnapshot.hasError) {
            return const Scaffold(
                body: Center(child: Text('An error has occured')));
          }
          // case 4 : waiting for the authentication state
          else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          // case 5 : if none of the conditions are met, generic error message
          return const Scaffold(
              body: Center(child: Text('Something went wrong')));
        });
  }
}
