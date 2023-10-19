// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/main.dart';
import 'package:google_fonts/google_fonts.dart';

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
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DelayedAnimation(
                  delay: 1500,
                  Child: Text(
                    "Connect ID",
                    style: GoogleFonts.poppins(
                      color: d_color,
                      fontSize: 25,
                      FontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 22),
                DelayedAnimation(
                  delay: 2500,
                  Child: Text(
                    "It's recommended to connect your ID for us",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 16,
                      FontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 35),
          // LoginForm(),
          SizedBox(height: 125),
          /*
          DelayedAnimation(
              delay: 5500,
               Child: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: d_color,
              ))
           */
        ]),
      ),
    );
  }
}
