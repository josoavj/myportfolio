import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_theme.dart';

class StatCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final double width;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.width,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final cardHeight = isSmall ? null : 220.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: SizedBox(
        width: widget.width,
        height: cardHeight,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: isHovered
              ? (Matrix4.identity()..translateByDouble(0.0, -5.0, 0.0, 0.0))
              : Matrix4.identity(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: EdgeInsets.all(isSmall ? 15 : 25),
                decoration: AppTheme.glassDecoration(
                  color: isHovered ? widget.color : widget.color.withValues(alpha: 0.5),
                  opacity: isHovered ? 0.2 : 0.12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      size: isSmall ? 32 : 44,
                      color: isHovered ? widget.color : widget.color.withValues(alpha: 0.8),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.title,
                      style: isSmall
                          ? AppTheme.titleSmall(color: widget.color)
                          : AppTheme.titleMedium(color: widget.color),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      style: AppTheme.labelSmall(color: Colors.grey.shade400),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
