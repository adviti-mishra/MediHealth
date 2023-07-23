import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:practice_app/screens/landing_page/custom_shape.dart';

class MessageScreen extends StatelessWidget {
  final String message;
  const MessageScreen({
    required Key key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 85),
              Transform(
                alignment: Alignment.bottomRight,
                transform: Matrix4.rotationY(math.pi),
                child: CustomPaint(
                  painter: CustomShape(const Color(0xFF102542)),
                ),
              ),
            ],
          ),
          Container(
            width: 250,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFF102542),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                topLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
