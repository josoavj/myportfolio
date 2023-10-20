// ignore_for_file: unused_import, no_logic_in_create_state, camel_case_types, avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/main.dart';

class Formulaire extends StatelessWidget {
  const Formulaire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.blueAccent,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class form extends StatefulWidget{
  const form({super.key});
  
  @override
  FormState createState() => FormState();
  @override
}