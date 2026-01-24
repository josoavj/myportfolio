import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/pages/all_projects_modal.dart';
import 'package:myportfolio/pages/project_detail_page.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/utils/extensions.dart';
import 'package:myportfolio/widgets/project_card.dart';
import 'package:myportfolio/widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const int _displayCount = 4;

  @override
  Widget build(BuildContext context) {
    final projects = AppData.getProjects();
    final isMobile = MediaQuery.of(context).size.width < 600;
    final displayedProjects = projects.take(_displayCount).toList();
    final hasMoreProjects = projects.length > _displayCount;

    return Container(
      padding: isMobile
          ? const EdgeInsets.only(left: 16, right: 16, top: 80, bottom: 150)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          const SectionTitle(title: 'Projets'),
          SizedBox(height: isMobile ? 00 : 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 900
                        ? 3
                        : MediaQuery.of(context).size.width > 600
                            ? 2
                            : 1,
                    crossAxisSpacing: isMobile ? 12 : 20,
                    mainAxisSpacing: isMobile ? 16 : 20,
                    childAspectRatio: isMobile ? 1.7 : 0.9,
                  ),
                  itemCount: displayedProjects.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
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
                      child: ProjectCard(
                        project: {
                          'name': displayedProjects[index].name,
                          'description': displayedProjects[index].description,
                          'language': displayedProjects[index].language,
                          'stars': displayedProjects[index].stars,
                          'url': displayedProjects[index].url,
                        },
                        languageColor: displayedProjects[index]
                            .language
                            .getLanguageColor(),
                        index: index,
                      ),
                    );
                  },
                ),
                if (hasMoreProjects) ...[
                  SizedBox(
                    height: isMobile ? 20 : 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width < 600
                        ? double.infinity
                        : null,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return AllProjectsModal(
                              projects: projects,
                              initialDisplayCount: _displayCount,
                            );
                          },
                          transitionBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return ScaleTransition(
                              scale:
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic),
                              ),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 400),
                        );
                      },
                      icon: const Icon(Icons.expand_more),
                      label: const Text('Voir tous les projets'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width < 600 ? 20 : 30,
                          vertical:
                              MediaQuery.of(context).size.width < 600 ? 14 : 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ).withScaleIn(
                    delay: const Duration(
                      milliseconds: 600 + (_displayCount * 100),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
