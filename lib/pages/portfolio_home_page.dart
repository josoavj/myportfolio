import 'package:flutter/material.dart';
import 'package:myportfolio/pages/about_section.dart';
import 'package:myportfolio/pages/contact_section.dart';
import 'package:myportfolio/pages/education_section.dart';
import 'package:myportfolio/pages/experience_section.dart';
import 'package:myportfolio/pages/footer_section.dart';
import 'package:myportfolio/pages/header_section.dart';
import 'package:myportfolio/pages/projects_section.dart';
import 'package:myportfolio/pages/skills_section.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: const [
              HeaderSection(),
              AboutSection(),
              ExperienceSection(),
              EducationSection(),
              SkillsSection(),
              ProjectsSection(),
              ContactSection(),
              FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
