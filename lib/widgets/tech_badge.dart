import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myportfolio/utils/app_theme.dart';

class TechBadge extends StatelessWidget {
  final String name;
  final String icon;
  final Color color;
  final int index;

  const TechBadge({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.index,
  });

  IconData _getIconForTech(String techName) {
    switch (techName.toLowerCase()) {
      // Langages
      case 'dart':
        return FontAwesomeIcons.dartLang;
      case 'python':
        return FontAwesomeIcons.python;
      case 'javascript':
        return FontAwesomeIcons.js;
      case 'java':
        return FontAwesomeIcons.java;
      // Frameworks
      case 'flutter':
        return FontAwesomeIcons.flutter;
      case 'react':
        return FontAwesomeIcons.react;
      case 'node.js':
        return FontAwesomeIcons.node;
      case 'express.js':
        return FontAwesomeIcons.node;
      // Bases de données
      case 'mysql':
        return FontAwesomeIcons.database;
      case 'elasticsearch':
        return FontAwesomeIcons.database;
      case 'hive':
        return FontAwesomeIcons.database;
      // DevOps & Outils
      case 'linux':
        return FontAwesomeIcons.linux;
      case 'git':
        return FontAwesomeIcons.git;
      case 'nginx':
        return FontAwesomeIcons.server;
      case 'bash':
        return FontAwesomeIcons.terminal;
      // Outils de Développement
      case 'vs code':
        return FontAwesomeIcons.dev;
      case 'android studio':
        return FontAwesomeIcons.android;
      case 'pycharm':
        return FontAwesomeIcons.python;
      case 'webstorm':
        return FontAwesomeIcons.dev;
      // Sécurité & Networking
      case 'security':
        return FontAwesomeIcons.lock;
      case 'networking':
        return FontAwesomeIcons.networkWired;
      case 'kali linux':
        return FontAwesomeIcons.linux;
      default:
        return FontAwesomeIcons.cube;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(_getIconForTech(name), color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              name,
              style: AppTheme.label(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
