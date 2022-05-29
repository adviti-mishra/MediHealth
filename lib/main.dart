import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/screens/home_page/medicine/medicine_screen.dart';
//import 'screens/auth/login.dart';
import 'screens/home_page/medicine/medicine_screen.dart';
import '../../constants/color_shades.dart';

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
        primaryColor: ColorShades.primaryColor1,
      ),
      home: const MedicineScreen(),
    );
  }
}
