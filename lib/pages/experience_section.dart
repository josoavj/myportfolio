import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/widgets/experience_card.dart';
import 'package:myportfolio/widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = AppData.getExperiences();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      color: AppConstants.secondaryDark,
      child: Column(
        children: [
          const SectionTitle(title: 'Expérience Professionnelle', emoji: '💼'),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: experiences.asMap().entries.map((entry) {
                return ExperienceCard(
                  experience: entry.value,
                  index: entry.key,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
