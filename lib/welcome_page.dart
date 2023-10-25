
import 'package:flutter/material.dart';
import 'package:portfolio/Skills.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/Profile.dart';

class welcomepage extends StatefulWidget {
  const welcomepage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hi, I'm Josoa",
                  style:  TextStyle(
                    fontFamily: 'Josefin',
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                  ),
                  )
              ],
            ),
            Row(),
          ]
          ),
      ),
    );
  }
}
