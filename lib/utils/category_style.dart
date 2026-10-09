import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Couleur associée à une catégorie de projet.
Color categoryColor(String category) {
  switch (category) {
    case 'Mobile':
    case 'Desktop':
      return Colors.blue;
    case 'Web':
      return Colors.cyan;
    case 'Backend':
      return Colors.orange;
    case 'Tools':
      return Colors.teal;
    default:
      return Colors.grey;
  }
}

/// Icône associée à une catégorie de projet.
FaIconData categoryIcon(String category) {
  switch (category) {
    case 'Mobile':
      return FontAwesomeIcons.mobileScreenButton;
    case 'Desktop':
      return FontAwesomeIcons.desktop;
    case 'Web':
      return FontAwesomeIcons.globe;
    case 'Backend':
      return FontAwesomeIcons.server;
    case 'Tools':
      return FontAwesomeIcons.screwdriverWrench;
    case 'Tous':
      return FontAwesomeIcons.tableCells;
    default:
      return FontAwesomeIcons.cube;
  }
}
