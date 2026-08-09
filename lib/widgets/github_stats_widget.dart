import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:myportfolio/services/github_provider.dart';
import 'package:myportfolio/models/github_stats.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubStatsWidget extends ConsumerStatefulWidget {
  const GitHubStatsWidget({super.key});

  @override
  ConsumerState<GitHubStatsWidget> createState() => _GitHubStatsWidgetState();
}

class _GitHubStatsWidgetState extends ConsumerState<GitHubStatsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final githubStatsAsync = ref.watch(githubStatsProvider);

    return githubStatsAsync.when(
      data: (stats) => _buildStatsContent(stats, isMobile),
      loading: () => _buildLoadingState(isMobile),
      error: (error, stack) => _buildErrorState(isMobile, error.toString()),
    );
  }

  Widget _buildLoadingState(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircularProgressIndicator(
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 12),
          Text('Chargement des stats GitHub...', style: AppTheme.subtitle()),
        ],
      ),
    );
  }

  Widget _buildErrorState(bool isMobile, String error) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        'Impossible de charger les stats GitHub',
        style: AppTheme.subtitle(color: Colors.red),
      ),
    );
  }

  Widget _buildStatsContent(GitHubStats stats, bool isMobile) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut)),
      child: FadeTransition(
        opacity: _animationController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(stats, isMobile),
            const SizedBox(height: 24),

            // Section 1: Stats principales
            _buildStatsCard(
              child: _buildMainStats(stats, isMobile),
              isMobile: isMobile,
            ),
            const SizedBox(height: 20),

            // Section 2: Contributions par année
            _buildStatsCard(
              child: _buildContributionChart(stats, isMobile),
              isMobile: isMobile,
            ),
            const SizedBox(height: 20),

            // Section 3: Repos populaires
            _buildStatsCard(
              child: _buildTopRepositories(stats, isMobile),
              isMobile: isMobile,
            ),
            const SizedBox(height: 20),

            // Section 4: Langages
            _buildStatsCard(
              child: _buildLanguages(stats, isMobile),
              isMobile: isMobile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard({
    required Widget child,
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.12),
            Colors.blue.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildHeader(GitHubStats stats, bool isMobile) {
    if (isMobile) {
      // Layout mobile : affichage vertical sans bouton
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tableau de bord GitHub',
            style: AppTheme.titleSmall(),
          ),
          const SizedBox(height: 8),
          Text(
            'Mis à jour ${_formatDate(stats.lastUpdated)}',
            style: AppTheme.labelSmall(color: Colors.grey),
          ),
        ],
      );
    }

    // Layout desktop : affichage horizontal
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tableau de bord GitHub',
              style: AppTheme.titleSmall(),
            ),
            const SizedBox(height: 8),
            Text(
              'Mis à jour ${_formatDate(stats.lastUpdated)}',
              style: AppTheme.labelSmall(color: Colors.grey),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => _launchURL('https://github.com/josoavj'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.withValues(alpha: 0.15),
                  Colors.blue.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue.withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.open_in_new, size: 14, color: Colors.blue),
                SizedBox(width: 4),
                Text('Profil', style: TextStyle(color: Colors.blue, fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainStats(GitHubStats stats, bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildStatBadge('Total', '${stats.totalContributions}', Colors.blue),
          const SizedBox(width: 12),
          _buildStatBadge(
              'Cette Année', '${stats.thisYearContributions}', Colors.orange),
          const SizedBox(width: 12),
          _buildStatBadge('Stars', '${stats.totalStars}', Colors.amber),
          const SizedBox(width: 12),
          _buildStatBadge(
              'Followers', stats.followers.toString(), Colors.green),
          const SizedBox(width: 12),
          _buildStatBadge('Avg/jour',
              stats.averageContributionsPerDay.toStringAsFixed(1), Colors.cyan),
        ],
      ),
    );
  }

  Widget _buildStatBadge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTheme.titleSmall(color: color)),
          const SizedBox(height: 4),
          Text(label, style: AppTheme.labelSmall(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildContributionChart(GitHubStats stats, bool isMobile) {
    final entries = stats.contributionsByYear.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final maxValue = entries.isNotEmpty
        ? entries.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble()
        : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📅 Contributions par Année',
          style: isMobile ? AppTheme.subtitleSmall() : AppTheme.subtitle(),
        ),
        const SizedBox(height: 16),
        if (isMobile)
          _buildMobileContributionChart(entries, maxValue)
        else
          _buildDesktopContributionChart(entries, maxValue),
      ],
    );
  }

  Widget _buildMobileContributionChart(
      List<MapEntry<int, int>> entries, double maxValue) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 12,
        children: entries.map((entry) {
          final percentage = (entry.value / maxValue) * 100;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 8,
            children: [
              // Valeur en haut
              Text(
                entry.value.toString(),
                style: AppTheme.labelSmall(color: Colors.blue),
              ),
              // Barre
              Container(
                width: 40,
                height: percentage * 1.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade200,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              // Année
              Text(
                entry.key.toString(),
                style: AppTheme.labelSmall(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesktopContributionChart(
      List<MapEntry<int, int>> entries, double maxValue) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: BarChart(
        BarChartData(
          barGroups: entries.map((entry) {
            final index = entries.indexOf(entry);
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: entry.value.toDouble(),
                  color: Colors.blue.shade400,
                  width: 20,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < entries.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        entries[index].key.toString(),
                        style: AppTheme.labelSmall(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: AppTheme.labelSmall(),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: maxValue / 4,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withValues(alpha: 0.1),
                strokeWidth: 1,
              );
            },
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: false),
          maxY: maxValue,
          minY: 0,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${entries[groupIndex].key}\n${rod.toY.toInt()} contributions',
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopRepositories(GitHubStats stats, bool isMobile) {
    if (stats.topRepositories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repos Populaires',
          style: isMobile ? AppTheme.subtitleSmall() : AppTheme.subtitle(),
        ),
        const SizedBox(height: 12),
        ...stats.topRepositories
            .take(5)
            .map((repo) => _buildRepoCard(repo, isMobile)),
      ],
    );
  }

  Widget _buildRepoCard(RepoData repo, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => _launchURL(repo.url),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.withValues(alpha: 0.12),
                Colors.blue.withValues(alpha: 0.06),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.05),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      repo.name,
                      style: AppTheme.subtitleSmall(color: Colors.blue),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          repo.stars.toString(),
                          style: AppTheme.labelSmall(color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                repo.description,
                style: AppTheme.labelSmall(color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  repo.language,
                  style: AppTheme.labelSmall(color: Colors.cyan),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguages(GitHubStats stats, bool isMobile) {
    if (stats.topLanguages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💻 Langages Principaux',
          style: isMobile ? AppTheme.subtitleSmall() : AppTheme.subtitle(),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: stats.topLanguages
              .map((lang) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.cyan.withValues(alpha: 0.2),
                          Colors.blue.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.cyan.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.code,
                          size: 14,
                          color: Colors.cyan.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          lang.name,
                          style: AppTheme.subtitleSmall(),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'à l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'il y a ${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return 'il y a ${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return 'il y a ${difference.inDays}j';
    } else {
      return 'le ${date.day}/${date.month}/${date.year}';
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
