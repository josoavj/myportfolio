import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Configuration centralisée du thème et des polices
class AppTheme {
  // Décoration Glassmorphism standard
  static BoxDecoration glassDecoration({
    required Color color,
    double opacity = 0.12,
    double borderRadius = 20,
    double borderWidth = 1.5,
    bool showShadow = true,
  }) {
    // Note: Sur Web, si les perfs sont mauvaises, augmenter l'opacité et retirer le flou
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

  // Police unique - Lexend pour tout
  static TextStyle lexendRegular(
    double fontSize, {
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.lexend(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Titres - Lexend Bold
  static TextStyle titleLarge({Color? color, double size = 40}) {
    return GoogleFonts.lexend(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle titleMedium({Color? color, double size = 28}) {
    return GoogleFonts.lexend(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle titleSmall({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  // Sous-titres - Lexend Light
  static TextStyle subtitle({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 17,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle subtitleSmall({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 14,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  // Corps du texte - Lexend Regular
  static TextStyle bodyLarge({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 16,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyMedium({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 15,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodySmall({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 13,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  // Labels et tags - Lexend SemiBold
  static TextStyle label({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 13,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle labelSmall({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 11,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  // Caption - Lexend Regular
  static TextStyle caption({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 11,
      color: color ?? Colors.grey[500],
      fontWeight: FontWeight.w400,
    );
  }

  // ========== VARIANTES MOBILES ==========
  // Pour une meilleure lisibilité et adaptation sur petits écrans

  static TextStyle titleLargeMobile({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle titleMediumMobile({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle titleSmallMobile({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle subtitleMobile({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 15,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle subtitleSmallMobile({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 13,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyLargeMobile({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 14,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }
}
