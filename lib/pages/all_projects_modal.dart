import 'package:flutter/material.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/pages/project_detail_page.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/utils/extensions.dart';
import 'package:myportfolio/widgets/project_card.dart';

class AllProjectsModal extends StatelessWidget {
  final List<Project> projects;
  final int initialDisplayCount;

  const AllProjectsModal({
    super.key,
    required this.projects,
    this.initialDisplayCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;

    return Dialog(
      backgroundColor: const Color(0xFF0D1117),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isSmall ? double.infinity : 900,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        padding: EdgeInsets.all(isSmall ? 15 : 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tous les projets',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).withFadeIn(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmall ? 1 : 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProjectDetailPage(project: projects[index]),
                        ),
                      );
                    },
                    child: ProjectCard(
                      project: {
                        'name': projects[index].name,
                        'description': projects[index].description,
                        'language': projects[index].language,
                        'stars': projects[index].stars,
                        'url': projects[index].url,
                      },
                      languageColor:
                          projects[index].language.getLanguageColor(),
                      index: index,
                    ),
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
