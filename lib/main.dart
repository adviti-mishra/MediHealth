import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/user_state.dart';
// import 'package:color_blindness/color_blindness.dart';
// import 'package:color_blindness/color_blindness_color_scheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // showing a loading screen while Firebase is initializing
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                    body: Center(
                        child: Center(child: CircularProgressIndicator()))));
          }
          // Firebase is initialized. Continue with app
          else {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Practice app',
                theme: ThemeData(
                  fontFamily: 'Arial',
                  /*
                  colorScheme:
                  colorBlindnessColorScheme(
                      const ColorScheme(
                        primary: Color(0xFFDC143C), //defines primary
                        secondary: Colors.white,
                        background: Color(0xFF267AA0),
                        surface: Colors.green,
                        error: Colors.black,
                        onPrimary: Color(0xFFDC143C),
                        onSecondary: Colors.white,
                        onSurface: Colors.white,
                        onBackground: Color(0xFF267AA0),
                        onError: Colors.red,
                        brightness: Brightness.light,
                      ),
                      ColorBlindnessType.tritanopia)),
                      */

                  colorScheme: const ColorScheme(
                    primary: Colors.white, //defines primary
                    secondary: Color(0xF102542),
                    background: Color(0xFF267AA0),
                    surface: Colors.white,
                    error: Colors.black,
                    onPrimary: Colors.black,
                    onSecondary: Colors.black,
                    onSurface: Colors.black,
                    onBackground: Colors.white,
                    onError: Colors.red,
                    brightness: Brightness.light,
                  ),
                ),
                // set the home screen of the app to UserState()
                home: const UserState());
          }
        });
  }
}
