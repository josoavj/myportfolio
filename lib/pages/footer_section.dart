import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';

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
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Développé avec Flutter ❤️',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
