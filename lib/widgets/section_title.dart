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
          style: isSmall ? AppTheme.titleMediumMobile() : AppTheme.titleLarge(size: 36),
        ).withSlideUp(
          delay: Duration.zero,
          distance: 20.0,
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.cyan],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ).withScaleIn(
          delay: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
