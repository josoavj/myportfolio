import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Configuration centralisée du thème et des polices
class AppTheme {
  // Polices
  static TextStyle lexendRegular(
    double fontSize, {
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.lexend(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle poppinsRegular(
    double fontSize, {
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // Titres - Lexend Bold
  static TextStyle titleLarge({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }

  static TextStyle titleMedium({Color? color}) {
    return GoogleFonts.lexend(
      fontSize: 28,
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

  // Sous-titres - Poppins
  static TextStyle subtitle({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 17,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle subtitleSmall({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 14,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  // Corps du texte - Poppins
  static TextStyle bodyLarge({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 16,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyMedium({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 15,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodySmall({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 13,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  // Labels et tags - Poppins SemiBold
  static TextStyle label({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 13,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle labelSmall({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 11,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  // Caption - Poppins Regular
  static TextStyle caption({Color? color}) {
    return GoogleFonts.poppins(
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
    return GoogleFonts.poppins(
      fontSize: 15,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle subtitleSmallMobile({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 13,
      color: color ?? Colors.grey[400],
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyLargeMobile({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 14,
      color: color ?? Colors.white,
      fontWeight: FontWeight.w400,
    );
  }
}
