import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Text(
          emoji != null ? '$emoji $title' : title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
