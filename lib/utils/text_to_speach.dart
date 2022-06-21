import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

RawMaterialButton audio(String text, FlutterTts flutterTts) {
  return RawMaterialButton(
      child: const Icon(
        Icons.volume_up,
        color: Colors.grey,
        size: 50.0,
      ),
      shape: const CircleBorder(),
      onPressed: () {
        speak(
            text,
            flutterTts);
      });
}

speak(String text, FlutterTts flutterTts) async {
  await flutterTts.setLanguage('en-US');
  await flutterTts.setPitch(1);
  await flutterTts.speak(text);
}
