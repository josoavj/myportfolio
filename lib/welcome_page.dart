import 'package:flutter/material.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/main.dart';
import 'package:lvlmind/socialpage.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
// Ajout d'un clé au constructeur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 50,
          ),
          child: Column(
            children: [
              // Pour le logo de l'ISPM
              DelayedAnimation(
                delay: 1500,
                child: SizedBox(
                  height: 100,
                  child: Image.asset('/images/ispmlogo.png'),
                ),
              ),

              // Juste pour l'espacement
              const DelayedAnimation(
                delay: 2000,
                child: SizedBox(
                  height: 100,
                  child: null,
                  // Our application's logo
                ),
              ),

              // Pour notre logo
              DelayedAnimation(
                delay: 2000,
                child: SizedBox(
                  height: 100,
                  child: Image.asset('/images/lvlmind.png'),
                  // Our application's logo
                ),
              ),

              // Nom du projet
              DelayedAnimation(
                delay: 2000,
                child: SizedBox(
                  height: 100,
                  child: Text(
                    "lvlmind",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ),

              DelayedAnimation(
                delay: 3500,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                    bottom: 30,
                  ),
                  child: Text(
                    'Online learning with levelmind',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 3500,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: Text(
                    "Build skills with courses, certificates and degrees online from world class universities",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 71, 136, 250),
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 4500,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: d_color,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13)),
                    // onHover: ,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SocialPage(),
                        ),
                      );
                    },
                    child: Text(
                      'GET STARTED',
                      style: GoogleFonts.tiltNeon(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
