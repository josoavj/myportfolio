import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lvlmind/welcome_page.dart';

// ignore: constant_identifier_names
const d_color = Color.fromARGB(255, 11, 73, 173);

void main() {
  runApp(lvlmind());
}

class lvlmind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lvlmind',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
