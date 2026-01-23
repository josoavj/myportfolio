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
    final isMobile = MediaQuery.of(context).size.width < 900;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Tous les projets (${projects.length})',
                    style: TextStyle(
                      fontSize: isSmall ? 20 : 28,
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
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmall ? 1 : (isMobile ? 2 : 3),
                  crossAxisSpacing: isSmall ? 12 : 16,
                  mainAxisSpacing: isSmall ? 12 : 16,
                  childAspectRatio: isSmall ? 1.7 : (isMobile ? 1.7 : 2.75),
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
