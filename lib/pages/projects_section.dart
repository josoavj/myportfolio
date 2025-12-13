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
    final displayedProjects = projects.take(_displayCount).toList();
    final hasMoreProjects = projects.length > _displayCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          const SectionTitle(title: 'Projets'),
          const SizedBox(height: 40),
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
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.9,
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
                  const SizedBox(height: 50),
                  OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AllProjectsModal(
                          projects: projects,
                          initialDisplayCount: _displayCount,
                        ),
                      );
                    },
                    icon: const Icon(Icons.expand_more),
                    label: const Text('Voir tous les projets'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
