import 'package:flutter/material.dart';

/// Widget pour ajouter un délai à une animation
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
  late Future<void> _delayFuture;

  @override
  void initState() {
    super.initState();
    _delayFuture = Future.delayed(widget.delay);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _delayFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.child;
        }
        return const SizedBox.shrink();
      },
    );
  }
}

/// Classe utilitaire pour les animations réutilisables
class AnimationUtils {
  /// Animation fade-in simple avec support du delay
  static Widget fadeIn({
    required Widget child,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
  }) {
    return DelayedAnimation(
      delay: delay,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: duration,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }

  /// Animation slide-up depuis le bas avec support du delay
  static Widget slideUp({
    required Widget child,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    double distance = 30.0,
  }) {
    return DelayedAnimation(
      delay: delay,
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(
          begin: Offset(0, distance),
          end: Offset.zero,
        ),
        duration: duration,
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

  /// Animation scale avec bounce et support du delay
  static Widget scaleIn({
    required Widget child,
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) {
    return DelayedAnimation(
      delay: delay,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: duration,
        curve: Curves.elasticOut,
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

  /// Animation pour une liste d'enfants avec stagger
  static Widget staggeredFadeSlide({
    required List<Widget> children,
    Duration baseDelay = Duration.zero,
    Duration staggerDelay = const Duration(milliseconds: 100),
    Duration duration = const Duration(milliseconds: 600),
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
          return DelayedAnimation(
            delay: delay,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: duration,
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - value) * 20),
                  child: Opacity(
                    opacity: value,
                    child:
                        builder(children[index], AlwaysStoppedAnimation(value)),
                  ),
                );
              },
              child: children[index],
            ),
          );
        },
      ),
    );
  }

  /// Animation pulse pour attirer l'attention
  static Widget pulse({
    required Widget child,
    bool enabled = true,
  }) {
    if (!enabled) return child;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.05),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      onEnd: () {},
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Animation de couleur pour hover effects
  static Widget hoverColor({
    required Widget child,
    required Color normalColor,
    required Color hoverColor,
  }) {
    return MouseRegion(
      onEnter: (_) {},
      onExit: (_) {},
      child: child,
    );
  }
}

/// Extension pour ajouter facilement des animations aux widgets
extension AnimationExtension on Widget {
  Widget withFadeIn({
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
  }) {
    return AnimationUtils.fadeIn(child: this, duration: duration, delay: delay);
  }

  Widget withSlideUp({
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    double distance = 30.0,
  }) {
    return AnimationUtils.slideUp(
      child: this,
      duration: duration,
      delay: delay,
      distance: distance,
    );
  }

  Widget withScaleIn({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) {
    return AnimationUtils.scaleIn(
        child: this, duration: duration, delay: delay);
  }

  Widget withPulse({bool enabled = true}) {
    return AnimationUtils.pulse(child: this, enabled: enabled);
  }
}
