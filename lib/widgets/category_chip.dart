import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/category_style.dart';

/// Pastille de filtre par catégorie (utilisée dans « Tous les projets »).
class CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;
  final double fontSize;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(category);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)]
                : [
                    Colors.grey.withValues(alpha: 0.05),
                    Colors.grey.withValues(alpha: 0.02),
                  ],
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? color.withValues(alpha: 0.4)
                : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              categoryIcon(category),
              size: 14,
              color: isSelected ? color : Colors.white70,
            ),
            const SizedBox(width: 6),
            Text(
              category,
              style: AppTheme.lexendRegular(
                fontSize,
                color: isSelected ? color : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
