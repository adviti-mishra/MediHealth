import 'package:flutter/material.dart';
import '../../constants/color_shades.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Drawer(
        backgroundColor: ColorShades.primaryColor2.withOpacity(0.9),
        child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(color: ColorShades.text1),
            child: Image.network('assets/images/MediHealth_logo.png'),
          ),
        ]));
  }
}
