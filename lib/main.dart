// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:portfolio/welcome_page.dart';

void main() {
  runApp(const portfolio());
}
// Recommendation: Ajout de const avant lvlmind et Material app

class portfolio extends StatelessWidget {
  const portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      home: welcomepage(),
    );
  }
  // Ajout d'un constructeur
}
