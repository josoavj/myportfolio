// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:lvlmind/welcome_page.dart';

// ignore: constant_identifier_names
const d_color = Color.fromARGB(255, 11, 73, 173);

void main() {
  runApp(const lvlmind());
}
// Recommendation: Ajout de const avant lvlmind et Material app

class lvlmind extends StatelessWidget {
  const lvlmind({super.key});
  // Ajout d'un constructeur
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'lvlmind',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
