import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/utils/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: AppConstants.primaryDark,
      child: Column(
        children: [
          Text(
            '© 2025 Josoa Vonjiniaina. Tous droits réservés.',
            style: AppTheme.caption(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Développé avec Flutter',
            style: AppTheme.labelSmall(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
