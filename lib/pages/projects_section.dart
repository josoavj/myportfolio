import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/utils/extensions.dart';
import 'package:myportfolio/widgets/project_card.dart';
import 'package:myportfolio/widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = AppData.getProjects();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          const SectionTitle(title: 'Projets'),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
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
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(
                  project: {
                    'name': projects[index].name,
                    'description': projects[index].description,
                    'language': projects[index].language,
                    'stars': projects[index].stars,
                    'url': projects[index].url,
                  },
                  languageColor: projects[index].language.getLanguageColor(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
