import 'package:flutter/material.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/main.dart';
import 'package:google_fonts/google_fonts.dart';

class Formulaire extends StatelessWidget {
  const Formulaire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your account"),
        centerTitle: true,
      ),
    );
  }
}
