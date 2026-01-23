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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isMobile ? 16.0 : 20.0;
    final verticalPadding = isMobile ? 60.0 : 80.0;
    final spacingBetweenTitle = isMobile ? 40.0 : 60.0;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      color: AppConstants.secondaryDark,
      child: Column(
        children: [
          const SectionTitle(title: 'Expérience Professionnelle', emoji: '💼'),
          SizedBox(height: spacingBetweenTitle),
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
