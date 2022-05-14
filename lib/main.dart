import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/screens/medicine_screen.dart';
//import 'screens/auth/login.dart';
import 'screens/medicine_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practice app',
      theme: ThemeData(
        textTheme: GoogleFonts.ptSerifTextTheme(
          Theme.of(context).textTheme,
        ),
        //scaffoldBackgroundColor: ,
        primaryColor: Colors.black,
      ),
      home: const MedicineScreen(),
    );
  }
}
