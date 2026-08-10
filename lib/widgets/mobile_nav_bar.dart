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
  bool isMenuOpen = false;

  final List<String> primarySections = ['Accueil', 'Projets', 'Contact'];
  final List<String> secondarySections = [
    'À propos',
    'Expérience',
    'Formation',
    'Compétences'
  ];

  final Map<String, IconData> sectionIcons = {
    'Accueil': Icons.home_rounded,
    'À propos': Icons.face_rounded,
    'Expérience': Icons.terminal_rounded,
    'Formation': Icons.school_rounded,
    'Compétences': Icons.offline_bolt_rounded,
    'Projets': Icons.rocket_launch_rounded,
    'Contact': Icons.quick_contacts_mail_rounded,
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
      setState(() => isMenuOpen = false);
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dockWidth = MediaQuery.of(context).size.width * 0.94;
    const maxDockWidth = 450.0;
    final finalWidth = dockWidth > maxDockWidth ? maxDockWidth : dockWidth;

    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (isMenuOpen)
            GestureDetector(
              onTap: () => setState(() => isMenuOpen = false),
              child: Container(
                color: Colors.black.withValues(alpha: 0.15),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
              ),
            ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuart,
            bottom: isMenuOpen ? 105 : -350,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: isMenuOpen ? 1 : 0,
              child: _buildSecondaryMenu(finalWidth),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: finalWidth),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...primarySections.map((name) {
                            final isActive = activeSection == name;
                            return _NavBarItem(
                              icon: sectionIcons[name]!,
                              label: name,
                              isActive: isActive,
                              onTap: () =>
                                  _scrollToSection(widget.sections[name]!),
                            );
                          }),
                          _MoreButton(
                            isOpen: isMenuOpen,
                            onTap: () =>
                                setState(() => isMenuOpen = !isMenuOpen),
                            isActive: secondarySections.contains(activeSection),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryMenu(double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: secondarySections.map((name) {
                final isActive = activeSection == name;
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    leading: Icon(
                      sectionIcons[name],
                      color: isActive ? Colors.blue.shade300 : Colors.white60,
                      size: 22,
                    ),
                    title: Text(
                      name,
                      style: AppTheme.lexendRegular(
                        15,
                        color: isActive ? Colors.blue.shade300 : Colors.white70,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    onTap: () => _scrollToSection(widget.sections[name]!),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    selected: isActive,
                    selectedTileColor: Colors.blue.withValues(alpha: 0.1),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: Icon(
                icon,
                color: isActive ? Colors.blue.shade300 : Colors.white54,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.lexendRegular(
                10,
                color: isActive ? Colors.blue.shade300 : Colors.white54,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 4,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 4 : 0,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (isActive)
                      BoxShadow(
                        color: Colors.blue.shade300.withValues(alpha: 0.6),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  final bool isOpen;
  final bool isActive;
  final VoidCallback onTap;

  const _MoreButton({
    required this.isOpen,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: (isOpen || isActive)
                      ? Colors.blue.withValues(alpha: 0.15)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isOpen ? Icons.close_rounded : Icons.widgets_rounded,
                  color: (isOpen || isActive) ? Colors.blue.shade300 : Colors.white60,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Plus',
              style: AppTheme.lexendRegular(
                10,
                color: (isOpen || isActive) ? Colors.blue.shade300 : Colors.white54,
                fontWeight: (isOpen || isActive) ? FontWeight.bold : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
