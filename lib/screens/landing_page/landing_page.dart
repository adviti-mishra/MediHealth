import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/screens/home_page/drawer_widget.dart';
import 'package:practice_app/screens/landing_page/message_screen.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget userText(
      {required String message, required String imagePath, required Key key}) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(
                    imagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 40),
            MessageScreen(
              key: key,
              message: message,
            ),
          ],
        ),
      ],
    );
  }

  void navigatetoMenu(context) {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D3047),
        leading: IconButton(
          onPressed: () {
            navigatetoMenu(context);
          },
          icon: Icon(
            Icons.menu,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        centerTitle: true,
        title: Text(
          'MediHealth',
          style: TextStyle(
            color: Colors.yellow[700],
            fontSize: 40,
            fontFamily: 'Tahoma',
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 60,
        actions: [
          Column(
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.yellow[700],
                size: 30,
              ),
              Text(
                "Help",
                style: TextStyle(
                  color: Colors.yellow[700],
                ),
              )
            ],
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Hello, ____",
                style: TextStyle(
                  color: Color(0xFF102542),
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tahoma',
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Welcome back to your account",
                style: TextStyle(
                  color: Color(0xFF102542),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tahoma',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('0'),
                    ),
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('1'),
                    ),
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('2'),
                    ),
                    userText(
                      message: "I'm looking forward to seeing...",
                      imagePath: 'assets/images/user.png',
                      key: const Key('3'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF2D3047),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  // Handle back arrow icon click
                },
                icon: Icon(Icons.arrow_back, color: Colors.yellow[700]),
              ),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 18,
                  fontFamily: "Tahoma",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
