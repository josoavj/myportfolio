import 'package:flutter/material.dart';

class SkillBar extends StatelessWidget {
  final String name;
  final double level;
  final Color color;

  const SkillBar({
    super.key,
    required this.name,
    required this.level,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: level),
        duration: Duration(milliseconds: 1500 + (level * 500).toInt()),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${(value * 100).toInt()}%',
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1117),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
