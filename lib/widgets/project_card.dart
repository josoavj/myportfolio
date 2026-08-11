import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myportfolio/utils/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final Color languageColor;
  final int index;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.languageColor,
    this.index = 0,
    this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Mobile':
      case 'Desktop':
        return Colors.blue;
      case 'Web':
        return Colors.cyan;
      case 'Backend':
        return Colors.orange;
      case 'Tools':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  FaIconData getCategoryIconData(String category) {
    switch (category) {
      case 'Mobile':
        return FontAwesomeIcons.mobileScreenButton;
      case 'Desktop':
        return FontAwesomeIcons.desktop;
      case 'Web':
        return FontAwesomeIcons.globe;
      case 'Backend':
        return FontAwesomeIcons.server;
      case 'Tools':
        return FontAwesomeIcons.screwdriverWrench;
      default:
        return FontAwesomeIcons.cube;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedScale(
          scale: isHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, isHovered ? -8 : 0, 0),
            decoration: AppTheme.glassDecoration(
              color: isHovered ? Colors.blue : Colors.blueGrey,
              opacity: isHovered ? 0.2 : 0.1,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.folder_outlined,
                              color: isHovered ? Colors.blue.shade300 : Colors.blue.shade200,
                              size: 28,
                            ),
                            const Spacer(),
                            _buildStarsBadge(),
                          ],
                        ),
                        const SizedBox(height: 15),
                        if (widget.project['category'] != null) _buildCategoryBadge(),
                        const SizedBox(height: 12),
                        Text(
                          widget.project['name'],
                          style: AppTheme.lexendRegular(
                            18,
                            color: isHovered ? Colors.blue.shade300 : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            widget.project['description'],
                            style: AppTheme.lexendRegular(
                              13,
                              color: Colors.grey.shade300,
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildLanguageInfo(),
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

  Widget _buildStarsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            '${widget.project['stars']}',
            style: AppTheme.lexendRegular(12, color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge() {
    final category = widget.project['category'];
    final color = getCategoryColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(getCategoryIconData(category), size: 10, color: color),
          const SizedBox(width: 6),
          Text(
            category,
            style: AppTheme.lexendRegular(
              10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageInfo() {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: widget.languageColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.languageColor.withValues(alpha: 0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.project['language'],
            style: AppTheme.lexendRegular(11, color: Colors.grey.shade400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
