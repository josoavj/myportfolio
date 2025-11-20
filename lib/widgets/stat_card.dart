import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_theme.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final double width;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        width: width,
        padding: EdgeInsets.all(isSmall ? 15 : 25),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: isSmall ? 32 : 40, color: color),
            SizedBox(height: isSmall ? 10 : 15),
            Text(
              title,
              style: isSmall
                  ? AppTheme.titleSmallMobile(color: color)
                  : AppTheme.titleMedium(color: color),
            ),
            SizedBox(height: isSmall ? 6 : 8),
            Text(
              subtitle,
              style: AppTheme.labelSmall(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
