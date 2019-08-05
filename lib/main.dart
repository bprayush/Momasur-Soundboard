import 'package:flutter/material.dart';
import 'package:momasur/pages/audiofx/audiofx.dart';

void main() {
  runApp(Momasur());
}

class Momasur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Momasur",
      debugShowCheckedModeBanner: false,
      home: AudioFX(),
    );
  }
}
