import 'package:flutter/material.dart';

/// Widget pour ajouter un délai à une animation sans casser le layout
class DelayedAnimation extends StatefulWidget {
  final Duration delay;
  final Widget child;

  const DelayedAnimation({
    required this.delay,
    required this.child,
    super.key,
  });

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _show = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // On garde l'espace occupé (Opacity 0) au lieu de SizedBox.shrink
    // pour éviter les trous dans les GridView
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: _show ? 1.0 : 0.0,
      child: widget.child,
    );
  }
}

/// Classe utilitaire pour les animations réutilisables
class AnimationUtils {
  static Widget fadeIn({
    required Widget child,
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
  }) {
    return DelayedAnimation(
      delay: delay,
      child: child,
    );
  }

  static Widget slideUp({
    required Widget child,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    double distance = 20.0,
  }) {
    return DelayedAnimation(
      delay: delay,
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(
          begin: Offset(0, distance),
          end: Offset.zero,
        ),
        duration: duration,
        curve: Curves.easeOutCubic,
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: child,
          );
        },
        child: child,
      ),
    );
  }

  static Widget scaleIn({
    required Widget child,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
  }) {
    return DelayedAnimation(
      delay: delay,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.8, end: 1.0),
        duration: duration,
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }

  static Widget staggeredFadeSlide({
    required List<Widget> children,
    Duration baseDelay = Duration.zero,
    Duration staggerDelay = const Duration(milliseconds: 100),
    Duration duration = const Duration(milliseconds: 800),
    required Widget Function(Widget, Animation<double>) builder,
  }) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.center,
      children: List.generate(
        children.length,
        (index) {
          final delay = baseDelay + (staggerDelay * index);
          return slideUp(
            child: builder(children[index], const AlwaysStoppedAnimation(1.0)),
            delay: delay,
            duration: duration,
          );
        },
      ),
    );
  }

  static Widget pulse({
    required Widget child,
    bool enabled = true,
  }) {
    if (!enabled) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.02),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: child,
    );
  }
}

extension AnimationExtension on Widget {
  Widget withFadeIn({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
  }) {
    return AnimationUtils.fadeIn(child: this, duration: duration, delay: delay);
  }

  Widget withSlideUp({
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    double distance = 20.0,
  }) {
    return AnimationUtils.slideUp(
      child: this,
      duration: duration,
      delay: delay,
      distance: distance,
    );
  }

  Widget withScaleIn({
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
  }) {
    return AnimationUtils.scaleIn(child: this, duration: duration, delay: delay);
  }

  Widget withPulse({bool enabled = true}) {
    return AnimationUtils.pulse(child: this, enabled: enabled);
  }
}
