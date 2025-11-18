import 'package:flutter/material.dart';

class Education {
  final String degree;
  final String school;
  final String period;
  final String location;
  final String description;
  final IconData icon;
  final Color color;
  final String status;

  Education({
    required this.degree,
    required this.school,
    required this.period,
    required this.location,
    required this.description,
    required this.icon,
    required this.color,
    required this.status,
  });
}
