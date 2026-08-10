import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/pages/about_section.dart';
import 'package:myportfolio/pages/contact_section.dart';
import 'package:myportfolio/pages/education_section.dart';
import 'package:myportfolio/pages/experience_section.dart';
import 'package:myportfolio/pages/footer_section.dart';
import 'package:myportfolio/pages/header_section.dart';
import 'package:myportfolio/pages/projects_section.dart';
import 'package:myportfolio/pages/skills_section.dart';
import 'package:myportfolio/widgets/animated_scroll_section.dart';
import 'package:myportfolio/widgets/nav_bar.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late ScrollController _scrollController;

  final Map<String, GlobalKey> _sectionKeys = {
    'Accueil': GlobalKey(),
    'À propos': GlobalKey(),
    'Expérience': GlobalKey(),
    'Formation': GlobalKey(),
    'Compétences': GlobalKey(),
    'Projets': GlobalKey(),
    'Contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      drawer: isMobile ? _buildDrawer() : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppConstants.primaryDark.withValues(alpha: 0.8),
              elevation: 0,
              title: Text(
                'JV',
                style: TextStyle(
                  color: Colors.blue.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            )
          : null,
      body: Stack(
        children: [
          Scrollbar(
            controller: _scrollController,
            thickness: 8,
            radius: const Radius.circular(10),
            interactive: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    HeaderSection(key: _sectionKeys['Accueil']),
                    _buildSection(
                      key: _sectionKeys['À propos']!,
                      child: const AboutSection(),
                    ),
                    _buildSection(
                      key: _sectionKeys['Expérience']!,
                      child: const ExperienceSection(),
                      color: AppConstants.secondaryDark,
                    ),
                    _buildSection(
                      key: _sectionKeys['Formation']!,
                      child: const EducationSection(),
                    ),
                    _buildSection(
                      key: _sectionKeys['Compétences']!,
                      child: const SkillsSection(),
                      color: AppConstants.secondaryDark,
                    ),
                    _buildSection(
                      key: _sectionKeys['Projets']!,
                      child: const ProjectsSection(),
                    ),
                    _buildSection(
                      key: _sectionKeys['Contact']!,
                      child: const ContactSection(),
                      color: AppConstants.secondaryDark,
                    ),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              sections: _sectionKeys,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required GlobalKey key,
    required Widget child,
    Color? color,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      color: color,
      child: AnimatedScrollSection(
        scrollController: _scrollController,
        child: child,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppConstants.primaryDark,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppConstants.primaryDark, AppConstants.secondaryDark],
              ),
            ),
            child: const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/mypfp.jpg'),
              ),
            ),
          ),
          ..._sectionKeys.entries.map((entry) {
            return ListTile(
              title: Text(
                entry.key,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Scrollable.ensureVisible(
                  entry.value.currentContext!,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutCubic,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
