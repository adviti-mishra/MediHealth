import 'package:flutter/material.dart';
import 'dart:math';

class ProfileCircle extends StatelessWidget {
  final double size;

  ProfileCircle({this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF2D3047),
      ),
      child: Center(
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: size * 0.7,
        ),
      ),
    );
  }
}

class MyCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D3047),
        leading: IconButton(
          onPressed: () {
            //navigatetoMenu(context);
          },
          icon: Icon(
            Icons.menu,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        centerTitle: false,
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
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'My Circle',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileCircle(size: 60.0),
                    SizedBox(width: 30),
                    ProfileCircle(size: 60.0),
                    SizedBox(width: 30),
                    ProfileCircle(size: 60.0),
                  ],
                ),
                SizedBox(height: 30),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF2D3047),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow[700],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileCircle(size: 60.0),
                    SizedBox(width: 30),
                    ProfileCircle(size: 60.0),
                    SizedBox(width: 30),
                    ProfileCircle(size: 60.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF2D3047),
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

void main() {
  runApp(MaterialApp(
    home: MyCircle(),
  ));
}
