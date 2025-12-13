import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? emoji;

  const SectionTitle({
    super.key,
    required this.title,
    this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        Text(
          emoji != null ? '$emoji $title' : title,
          style: isSmall ? AppTheme.titleMediumMobile() : AppTheme.titleLarge(),
        ).withSlideUp(
          delay: Duration.zero,
          distance: 20.0,
        ),
        const SizedBox(height: 10),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ).withScaleIn(
          delay: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
