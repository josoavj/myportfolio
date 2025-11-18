import 'package:flutter/material.dart';

extension LanguageColorExtension on String {
  Color getLanguageColor() {
    switch (this) {
      case 'Dart':
        return Colors.blue;
      case 'JavaScript':
        return Colors.yellow;
      case 'Java':
        return Colors.red;
      case 'Python':
        return Colors.green;
      case 'Shell':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}
