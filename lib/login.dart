// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/homepage.dart';
import 'package:lvlmind/main.dart';
import 'package:google_fonts/google_fonts.dart';
// Suite à une erreur sur les polices que j'ait télechargé
// J'ai du revenir à googlefonts

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.blueAccent,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DelayedAnimation(
                    delay: 1100,
                    child: Text(
                      'Connect to levelmind',
                      style: GoogleFonts.patrickHandSc(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: d_color,
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  DelayedAnimation(
                    delay: 1500,
                    child: Text(
                      'It' 's recommended to connect with your ID.',
                      style: GoogleFonts.josefinSans(
                        fontSize: 20,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 45),
            LoginForm(),
            SizedBox(height: 100),
            DelayedAnimation(
              delay: 2000,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  // J'ai utilisé primary mais elle est obsolète
                  // Du coup je l'ai remplacé par backgroundColor
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 90,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  'CONFIRM',
                  style: GoogleFonts.patrickHandSc(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 90),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 35),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: DelayedAnimation(
                    delay: 3500,
                    child: Text(
                      "Return",
                      style: GoogleFonts.josefinSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 1800,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Your ID',
                labelStyle: GoogleFonts.tiltNeon(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          DelayedAnimation(
            delay: 1900,
            child: TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelStyle: GoogleFonts.tiltNeon(
                  color: Colors.grey[400],
                ),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
