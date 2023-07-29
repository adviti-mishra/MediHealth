import 'package:flutter/material.dart';

import 'color_shades.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorShades.primaryColor1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.arrow_back, color: ColorShades.primaryColor4),
            ),
            Text(
              'Back',
              style: TextStyle(
                color: ColorShades.primaryColor4,
                fontSize: 18,
                fontFamily: "Tahoma",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
