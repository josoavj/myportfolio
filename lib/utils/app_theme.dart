import 'package:flutter/material.dart';

/// Configuration centralisée du thème et des polices (Optimisée pour le Web)
class AppTheme {
  // Police par défaut (déclarée dans pubspec.yaml)
  static const String _fontFamily = 'Lexend';

  // Décoration Glassmorphism standard
  static BoxDecoration glassDecoration({
    required Color color,
    double opacity = 0.12,
    double borderRadius = 20,
    double borderWidth = 1.5,
    bool showShadow = true,
  }) {
    return BoxDecoration(
      color: color.withValues(alpha: opacity),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withValues(alpha: opacity),
          color.withValues(alpha: opacity * 0.5),
        ],
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: color.withValues(alpha: opacity * 3),
        width: borderWidth,
      ),
      boxShadow: showShadow
          ? [
              BoxShadow(
                color: color.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ]
          : [],
    );
  }

  // Helper interne pour TextStyle
  static TextStyle _baseStyle({
    required double fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Police unique - Lexend pour tout
  static TextStyle lexendRegular(
    double fontSize, {
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? letterSpacing,
    double? height,
  }) {
    return _baseStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Titres - Lexend Bold
  static TextStyle titleLarge({Color? color, double size = 40}) {
    return _baseStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle titleMedium({Color? color, double size = 28}) {
    return _baseStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle titleSmall({Color? color}) {
    return _baseStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  // Sous-titres
  static TextStyle subtitle({Color? color}) {
    return _baseStyle(
      fontSize: 17,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle subtitleSmall({Color? color}) {
    return _baseStyle(
      fontSize: 14,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  // Corps du texte
  static TextStyle bodyLarge({Color? color}) {
    return _baseStyle(
      fontSize: 16,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyMedium({Color? color}) {
    return _baseStyle(
      fontSize: 15,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodySmall({Color? color}) {
    return _baseStyle(
      fontSize: 13,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  // Labels et tags
  static TextStyle label({Color? color}) {
    return _baseStyle(
      fontSize: 13,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle labelSmall({Color? color}) {
    return _baseStyle(
      fontSize: 11,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  // Caption
  static TextStyle caption({Color? color}) {
    return _baseStyle(
      fontSize: 11,
      color: color ?? Colors.grey[500],
      fontWeight: FontWeight.w400,
    );
  }

  // ========== VARIANTES MOBILES ==========

  static TextStyle titleLargeMobile({Color? color}) => 
    titleLarge(color: color, size: 32);

  static TextStyle titleMediumMobile({Color? color}) => 
    titleMedium(color: color, size: 24);

  static TextStyle titleSmallMobile({Color? color}) => 
    titleSmall(color: color).copyWith(fontSize: 20);

  static TextStyle subtitleMobile({Color? color}) => 
    subtitle(color: color).copyWith(fontSize: 15);

  static TextStyle subtitleSmallMobile({Color? color}) => 
    subtitleSmall(color: color).copyWith(fontSize: 13);

  static TextStyle bodyLargeMobile({Color? color}) => 
    bodyLarge(color: color).copyWith(fontSize: 14);
}
