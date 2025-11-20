import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          children: [
            const SectionTitle(title: 'À propos de moi'),
            const SizedBox(height: 40),
            Text(
              'Développeur passionné par Linux, le networking et la cybersécurité. '
              'Je travaille sur des projets variés allant du développement mobile avec Flutter '
              'aux configurations de serveurs et bases de données. Membre de l\'équipe APEXNova Labs, '
              'je contribue à des projets open source et explore continuellement de nouvelles technologies.',
              style: AppTheme.bodyLarge(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppConstants.secondaryDark,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.withOpacity(0.2)),
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
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Classement basé sur les contributions publiques',
                    style: AppTheme.subtitleSmall(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
