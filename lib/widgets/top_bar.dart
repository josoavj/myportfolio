import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/utils/app_theme.dart';

/// Barre du haut flottante et centrée :
/// - Initiales « JV » en blanc sans fond à gauche
/// - Bouton « Menu » épuré à droite
/// - Le tout contenu dans un bloc rectangulaire aux coins arrondis
/// - Popup de navigation qui s'affiche sous la barre (aligné à droite sur desktop, centré sur mobile)
class TopBar extends StatefulWidget {
  final Map<String, GlobalKey> sections;
  final ScrollController scrollController;

  const TopBar({
    super.key,
    required this.sections,
    required this.scrollController,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  bool _scrolled = false;

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
    final controller = widget.scrollController;
    final scrolled = controller.hasClients && controller.offset > 8;
    if (scrolled != _scrolled) {
      setState(() => _scrolled = scrolled);
    }
  }

  String _currentSection() {
    String found = '';
    double closest = double.infinity;
    widget.sections.forEach((name, key) {
      final context = key.currentContext;
      if (context == null) return;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) return;
      final distance = box.localToGlobal(Offset.zero).dy.abs();
      if (distance < closest) {
        closest = distance;
        found = name;
      }
    });
    return found;
  }

  void _scrollToSection(String name) {
    final context = widget.sections[name]?.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToTop() {
    if (!widget.scrollController.hasClients) return;
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _openMenu() async {
    final active = _currentSection();
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    final selected = await showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fermer le menu',
      barrierColor: isMobile ? Colors.black.withValues(alpha: 0.5) : Colors.transparent,
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _MenuPanel(
          sections: widget.sections.keys.toList(),
          active: active,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved =
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
    if (selected != null && mounted) {
      _scrollToSection(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 20,
            vertical: 12,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppConstants.secondaryDark.withValues(alpha: _scrolled ? 0.94 : 0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue.withValues(alpha: _scrolled ? 0.35 : 0.20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 16,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _buildLogo(),
                    const Spacer(),
                    _buildMenuButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Semantics(
      button: true,
      label: 'Retour en haut de la page',
      child: InkWell(
        onTap: _scrollToTop,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Text(
            'JV',
            style: AppTheme.lexendRegular(
              20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Semantics(
      button: true,
      label: 'Ouvrir le menu',
      child: InkWell(
        onTap: _openMenu,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'Menu',
                style: AppTheme.lexendRegular(
                  14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuPanel extends StatelessWidget {
  final List<String> sections;
  final String active;

  const _MenuPanel({required this.sections, required this.active});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 600;
    final panelWidth = isMobile ? size.width - 24 : 340.0;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: isMobile ? 76 : 84,
          left: isMobile ? 12 : 0,
          right: isMobile ? 12 : 0,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Align(
              alignment: isMobile ? Alignment.topCenter : Alignment.topRight,
              child: CallbackShortcuts(
                bindings: {
                  const SingleActivator(LogicalKeyboardKey.escape): () =>
                      Navigator.of(context).pop(),
                },
                child: Focus(
                  autofocus: true,
                  child: Material(
                    color: AppConstants.secondaryDark,
                    elevation: 16,
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: panelWidth,
                      decoration: BoxDecoration(
                        color: AppConstants.secondaryDark,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue.withValues(alpha: 0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(context),
                            const SizedBox(height: 4),
                            for (var i = 0; i < sections.length; i++)
                              _MenuItem(
                                index: i + 1,
                                label: sections[i],
                                isActive: sections[i] == active,
                                onTap: () =>
                                    Navigator.of(context).pop(sections[i]),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Text(
            'NAVIGATION',
            style: AppTheme.lexendRegular(
              11,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Fermer le menu',
            icon: const Icon(Icons.close, color: Colors.white70, size: 22),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final int index;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MenuItem({
    required this.index,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isActive,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.blue.withValues(alpha: 0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: AppTheme.lexendRegular(
                    12,
                    color: isActive ? Colors.blue.shade300 : Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: AppTheme.lexendRegular(
                    16,
                    color: isActive ? Colors.blue.shade200 : Colors.white,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
              if (isActive)
                Icon(Icons.circle, size: 8, color: Colors.blue.shade300),
            ],
          ),
        ),
      ),
    );
  }
}