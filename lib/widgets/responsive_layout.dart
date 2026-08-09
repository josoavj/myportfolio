import 'package:flutter/material.dart';

/// Breakpoints standards pour le portfolio
class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

/// Widget utilitaire pour gérer les mises en page responsives
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// Méthodes statiques utilitaires
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppBreakpoints.mobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppBreakpoints.mobile &&
      MediaQuery.of(context).size.width < AppBreakpoints.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppBreakpoints.tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.tablet) {
          return desktop;
        } else if (constraints.maxWidth >= AppBreakpoints.mobile) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
