import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/pages/project_detail_page.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/utils/extensions.dart';
import 'package:myportfolio/widgets/project_card.dart';

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
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = 'Tous';
  }

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
        return '';
      case 'Desktop':
        return '';
      case 'Web':
        return '';
      case 'Backend':
        return '';
      case 'Tools':
        return '';
      default:
        return '';
    }
  }

  IconData getCategoryIconData(String category) {
    switch (category) {
      case 'Mobile':
        return FontAwesomeIcons.mobileScreenButton;
      case 'Desktop':
        return FontAwesomeIcons.desktop;
      case 'Web':
        return FontAwesomeIcons.globe;
      case 'Backend':
        return FontAwesomeIcons.server;
      case 'Tools':
        return FontAwesomeIcons.screwdriverWrench;
      case 'Tous':
        return FontAwesomeIcons.tableCells;
      default:
        return FontAwesomeIcons.cube;
    }
  }

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
            // Header avec titre et bouton fermeture
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Tous les projets (${filteredProjects.length})',
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
            const SizedBox(height: 20),

            // Filtres par catégorie
            if (isSmall)
              SizedBox(
                height: 65,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      final isSelected = selectedCategory == category;
                      final color = getCategoryColor(category);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        color.withValues(alpha: 0.15),
                                        color.withValues(alpha: 0.05),
                                      ],
                                    )
                                  : LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
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
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.1),
                                        blurRadius: 12,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  getCategoryIconData(category),
                                  size: 14,
                                  color: isSelected ? color : Colors.white70,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected ? color : Colors.white,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            else
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: categories.map((category) {
                  final isSelected = selectedCategory == category;
                  final color = getCategoryColor(category);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  color.withValues(alpha: 0.15),
                                  color.withValues(alpha: 0.05),
                                ],
                              )
                            : LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
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
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            getCategoryIconData(category),
                            size: 14,
                            color: isSelected ? color : Colors.white70,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? color : Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            const SizedBox(height: 20),

            // Grid des projets filtrés
            Expanded(
              child: filteredProjects.isEmpty
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
                            style: TextStyle(
                              color: Colors.grey.withValues(alpha: 0.7),
                              fontSize: 18,
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
                        childAspectRatio:
                            isSmall ? 1.2 : (isMobile ? 1.6 : 2.75),
                      ),
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProjectDetailPage(
                                    project: filteredProjects[index]),
                              ),
                            );
                          },
                          child: ProjectCard(
                            project: {
                              'name': filteredProjects[index].name,
                              'description':
                                  filteredProjects[index].description,
                              'language': filteredProjects[index].language,
                              'stars': filteredProjects[index].stars,
                              'url': filteredProjects[index].url,
                              'category': filteredProjects[index].category,
                            },
                            languageColor: filteredProjects[index]
                                .language
                                .getLanguageColor(),
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
