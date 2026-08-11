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

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: SizedBox(
          width: widget.width,
          height: cardHeight,
          child: AnimatedScale(
            scale: isHovered ? 1.03 : 1.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0, isHovered ? -5 : 0, 0),
              decoration: AppTheme.glassDecoration(
                color: isHovered ? widget.color : widget.color.withValues(alpha: 0.5),
                opacity: isHovered ? 0.2 : 0.12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: EdgeInsets.all(isSmall ? 16 : 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.icon,
                          size: isSmall ? 28 : 44,
                          color: isHovered ? widget.color : widget.color.withValues(alpha: 0.8),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.title,
                          style: isSmall
                              ? AppTheme.lexendRegular(18, color: widget.color, fontWeight: FontWeight.bold)
                              : AppTheme.titleMedium(color: widget.color),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.subtitle,
                          style: AppTheme.lexendRegular(10, color: Colors.grey.shade400, fontWeight: FontWeight.w500),
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
        ),
      ),
    );
  }
}
