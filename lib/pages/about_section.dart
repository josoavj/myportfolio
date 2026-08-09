import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/services/github_provider.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';
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
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            const SectionTitle(title: 'Qui suis-je ?'),
            const SizedBox(height: 60),
            ResponsiveLayout(
              mobile: Column(
                children: [
                  _buildProfileText(isMobile),
                  const SizedBox(height: 40),
                  _buildAchievementCard(isMobile, githubStatsAsync),
                ],
              ),
              desktop: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildProfileText(isMobile)),
                  const SizedBox(width: 60),
                  Expanded(
                    flex: 2,
                    child: _buildAchievementCard(isMobile, githubStatsAsync),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileText(bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Développeur Full Stack & Passionné de Sécurité',
          style: AppTheme.titleSmall(color: Colors.blue.shade300),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).withFadeIn(delay: const Duration(milliseconds: 200)),
        const SizedBox(height: 25),
        Text(
          'Je suis Josoa Vonjiniaina, un développeur basé à Madagascar avec une soif insatiable d\'apprendre et de créer. '
          'Spécialisé dans l\'écosystème Flutter et les architectures backend robustes, je m\'efforce de construire des applications '
          'qui allient design élégant et performances techniques.',
          style: AppTheme.bodyLarge(),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).withFadeIn(delay: const Duration(milliseconds: 400)),
        const SizedBox(height: 20),
        Text(
          'Actuellement en Master Informatique, je concentre mes recherches sur la cybersécurité et l\'optimisation logicielle. '
          'Mon engagement au sein d\'APEXNova Labs me permet de repousser les limites du développement collaboratif et open source.',
          style: AppTheme.bodyLarge(),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).withFadeIn(delay: const Duration(milliseconds: 600)),
      ],
    );
  }

  Widget _buildAchievementCard(bool isMobile, AsyncValue githubStatsAsync) {
    return githubStatsAsync.when(
      data: (stats) {
        // Le rang est extrait du site committers.top (Rang 9 pour Josoa Vonjiniaina)
        const int rank = 9;
        final totalCommits = stats.totalContributions;
        final publicRepos = stats.publicRepos;

        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: AppTheme.glassDecoration(
                color: Colors.amber,
                opacity: 0.1,
              ),
              child: Column(
                children: [
                  const Icon(Icons.workspace_premium,
                      color: Colors.amber, size: 50),
                  const SizedBox(height: 20),
                  Text(
                    'Top $rank GitHub Madagascar',
                    style: AppTheme.titleSmall(color: Colors.amber),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Classé au 9ème rang des développeurs les plus actifs de Madagascar (Total contributions).',
                    style: AppTheme.bodySmall(color: Colors.amber.shade100),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  _buildMetric('$publicRepos', 'Repositories Publics'),
                  const Divider(color: Colors.amber, thickness: 0.2),
                  _buildMetric('$totalCommits', 'Total Contributions'),
                ],
              ),
            ),
          ),
        ).withScaleIn(delay: const Duration(milliseconds: 800));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => _buildErrorCard(isMobile),
    );
  }

  Widget _buildErrorCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration(color: Colors.red, opacity: 0.1),
      child: const Text('Erreur lors du chargement des stats GitHub'),
    );
  }

  Widget _buildMetric(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.labelSmall()),
          Text(value, style: AppTheme.label(color: Colors.amber)),
        ],
      ),
    );
  }
}
