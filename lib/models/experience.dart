import 'package:flutter/material.dart';

class Experience {
  final String role;
  final String company;
  final String period;
  final String location;
  final String description;
  final List<String> achievements;
  final IconData icon;
  final Color color;

  Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    required this.achievements,
    required this.icon,
    required this.color,
  });
}
