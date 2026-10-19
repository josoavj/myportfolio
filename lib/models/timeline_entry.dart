import 'package:flutter/material.dart';

/// Une étape du parcours (professionnel ou académique).
class TimelineEntry {
  final String title;
  final String organization;
  final String location;
  final String period;
  final String? duration;
  final String badge;
  final String? status;
  final String summary;
  final List<String> highlights;
  final List<String> technologies;
  final List<String> relatedProjects;
  final String? thesisTitle;
  final IconData icon;
  final bool isOngoing;

  const TimelineEntry({
    required this.title,
    required this.organization,
    required this.location,
    required this.period,
    required this.badge,
    required this.summary,
    required this.icon,
    this.duration,
    this.status,
    this.highlights = const [],
    this.technologies = const [],
    this.relatedProjects = const [],
    this.thesisTitle,
    this.isOngoing = false,
  });

  bool get hasDetails =>
      highlights.isNotEmpty ||
      technologies.isNotEmpty ||
      relatedProjects.isNotEmpty ||
      thesisTitle != null;
}
