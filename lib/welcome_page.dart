import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lvlmind/animate.dart';
import 'package:lvlmind/main.dart';
import 'package:lvlmind/socialpage.dart';

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
            vertical: 60,
            horizontal: 30,
          ),
          child: Column(
            children: [
              // Pour le logo de l'ISPM
              DelayedAnimation(
                delay: 1500,
                child: SizedBox(
                  height: 100,
                  child: Image.asset('../images/ispmlogo.png'),
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
                  child: Image.asset('../images/lvlmind.png'),
                  // Our application's logo
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
                    "Online learning with levelmind",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 83, 86, 145),
                      fontSize: 18,
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
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 83, 86, 145),
                      fontSize: 15,
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
                    child: const Text('GET STARTED'),
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
