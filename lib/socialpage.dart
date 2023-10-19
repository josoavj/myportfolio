// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/login.dart';
import 'package:lvlmind/main.dart';
import 'package:lvlmind/formulaire.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});
  // Added a constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
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
            DelayedAnimation(
              delay: 1200,
              child: SizedBox(
                height: 280,
                child: Image.asset('../images/lvlmind.png'),
              ),
            ),
            DelayedAnimation(
              delay: 1700,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Column(
                  children: const [
                    Text(
                      "Your adventure begins here and now.",
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Train your  mind to gain more knowledge with levelmind",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'TiltNeon',
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DelayedAnimation(
              delay: 2500,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: d_color,
                        padding: const EdgeInsets.all(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.send_sharp), //A modifier
                          SizedBox(width: 10),
                          Text(
                            'Connect with Personal ID',
                            style: TextStyle(
                              fontFamily: 'TiltNeon',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Formulaire(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: const Color(0xFF576dff),
                        padding: const EdgeInsets.all(13),
                      ),
                      child: const Text('Create Account'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
