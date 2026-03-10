import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/models/skill.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/skill_bar.dart';
import 'package:myportfolio/widgets/stat_card.dart';
import 'package:myportfolio/widgets/github_stats_widget.dart';
import 'package:myportfolio/widgets/tech_badge.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  @override
  void initState() {
    super.initState();
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
              title: 'Stack Technique & Compétences', emoji: null),
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
        final isLargeScreen = constraints.maxWidth > 1000;

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
              width:
                  isMobile ? constraints.maxWidth : (isLargeScreen ? 220 : 200),
            ).withScaleIn(delay: const Duration(milliseconds: 300)),
            StatCard(
              icon: Icons.terminal,
              title: '3+',
              subtitle: 'Années d\'Expérience',
              color: Colors.green,
              width:
                  isMobile ? constraints.maxWidth : (isLargeScreen ? 220 : 200),
            ).withScaleIn(delay: const Duration(milliseconds: 400)),
            StatCard(
              icon: Icons.people,
              title: 'APEXNova\nLabs',
              subtitle: 'Membre Actif',
              color: Colors.purple,
              width:
                  isMobile ? constraints.maxWidth : (isLargeScreen ? 220 : 200),
            ).withScaleIn(delay: const Duration(milliseconds: 500)),
          ],
        );
      },
    );
  }

  Widget _buildTechBadges(List<Map<String, dynamic>> badges) {
    return Column(
      children: [
        const Text(
          'Technologies & Outils',
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
          '📊 Statistiques GitHub',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Mon activité et contributions sur GitHub',
          style: AppTheme.subtitleSmall(),
        ),
        const SizedBox(height: 30),
        const GitHubStatsWidget(),
      ],
    );
  }
}
