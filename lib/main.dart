import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/auth/login.dart';
import 'package:practice_app/screens/drawer_screens/emergency_contacts/emergency_contact_screen.dart';
import 'package:practice_app/screens/home_page/medicine/medicine_screen.dart';

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
      future:_initialization,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Center(child: Center(child: CircularProgressIndicator())))
          );
        }
   else{
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practice app',
      theme: ThemeData(fontFamily: 'Arial'),
      home: const MedicineScreen(),
    );

        }
      } );
   
  }
}
