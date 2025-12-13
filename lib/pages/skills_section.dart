import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/models/skill.dart';
import 'package:myportfolio/services/github_service.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/skill_bar.dart';
import 'package:myportfolio/widgets/stat_card.dart';
import 'package:myportfolio/widgets/tech_badge.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  late Future<List<int>> _contributionsFuture;

  @override
  void initState() {
    super.initState();
    _contributionsFuture = GitHubService.getUserContributions();
  }

  @override
  Widget build(BuildContext context) {
    final skillsByCategory = AppData.getSkillsByCategory();
    final badges = AppData.getTechBadges();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      color: AppConstants.secondaryDark,
      child: Column(
        children: [
          const SectionTitle(
              title: 'Stack Technique & Compétences', emoji: '🛠️'),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                ..._buildSkillCategories(skillsByCategory),
                const SizedBox(height: 60),
                _buildStatsCards(context),
                const SizedBox(height: 60),
                _buildTechBadges(badges),
                const SizedBox(height: 60),
                _buildContributionGraph(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSkillCategories(
      Map<String, List<Skill>> skillsByCategory) {
    List<Widget> widgets = [];
    int categoryIndex = 0;
    skillsByCategory.forEach((category, skills) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 20),
              child: Text(
                category,
                style: AppTheme.titleMedium(),
              ).withSlideUp(
                delay: Duration(milliseconds: 100 + (categoryIndex * 50)),
                distance: 15.0,
              ),
            ),
            ...skills.asMap().entries.map((entry) {
              final skillIndex = entry.key;
              final skill = entry.value;
              return SkillBar(
                name: skill.name,
                level: skill.level,
                color: skill.color,
              ).withFadeIn(
                delay: Duration(
                  milliseconds: 200 + (categoryIndex * 50) + (skillIndex * 30),
                ),
              );
            }),
          ],
        ),
      );
      widgets.add(const SizedBox(height: 50));
      categoryIndex++;
    });
    return widgets;
  }

  Widget _buildStatsCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            StatCard(
              icon: Icons.code,
              title: '5+',
              subtitle: 'Projets Complétés',
              color: Colors.blue,
              width: isMobile ? constraints.maxWidth : 200,
            ).withScaleIn(delay: const Duration(milliseconds: 300)),
            StatCard(
              icon: Icons.star,
              title: '56',
              subtitle: 'GitHub Stars',
              color: Colors.amber,
              width: isMobile ? constraints.maxWidth : 200,
            ).withScaleIn(delay: const Duration(milliseconds: 400)),
            StatCard(
              icon: Icons.terminal,
              title: '3+',
              subtitle: 'Années d\'Expérience',
              color: Colors.green,
              width: isMobile ? constraints.maxWidth : 200,
            ).withScaleIn(delay: const Duration(milliseconds: 500)),
            StatCard(
              icon: Icons.people,
              title: 'APEXNova Labs',
              subtitle: 'Membre Actif',
              color: Colors.purple,
              width: isMobile ? constraints.maxWidth : 200,
            ).withScaleIn(delay: const Duration(milliseconds: 600)),
          ],
        );
      },
    );
  }

  Widget _buildTechBadges(List<Map<String, dynamic>> badges) {
    return Column(
      children: [
        const Text(
          '🎯 Technologies & Outils',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).withFadeIn(delay: const Duration(milliseconds: 200)),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: badges.asMap().entries.map((entry) {
            final index = entry.key;
            final badge = entry.value;
            return TechBadge(
              name: badge['name'] as String,
              icon: badge['icon'] as String,
              color: badge['color'] as Color,
              index: index,
            ).withSlideUp(
              delay: Duration(milliseconds: 300 + (index * 40)),
              distance: 10.0,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContributionGraph() {
    return Column(
      children: [
        const Text(
          '📊 Activité de Contribution',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Simulation de graphique type GitHub',
          style: AppTheme.subtitleSmall(),
        ),
        const SizedBox(height: 30),
        _buildContributionHeatmap(),
        const SizedBox(height: 20),
        _buildContributionLegend(),
      ],
    );
  }

  Widget _buildContributionHeatmap() {
    return FutureBuilder<List<int>>(
      future: _contributionsFuture,
      builder: (context, snapshot) {
        List<List<int>> weeks = [];

        if (snapshot.hasData) {
          final contributions = snapshot.data!;
          // Organiser les contributions en semaines (12 semaines x 7 jours)
          for (int i = 0; i < contributions.length; i += 7) {
            weeks.add(contributions.sublist(i,
                (i + 7 > contributions.length ? contributions.length : i + 7)));
          }
        } else if (snapshot.hasError) {
          // Fallback aux données par défaut si erreur
          weeks = [
            [0, 1, 2, 1, 3, 2, 0],
            [2, 3, 1, 2, 4, 3, 1],
            [1, 2, 3, 4, 3, 2, 1],
            [3, 4, 2, 3, 2, 1, 2],
            [2, 1, 3, 2, 4, 3, 2],
            [4, 3, 2, 1, 2, 3, 1],
            [1, 2, 1, 3, 2, 1, 0],
            [2, 3, 4, 3, 2, 1, 2],
            [3, 2, 1, 2, 3, 4, 3],
            [1, 2, 3, 2, 1, 2, 3],
            [2, 4, 3, 2, 1, 3, 2],
            [3, 1, 2, 4, 3, 2, 1],
          ];
        } else {
          // Données par défaut en loading
          weeks = [
            [0, 1, 2, 1, 3, 2, 0],
            [2, 3, 1, 2, 4, 3, 1],
            [1, 2, 3, 4, 3, 2, 1],
            [3, 4, 2, 3, 2, 1, 2],
            [2, 1, 3, 2, 4, 3, 2],
            [4, 3, 2, 1, 2, 3, 1],
            [1, 2, 1, 3, 2, 1, 0],
            [2, 3, 4, 3, 2, 1, 2],
            [3, 2, 1, 2, 3, 4, 3],
            [1, 2, 3, 2, 1, 2, 3],
            [2, 4, 3, 2, 1, 3, 2],
            [3, 1, 2, 4, 3, 2, 1],
          ];
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppConstants.primaryDark,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildDayLabel('Lun'),
                          const SizedBox(height: 15),
                          _buildDayLabel('Mer'),
                          const SizedBox(height: 15),
                          _buildDayLabel('Ven'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: weeks.map((week) {
                        return Row(
                          children: week.asMap().entries.map((entry) {
                            final index = entry.key;
                            final level = entry.value;
                            return Padding(
                              padding: const EdgeInsets.all(2),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration:
                                    Duration(milliseconds: 800 + (index * 100)),
                                curve: Curves.easeOut,
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: _buildContributionSquare(level),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayLabel(String day) {
    return SizedBox(
      height: 12,
      child: Text(
        day,
        style: AppTheme.caption(),
      ),
    );
  }

  Widget _buildContributionSquare(int level) {
    Color getColor() {
      switch (level) {
        case 0:
          return AppConstants.secondaryDark;
        case 1:
          return Colors.green.withValues(alpha: 0.3);
        case 2:
          return Colors.green.withValues(alpha: 0.5);
        case 3:
          return Colors.green.withValues(alpha: 0.7);
        case 4:
          return Colors.green;
        default:
          return AppConstants.secondaryDark;
      }
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
    );
  }

  Widget _buildContributionLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Moins',
          style: AppTheme.labelSmall(),
        ),
        const SizedBox(width: 8),
        _buildContributionSquare(0),
        const SizedBox(width: 4),
        _buildContributionSquare(1),
        const SizedBox(width: 4),
        _buildContributionSquare(2),
        const SizedBox(width: 4),
        _buildContributionSquare(3),
        const SizedBox(width: 4),
        _buildContributionSquare(4),
        const SizedBox(width: 8),
        Text(
          'Plus',
          style: AppTheme.labelSmall(),
        ),
      ],
    );
  }
}
