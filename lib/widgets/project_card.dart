import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_theme.dart';

class ProjectCard extends StatelessWidget {
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

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Mobile':
        return Colors.blue;
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

  String getCategoryIcon(String category) {
    switch (category) {
      case 'Mobile':
        return '📱';
      case 'Desktop':
        return '🖥️';
      case 'Web':
        return '🌐';
      case 'Backend':
        return '⚙️';
      case 'Tools':
        return '🛠️';
      default:
        return '📦';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.withValues(alpha: 0.12),
                Colors.blue.withValues(alpha: 0.06),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.blue.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.folder, color: Colors.blue, size: 28),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${project['stars']}',
                          style: AppTheme.labelSmall(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Badge de catégorie
              if (project['category'] != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: getCategoryColor(project['category'])
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: getCategoryColor(project['category'])
                          .withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    '${getCategoryIcon(project['category'])} ${project['category']}',
                    style: TextStyle(
                      color: getCategoryColor(project['category']),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                project['name'],
                style: AppTheme.titleMedium(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  project['description'],
                  style: AppTheme.bodyMedium(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: languageColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      project['language'],
                      style: AppTheme.labelSmall(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
