import 'package:flutter/material.dart';
import 'package:myportfolio/services/github_service.dart';
import 'package:myportfolio/utils/app_theme.dart';

class GitHubStatsWidget extends StatefulWidget {
  const GitHubStatsWidget({super.key});

  @override
  State<GitHubStatsWidget> createState() => _GitHubStatsWidgetState();
}

class _GitHubStatsWidgetState extends State<GitHubStatsWidget> {
  late Future<dynamic> _statsFuture;
  late Future<Map<String, int>> _languagesFuture;
  late Future<int> _starsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = GitHubService.getGitHubStats();
    _languagesFuture = GitHubService.getTopLanguages();
    _starsFuture = GitHubService.getTotalStars();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return FutureBuilder(
      future: _statsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                const SizedBox(height: 12),
                Text('Chargement des stats GitHub...',
                    style: AppTheme.subtitle()),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Impossible de charger les stats GitHub',
              style: AppTheme.subtitle(color: Colors.red),
            ),
          );
        }

        final stats = snapshot.data;
        if (stats == null) {
          return const SizedBox.shrink();
        }

        return Container(
          padding:
              isMobile ? const EdgeInsets.all(12) : const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.withValues(alpha: 0.1),
                Colors.blue.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statistiques GitHub',
                style: isMobile ? AppTheme.subtitle() : AppTheme.titleSmall(),
              ),
              const SizedBox(height: 16),
              // Stat principale - responsive
              Container(
                padding: isMobile
                    ? const EdgeInsets.all(12)
                    : const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: isMobile
                    ? GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.9,
                        children: [
                          _StatCard(
                            label: 'Total',
                            value: stats.totalContributions.toString(),
                            icon: Icons.favorite,
                          ),
                          _StatCard(
                            label: 'Cette Année',
                            value: stats.thisYearContributions.toString(),
                            icon: Icons.calendar_today,
                          ),
                          FutureBuilder<int>(
                            future: _starsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return _StatCard(
                                  label: 'Stars',
                                  value: '0',
                                  icon: Icons.star,
                                );
                              }
                              final stars = snapshot.data ?? 0;
                              return _StatCard(
                                label: 'Stars',
                                value: stars.toString(),
                                icon: Icons.star,
                              );
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatCard(
                            label: 'Contributions Totales',
                            value: stats.totalContributions.toString(),
                            icon: Icons.favorite,
                          ),
                          _StatCard(
                            label: 'Cette Année',
                            value: stats.thisYearContributions.toString(),
                            icon: Icons.calendar_today,
                          ),
                          _StatCard(
                            label: 'Plus Long Streak',
                            value: '${stats.longestStreak}j',
                            icon: Icons.local_fire_department,
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 16),
              // Contributions par année
              Text(
                'Contributions par Année',
                style:
                    isMobile ? AppTheme.subtitleSmall() : AppTheme.subtitle(),
              ),
              const SizedBox(height: 12),
              ...stats.contributionsByYear.entries
                  .toList()
                  .reversed
                  .map((entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${entry.key}',
                                  style: isMobile
                                      ? AppTheme.labelSmall()
                                      : AppTheme.subtitleSmall(),
                                ),
                                Text(
                                  '${entry.value}',
                                  style: isMobile
                                      ? AppTheme.labelSmall(color: Colors.blue)
                                      : AppTheme.subtitleSmall(
                                          color: Colors.blue),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: entry.value / 3580,
                                minHeight: isMobile ? 4 : 6,
                                backgroundColor: Colors.grey[800],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              const SizedBox(height: 20),
              // Langages les plus utilisés
              Text(
                'Langages Principaux',
                style:
                    isMobile ? AppTheme.subtitleSmall() : AppTheme.subtitle(),
              ),
              const SizedBox(height: 12),
              FutureBuilder<Map<String, int>>(
                future: _languagesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 30,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text(
                      'Chargement des langages...',
                      style: AppTheme.subtitleSmall(),
                    );
                  }

                  final languages = snapshot.data!;
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: languages.entries
                        .map((entry) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.blue.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.code,
                                      size: 14,
                                      color:
                                          Colors.blue.withValues(alpha: 0.7)),
                                  const SizedBox(width: 6),
                                  Text(
                                    entry.key,
                                    style: isMobile
                                        ? AppTheme.labelSmall()
                                        : AppTheme.subtitleSmall(),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: isMobile ? 20 : 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: isMobile
              ? AppTheme.subtitleSmall(color: Colors.blue)
              : AppTheme.titleSmall(color: Colors.blue),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.subtitleSmall(color: Colors.grey),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
