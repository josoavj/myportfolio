import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;
    final minHeight = isSmall ? size.height * 0.95 : size.height;

    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 15 : 20,
        vertical: isSmall ? 50 : 80,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SectionTitle(title: 'À propos de moi'),
            SizedBox(height: isSmall ? 25 : 40),
            if (isSmall)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Je suis un développeur passionné par le développement d\'applications mobiles et le développement logiciel.',
                    style: AppTheme.bodyLargeMobile(),
                    textAlign: TextAlign.justify,
                  ).withFadeIn(delay: const Duration(milliseconds: 200)),
                  SizedBox(height: isSmall ? 12 : 0),
                  Text(
                    'Intéressé par la cybersécurité et les technologies avancées. Spécialisé dans Flutter, Python, JavaScript et architectures backend.',
                    style: AppTheme.bodyLargeMobile(),
                    textAlign: TextAlign.justify,
                  ).withFadeIn(delay: const Duration(milliseconds: 300)),
                  SizedBox(height: isSmall ? 12 : 0),
                  Text(
                    'Membre actif d\'APEXNova Labs, je contribue à des projets open source innovants et explore continuellement de nouvelles technologies.',
                    style: AppTheme.bodyLargeMobile(),
                    textAlign: TextAlign.justify,
                  ).withFadeIn(delay: const Duration(milliseconds: 400)),
                  SizedBox(height: isSmall ? 12 : 0),
                  Text(
                    'Actuellement poursuivant un Master en Informatique et Télécommunications avec focus sur l\'architecture logicielle et la sécurité des systèmes.',
                    style: AppTheme.bodyLargeMobile(),
                    textAlign: TextAlign.justify,
                  ).withFadeIn(delay: const Duration(milliseconds: 500)),
                  SizedBox(height: isSmall ? 12 : 0),
                  Text(
                    'Avec 43 repositories publiques et une passion pour l\'excellence technique, je crée des solutions robustes et scalables.',
                    style: AppTheme.bodyLargeMobile(),
                    textAlign: TextAlign.justify,
                  ).withFadeIn(delay: const Duration(milliseconds: 600)),
                ],
              )
            else
              Text(
                'Je suis un développeur passionné par le développement d\'applications mobiles et le développement logiciel. '
                'Intéressé par la cybersécurité et les technologies avancées. Spécialisé dans Flutter, Python, JavaScript et architectures backend. '
                'Membre actif d\'APEXNova Labs, je contribue à des projets open source innovants et explore continuellement de nouvelles technologies. '
                'Actuellement poursuivant un Master en Informatique et Télécommunications avec focus sur l\'architecture logicielle et la sécurité des systèmes. '
                'Avec 43 repositories publiques et une passion pour l\'excellence technique, je crée des solutions robustes et scalables.',
                style: AppTheme.bodyLarge(),
                textAlign: TextAlign.center,
              ).withFadeIn(delay: const Duration(milliseconds: 200)),
            SizedBox(height: isSmall ? 25 : 40),
            Container(
              padding: EdgeInsets.all(isSmall ? 16 : 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.amber.withValues(alpha: 0.12),
                    Colors.orange.withValues(alpha: 0.06),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.amber.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events,
                          color: Colors.amber, size: isSmall ? 24 : 28),
                      SizedBox(width: isSmall ? 8 : 10),
                      Flexible(
                        child: Text(
                          'Top 10 Développeur GitHub Madagascar',
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
                  SizedBox(height: isSmall ? 12 : 15),
                  Text(
                    'Classement basé sur les contributions publiques',
                    style: isSmall
                        ? AppTheme.bodyLargeMobile()
                        : AppTheme.subtitleSmall(),
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
