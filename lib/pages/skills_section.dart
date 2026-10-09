import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/models/skill.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/stat_card.dart';
import 'package:myportfolio/widgets/github_stats_widget.dart' deferred as github_stats;
import 'package:myportfolio/widgets/tech_badge.dart';
import 'package:myportfolio/widgets/responsive_layout.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  late final Map<String, List<Skill>> _skillsByCategory;
  // Créé une seule fois : évite de relancer loadLibrary() à chaque rebuild.
  late final Future<void> _githubStatsLoader;

  @override
  void initState() {
    super.initState();
    _skillsByCategory = AppData.getSkillsByCategory();
    _githubStatsLoader = github_stats.loadLibrary();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 100,
      ),
      color: AppConstants.secondaryDark,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(title: 'Expertise Technique'),
              const SizedBox(height: 80),
              _buildSkillGrid(isMobile),
              const SizedBox(height: 100),
              _buildStatsSection(),
              const SizedBox(height: 100),
              _buildGitHubSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillGrid(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = isMobile ? 1 : (constraints.maxWidth > 1000 ? 3 : 2);
        final cardWidth = (constraints.maxWidth - (50 * (columns - 1))) / columns;

        return Wrap(
          spacing: 50,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: _skillsByCategory.entries.map((entry) {
            return SizedBox(
              width: cardWidth,
              child: _buildSkillCategoryCard(entry.key, entry.value),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSkillCategoryCard(String category, List<Skill> skills) {
    // Pas de BackdropFilter : coûteux sur le Web, et le fond est uni de toute façon.
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: AppTheme.glassDecoration(
          color: Colors.blueGrey,
          opacity: 0.08,
          showShadow: false,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: AppTheme.titleSmall(color: Colors.blue.shade300),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: skills
                  .map((skill) => TechBadge(name: skill.name, color: skill.color))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final cardWidth =
            isMobile ? constraints.maxWidth : (constraints.maxWidth - 40) / 3;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            StatCard(
              icon: Icons.rocket_launch_outlined,
              title: '5+',
              subtitle: 'Projets Majeurs',
              color: Colors.blue,
              width: cardWidth,
            ),
            StatCard(
              icon: Icons.code,
              title: '3+',
              subtitle: 'Années de Code',
              color: Colors.green,
              width: cardWidth,
            ),
            StatCard(
              icon: Icons.hub_outlined,
              title: 'APEXNova Labs',
              subtitle: 'Membre Core',
              color: Colors.purple,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildGitHubSection() {
    return Column(
      children: [
        Text(
          'Activité Open Source',
          style: AppTheme.titleMedium(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        Text(
          'Suivi en temps réel de mes contributions GitHub',
          style: AppTheme.subtitleSmall(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        FutureBuilder<void>(
          future: _githubStatsLoader,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return github_stats.GitHubStatsWidget();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
