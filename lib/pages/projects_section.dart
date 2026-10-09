import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/pages/all_projects_modal.dart';
import 'package:myportfolio/services/github_provider.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/project_navigation.dart';
import 'package:myportfolio/widgets/project_card.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/responsive_layout.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  static const int _displayCount = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Étoiles réelles depuis l'API GitHub ; valeurs de app_data en repli.
    final liveStars = ref.watch(repoStarsProvider).valueOrNull ?? const <String, int>{};
    final projects = AppData.getProjects().map((p) {
      final stars = liveStars[p.repoName];
      return stars == null ? p : p.withStars(stars);
    }).toList();

    final displayedProjects = projects.take(_displayCount).toList();
    final hasMoreProjects = projects.length > _displayCount;
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(title: 'Mes Projets'),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 3;
                  if (constraints.maxWidth < 600) {
                    crossAxisCount = 1;
                  } else if (constraints.maxWidth < 950) {
                    crossAxisCount = 2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      mainAxisExtent: ProjectCard.cardExtent,
                    ),
                    itemCount: displayedProjects.length,
                    itemBuilder: (context, index) {
                      final project = displayedProjects[index];
                      return ProjectCard(
                        project: project,
                        onTap: () => openProject(context, project),
                      );
                    },
                  );
                },
              ),
              if (hasMoreProjects) ...[
                const SizedBox(height: 50),
                _buildViewAllButton(context, projects),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewAllButton(BuildContext context, List<Project> projects) {
    return Container(
      decoration: AppTheme.glassDecoration(
        color: Colors.blue,
        opacity: 0.1,
        borderRadius: 30,
      ),
      child: OutlinedButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pageBuilder: (context, animation, secondaryAnimation) {
              return AllProjectsModal(
                projects: projects,
                initialDisplayCount: _displayCount,
              );
            },
            transitionBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
                  child: child,
                ),
              );
            },
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue,
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Voir tous les projets',
          style: AppTheme.label(color: Colors.blue.shade300),
        ),
      ),
    ).withScaleIn(delay: const Duration(milliseconds: 800));
  }
}
