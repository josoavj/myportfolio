import 'package:flutter/material.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/main.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LEVELMIND"),
        centerTitle: true,
        iconTheme: const IconThemeData(),
      ),
    );
  }
}