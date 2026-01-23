import 'package:flutter/material.dart';

class AnimatedScrollSection extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;

  const AnimatedScrollSection({
    super.key,
    required this.child,
    required this.scrollController,
  });

  @override
  State<AnimatedScrollSection> createState() => _AnimatedScrollSectionState();
}

class _AnimatedScrollSectionState extends State<AnimatedScrollSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    widget.scrollController.addListener(_handleScroll);
    Future.delayed(const Duration(milliseconds: 100), () {
      _animationController.forward();
    });
  }

  void _handleScroll() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;

      // Déclenche l'animation quand la section est visible à 30% de l'écran
      if (position.dy < screenHeight * 0.7 &&
          position.dy > -renderBox.size.height) {
        if (_animationController.status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
