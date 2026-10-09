import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/services/github_provider.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/responsive_layout.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final githubStatsAsync = ref.watch(githubStatsProvider);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(title: 'Qui suis-je ?'),
              const SizedBox(height: 60),
              // Texte de présentation en largeur
              _buildProfileText(isMobile),
              const SizedBox(height: 60),
              // Dashboard de métriques horizontal
              _buildAchievementDashboard(isMobile, githubStatsAsync),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileText(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 40),
      child: Column(
        children: [
          Text(
            'Développeur Full Stack & Passionné de Sécurité',
            style: AppTheme.titleSmall(color: Colors.blue.shade300),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            'Je suis Josoa Vonjiniaina, développeur basé à Madagascar. J\'avance avec la volonté constante d\'apprendre et d\'innover. '
            'Spécialisé dans l\'écosystème Flutter (apps mobiles & logiciels desktop) et les architectures backend, je crée et façonne des solutions logicielles complètes. '
            '\n \n Ma priorité quand je développe ? Concevoir des interfaces soignées et intuitives, fluide et réactive avec une sécurité pensée dès la première ligne de code. '
            'Mon objectif n\'est pas juste de livrer un produit qui marche aujourd\'hui, mais de bâtir une architecture propre et évolutive, capable d\'absorber la croissance de demain sans perdre en qualité. '
            '\n \n Sur le point d\'achever mon Master II en Informatique & Télécommunications, je mets ce savoir-faire au service de projets ambitieux qu\'il s\'agisse de concevoir de nouvelles solutions de zéro ou d\'optimiser l\'existant pour offrir la meilleure expérience possible aux utilisateurs. '
            'Mon engagement chez APEXNova Labs incarne cette vision à travers le développement collaboratif et l\'open source.',
            style: AppTheme.bodyLarge().copyWith(height: 1.8, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementDashboard(bool isMobile, AsyncValue githubStatsAsync) {
    return githubStatsAsync.when(
      data: (stats) {
        const int rank = 9;
        final totalCommits = stats.totalContributions;
        final publicRepos = stats.publicRepos;

        return LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = isMobile 
                ? constraints.maxWidth 
                : (constraints.maxWidth - 40) / 3;

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildMetricCard(
                  icon: Icons.workspace_premium_rounded,
                  value: 'Top $rank',
                  label: 'GitHub Madagascar',
                  description: 'Parmi les plus actifs (Total contributions)',
                  color: Colors.amber,
                  width: cardWidth,
                ),
                _buildMetricCard(
                  icon: Icons.folder_special_rounded,
                  value: '$publicRepos',
                  label: 'Projets Publics',
                  description: 'Repositories sur GitHub',
                  color: Colors.blue,
                  width: cardWidth,
                ),
                _buildMetricCard(
                  icon: Icons.stacked_line_chart_rounded,
                  value: '$totalCommits',
                  label: 'Total Contributions',
                  description: 'Commits, PRs & Issues',
                  color: const Color(0xFF25D366),
                  width: cardWidth,
                ),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Erreur stats GitHub'),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String value,
    required String label,
    required String description,
    required Color color,
    required double width,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(25),
          decoration: AppTheme.glassDecoration(
            color: color,
            opacity: 0.1,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 15),
              Text(
                value,
                style: AppTheme.titleSmall(color: color),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: AppTheme.label(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: AppTheme.caption(color: Colors.grey.shade400),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
