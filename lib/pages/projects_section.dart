import 'package:flutter/material.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/pages/all_projects_modal.dart';
import 'package:myportfolio/pages/project_detail_page.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/extensions.dart';
import 'package:myportfolio/widgets/project_card.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/responsive_layout.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const int _displayCount = 4;

  @override
  Widget build(BuildContext context) {
    final projects = AppData.getProjects();
    final displayedProjects = projects.take(_displayCount).toList();
    final hasMoreProjects = projects.length > _displayCount;
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: Column(
        children: [
          const SectionTitle(title: 'Mes Projets'),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
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
                        childAspectRatio: crossAxisCount == 1 ? 1.5 : 0.85,
                      ),
                      itemCount: displayedProjects.length,
                      itemBuilder: (context, index) {
                        return ProjectCard(
                          project: {
                            'name': displayedProjects[index].name,
                            'description': displayedProjects[index].description,
                            'language': displayedProjects[index].language,
                            'stars': displayedProjects[index].stars,
                            'url': displayedProjects[index].url,
                            'category': displayedProjects[index].category,
                          },
                          languageColor: displayedProjects[index]
                              .language
                              .getLanguageColor(),
                          index: index,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProjectDetailPage(
                                  project: displayedProjects[index],
                                ),
                              ),
                            );
                          },
                        ).withSlideUp(
                          delay: Duration(milliseconds: 200 + (index * 100)),
                          distance: 20,
                        );
                      },
                    );
                  },
                ),
                if (hasMoreProjects) ...[
                  const SizedBox(height: 50),
                  _buildViewAllButton(context, List<Project>.from(projects)),
                ],
              ],
            ),
          ),
        ],
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
