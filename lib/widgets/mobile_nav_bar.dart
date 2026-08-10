import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_theme.dart';

class MobileNavBar extends StatefulWidget {
  final Map<String, GlobalKey> sections;
  final ScrollController scrollController;

  const MobileNavBar({
    super.key,
    required this.sections,
    required this.scrollController,
  });

  @override
  State<MobileNavBar> createState() => _MobileNavBarState();
}

class _MobileNavBarState extends State<MobileNavBar> {
  String activeSection = 'Accueil';

  final Map<String, IconData> sectionIcons = {
    'Accueil': Icons.home_rounded,
    'À propos': Icons.person_rounded,
    'Expérience': Icons.work_rounded,
    'Formation': Icons.school_rounded,
    'Compétences': Icons.bolt_rounded,
    'Projets': Icons.folder_rounded,
    'Contact': Icons.mail_rounded,
  };

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    String foundSection = '';
    double closestDistance = double.infinity;

    widget.sections.forEach((name, key) {
      final context = key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero).dy.abs();
        if (position < closestDistance) {
          closestDistance = position;
          foundSection = name;
        }
      }
    });

    if (foundSection.isNotEmpty && foundSection != activeSection) {
      setState(() {
        activeSection = foundSection;
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: AppTheme.glassDecoration(
                color: Colors.blueGrey,
                opacity: 0.15,
                borderRadius: 40,
                showShadow: true,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.sections.entries.map((entry) {
                    final name = entry.key;
                    final key = entry.value;
                    final isActive = activeSection == name;

                    return _MobileNavBarItem(
                      icon: sectionIcons[name] ?? Icons.circle,
                      label: name,
                      isActive: isActive,
                      onTap: () => _scrollToSection(key),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileNavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue.shade300 : Colors.white60,
              size: isActive ? 26 : 22,
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.blue.shade300,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
