import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/auth/login.dart';
import 'package:practice_app/screens/home_page/medicine/medicine_screen.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // checks whether user is signed in or not - keep listening to any event depending on this
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('User has not logged in yet');
            return const Login();
          } else if (userSnapshot.hasData) {
            print('User is already logged in in');
            return const MedicineScreen();
          } else if (userSnapshot.hasError) {
            return const Scaffold(
                body: Center(child: Text('An error has occured')));
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          return const Scaffold(
              body: Center(child: Text('Something went wrong')));
        });
  }
}
