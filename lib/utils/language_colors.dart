import 'package:flutter/material.dart';

/// Couleurs de langages (palette GitHub) pour la barre de répartition.
Color languageBarColor(String language) {
  switch (language) {
    case 'Dart':
      return const Color(0xFF00B4AB);
    case 'JavaScript':
      return const Color(0xFFF1E05A);
    case 'TypeScript':
      return const Color(0xFF3178C6);
    case 'Python':
      return const Color(0xFF3572A5);
    case 'Java':
      return const Color(0xFFB07219);
    case 'Kotlin':
      return const Color(0xFFA97BFF);
    case 'Swift':
      return const Color(0xFFF05138);
    case 'Objective-C':
      return const Color(0xFF438EFF);
    case 'C':
      return const Color(0xFF8A8A8A);
    case 'C++':
      return const Color(0xFFF34B7D);
    case 'CMake':
      return const Color(0xFFDA3434);
    case 'Shell':
      return const Color(0xFF89E051);
    case 'PowerShell':
      return const Color(0xFF5391FE);
    case 'Batchfile':
      return const Color(0xFFC1F12E);
    case 'HTML':
      return const Color(0xFFE34C26);
    case 'CSS':
      return const Color(0xFF9B6BDF);
    case 'SCSS':
      return const Color(0xFFC6538C);
    case 'Dockerfile':
      return const Color(0xFF3A6F8F);
    case 'Markdown':
      return const Color(0xFF6E7681);
    case 'Autres':
      return const Color(0xFF59626E);
    default:
      return const Color(0xFF8B949E);
  }
}
