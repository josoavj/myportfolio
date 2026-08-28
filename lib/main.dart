import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/pages/portfolio_home_page.dart';
import 'package:myportfolio/services/github_service.dart';

void main() {
  // Désactiver la récupération des polices sur le réseau pour la rapidité
  GoogleFonts.config.allowRuntimeFetching = false;
  
  // Initialiser les services
  GitHubService.initializeServerlessUrl();
  runApp(
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppConstants.primaryDark,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Lexend',
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}
