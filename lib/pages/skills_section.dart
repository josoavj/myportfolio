import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/models/skill.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/skill_bar.dart';
import 'package:myportfolio/widgets/stat_card.dart';
import 'package:myportfolio/widgets/github_stats_widget.dart' deferred as github_stats;
import 'package:myportfolio/widgets/tech_badge.dart';
import 'package:myportfolio/widgets/responsive_layout.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skillsByCategory = AppData.getSkillsByCategory();
    final badges = AppData.getTechBadges();
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
              _buildSkillGrid(context, skillsByCategory, isMobile),
              const SizedBox(height: 100),
              _buildStatsSection(context),
              const SizedBox(height: 100),
              _buildTechBadges(badges),
              const SizedBox(height: 100),
              _buildGitHubSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillGrid(BuildContext context, Map<String, List<Skill>> skillsByCategory, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = isMobile ? 1 : (constraints.maxWidth > 1000 ? 3 : 2);
        final cardWidth = (constraints.maxWidth - (50 * (columns - 1))) / columns;
        
        return Wrap(
          spacing: 50,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: skillsByCategory.entries.map((entry) {
            final index = skillsByCategory.keys.toList().indexOf(entry.key);
            return SizedBox(
              width: cardWidth,
              child: _buildSkillCategoryCard(entry.key, entry.value, index),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSkillCategoryCard(String category, List<Skill> skills, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: AppTheme.glassDecoration(
            color: Colors.blueGrey,
            opacity: 0.08,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: AppTheme.titleSmall(color: Colors.blue.shade300),
              ),
              const SizedBox(height: 30),
              ...skills.map((skill) => SkillBar(
                name: skill.name,
                level: skill.level,
                color: skill.color,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final cardWidth = isMobile 
            ? constraints.maxWidth 
            : (constraints.maxWidth - 40) / 3;

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
              icon: Icons.code_off_outlined,
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

  Widget _buildTechBadges(List<Map<String, dynamic>> badges) {
    return Column(
      children: [
        Text(
          'Technologies & Écosystème',
          style: AppTheme.titleMedium(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.center,
          children: badges.asMap().entries.map((entry) {
            final index = entry.key;
            final badge = entry.value;
            return TechBadge(
              name: badge['name'] as String,
              icon: badge['icon'] as String,
              color: badge['color'] as Color,
              index: index,
            );
          }).toList(),
        ),
      ],
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
        FutureBuilder(
          future: github_stats.loadLibrary(),
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
