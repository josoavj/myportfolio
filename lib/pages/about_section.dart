import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/widgets/section_title.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 15 : 20,
        vertical: isSmall ? 60 : 80,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          children: [
            const SectionTitle(title: 'À propos de moi'),
            SizedBox(height: isSmall ? 25 : 40),
            Text(
              'Je suis un développeur passionné par le développement d\'applications mobiles et le développement logiciel. '
              'Intéressé par la cybersécurité et les technologies avancées. Spécialisé dans Flutter, Python, JavaScript et architectures backend. '
              'Membre actif d\'APEXNova Labs, je contribue à des projets open source innovants et explore continuellement de nouvelles technologies. '
              'Actuellement poursuivant un Master en Informatique et Télécommunications avec focus sur l\'architecture logicielle et la sécurité des systèmes. '
              'Avec 43 repositories publiques et une passion pour l\'excellence technique, je crée des solutions robustes et scalables.',
              style:
                  isSmall ? AppTheme.bodyLargeMobile() : AppTheme.bodyLarge(),
              textAlign: TextAlign.center,
            ).withFadeIn(delay: const Duration(milliseconds: 200)),
            SizedBox(height: isSmall ? 25 : 40),
            Container(
              padding: EdgeInsets.all(isSmall ? 20 : 30),
              decoration: BoxDecoration(
                color: AppConstants.secondaryDark,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.emoji_events,
                          color: Colors.amber, size: 28),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Top 15 Développeur GitHub Madagascar',
                          style: AppTheme.titleMedium(color: Colors.amber),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ).withSlideUp(
                    delay: const Duration(milliseconds: 300),
                    distance: 15.0,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Classement basé sur les contributions publiques',
                    style: AppTheme.subtitleSmall(),
                  ).withFadeIn(delay: const Duration(milliseconds: 400)),
                ],
              ),
            ).withSlideUp(
              delay: const Duration(milliseconds: 250),
              distance: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
