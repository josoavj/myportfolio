import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/widgets/education_card.dart';
import 'package:myportfolio/widgets/section_title.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final education = AppData.getEducation();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          const SectionTitle(title: 'Formation Académique', emoji: '🎓'),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: education.asMap().entries.map((entry) {
                return EducationCard(
                  education: entry.value,
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
