import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/widgets/education_card.dart';
import 'package:myportfolio/widgets/section_title.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final education = AppData.getEducation();
    final isMobile = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isMobile ? 16.0 : 20.0;
    final verticalPadding = isMobile ? 60.0 : 80.0;
    final spacingBetweenTitle = isMobile ? 40.0 : 60.0;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(title: 'Formation Académique', emoji: null),
              SizedBox(height: spacingBetweenTitle),
              Column(
                children: education.asMap().entries.map((entry) {
                  return EducationCard(
                    education: entry.value,
                    index: entry.key,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
