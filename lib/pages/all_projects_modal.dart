import 'package:flutter/material.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/utils/project_navigation.dart';
import 'package:myportfolio/widgets/category_chip.dart';
import 'package:myportfolio/widgets/project_card.dart';

import '../utils/app_theme.dart';

class AllProjectsModal extends StatefulWidget {
  final List<Project> projects;
  final int initialDisplayCount;

  const AllProjectsModal({
    super.key,
    required this.projects,
    this.initialDisplayCount = 4,
  });

  @override
  State<AllProjectsModal> createState() => _AllProjectsModalState();
}

class _AllProjectsModalState extends State<AllProjectsModal> {
  String selectedCategory = 'Tous';

  List<String> get categories {
    final cats = {'Tous', ...widget.projects.map((p) => p.category)};
    return cats.toList();
  }

  List<Project> get filteredProjects {
    if (selectedCategory == 'Tous') {
      return widget.projects;
    }
    return widget.projects
        .where((p) => p.category == selectedCategory)
        .toList();
  }

  Widget _buildChip(String category, {required double fontSize}) {
    return CategoryChip(
      category: category,
      isSelected: selectedCategory == category,
      fontSize: fontSize,
      onTap: () => setState(() => selectedCategory = category),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final isMobile = MediaQuery.of(context).size.width < 900;
    final projects = filteredProjects;

    return Dialog.fullscreen(
      backgroundColor: const Color(0xFF0D1117).withValues(alpha: 0.98),
      child: Container(
        padding: EdgeInsets.only(
          left: isSmall ? 12 : 20,
          right: isSmall ? 12 : 20,
          top: isSmall ? 40 : 24,
          bottom: isSmall ? 16 : 24,
        ),
        child: Column(
          children: [
            // Header avec titre et bouton fermeture
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Tous les projets (${projects.length})',
                    style: AppTheme.lexendRegular(
                      isSmall ? 20 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).withFadeIn(),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Filtres par catégorie
            if (isSmall)
              SizedBox(
                height: 65,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories
                        .map((category) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: _buildChip(category, fontSize: 13),
                            ))
                        .toList(),
                  ),
                ),
              )
            else
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: categories
                    .map((category) => _buildChip(category, fontSize: 14))
                    .toList(),
              ),
            const SizedBox(height: 20),

            // Grille des projets filtrés
            Expanded(
              child: projects.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_off,
                            size: 64,
                            color: Colors.grey.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun projet trouvé',
                            style: AppTheme.lexendRegular(
                              18,
                              color: Colors.grey.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isSmall ? 1 : (isMobile ? 2 : 3),
                        crossAxisSpacing: isSmall ? 12 : 16,
                        mainAxisSpacing: isSmall ? 12 : 16,
                        // Hauteur fixe : un ratio rend la carte trop basse sur
                        // grand écran et coupe la description.
                        mainAxisExtent: ProjectCard.cardExtent,
                      ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return ProjectCard(
                          project: project,
                          onTap: () => openProject(context, project),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
