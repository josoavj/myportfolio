import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/services/github_provider.dart';
import 'package:myportfolio/services/url_launcher_service.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/category_style.dart';
import 'package:myportfolio/utils/language_colors.dart';
import 'package:myportfolio/utils/project_navigation.dart';

/// Fiche projet en étude de cas. Chaque section n'apparaît que si le projet
/// contient la donnée correspondante (voir `Project`).
class ProjectDetailPage extends ConsumerWidget {
  final Project project;

  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSmall = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          tooltip: 'Retour',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 16 : 30,
                vertical: 20,
              ),
              child: _buildContent(context, isSmall),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isSmall) {
    final p = project;
    final hasCaseStudy = p.problem.isNotEmpty || p.solution.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHero(isSmall),
        const SizedBox(height: 28),
        _buildFacts(),
        const SizedBox(height: 28),
        _LanguageBreakdown(
          repoName: p.repoName,
          primaryLanguage: p.language,
        ),
        if (p.screenshots.isNotEmpty) ...[
          const SizedBox(height: 40),
          _ScreenshotStrip(paths: p.screenshots, isSmall: isSmall),
        ],
        if (p.problem.isNotEmpty)
          _Section(
            title: 'Contexte et objectif',
            isSmall: isSmall,
            child: _Paragraph(p.problem),
          ),
        if (p.solution.isNotEmpty)
          _Section(
            title: 'Solution',
            isSmall: isSmall,
            child: _Paragraph(p.solution),
          ),
        if (p.architecture.isNotEmpty || p.architectureItems.isNotEmpty)
          _Section(
            title: 'Architecture',
            isSmall: isSmall,
            child: _ArchitectureList(
              intro: p.architecture,
              items: p.architectureItems,
            ),
          ),
        if (!hasCaseStudy && p.detailedDescription.isNotEmpty)
          _Section(
            title: 'À propos',
            isSmall: isSmall,
            child: _Paragraph(p.detailedDescription),
          ),
        if (p.features.isNotEmpty)
          _Section(
            title: 'Fonctionnalités',
            isSmall: isSmall,
            child: _buildFeatures(),
          ),
        if (p.challenges.isNotEmpty)
          _Section(
            title: 'Défis techniques',
            isSmall: isSmall,
            child: Column(
              children: [
                for (final c in p.challenges) _ChallengeCard(challenge: c),
              ],
            ),
          ),
        if (p.results.isNotEmpty)
          _Section(
            title: 'Chiffres clés',
            isSmall: isSmall,
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (final m in p.results) _MetricCard(metric: m),
              ],
            ),
          ),
        if (p.roadmap.isNotEmpty)
          _Section(
            title: 'À venir',
            isSmall: isSmall,
            child: _BulletList(items: p.roadmap, icon: Icons.schedule),
          ),
        if (p.learnings.isNotEmpty)
          _Section(
            title: 'Ce que j\'ai appris',
            isSmall: isSmall,
            child: _BulletList(items: p.learnings, icon: Icons.lightbulb_outline),
          ),
        if (p.stackByLayer.isNotEmpty || p.technologies.isNotEmpty)
          _Section(
            title: 'Stack technique',
            isSmall: isSmall,
            child: _buildStack(),
          ),
        if (p.relatedProjects.isNotEmpty)
          _buildRelated(context, isSmall),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildHero(bool isSmall) {
    final p = project;
    final catColor = categoryColor(p.category);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _Pill(label: p.category, color: catColor, faIcon: categoryIcon(p.category)),
            if (p.status.isNotEmpty) _Pill(label: p.status, color: Colors.amber),
            if (p.stars > 0)
              _Pill(
                label: '${p.stars} ${p.stars > 1 ? 'stars' : 'star'}',
                color: Colors.amber,
                icon: Icons.star_rounded,
              ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          p.name,
          style: isSmall ? AppTheme.titleLargeMobile() : AppTheme.titleLarge(),
        ),
        const SizedBox(height: 12),
        Text(
          p.tagline.isNotEmpty ? p.tagline : p.description,
          style: AppTheme.lexendRegular(
            isSmall ? 15 : 18,
            color: Colors.grey.shade300,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ActionButton(
              label: 'Code source',
              icon: Icons.code,
              url: p.url,
              primary: true,
            ),
            if (p.demoUrl != null)
              _ActionButton(label: 'Démo', icon: Icons.play_arrow_rounded, url: p.demoUrl!),
            if (p.releaseUrl != null)
              _ActionButton(label: 'Release', icon: Icons.download_rounded, url: p.releaseUrl!),
            if (p.docsUrl != null)
              _ActionButton(label: 'Documentation', icon: Icons.menu_book_outlined, url: p.docsUrl!),
          ],
        ),
      ],
    );
  }

  Widget _buildFacts() {
    final p = project;
    final facts = <MapEntry<String, String>>[
      if (p.role.isNotEmpty) MapEntry('Rôle', p.role),
      if (p.period.isNotEmpty) MapEntry('Période', p.period),
      if (p.origin.isNotEmpty) MapEntry('Contexte', p.origin),
    ];
    if (facts.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        for (final f in facts) _FactCard(label: f.key, value: f.value),
      ],
    );
  }

  Widget _buildFeatures() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 700 ? 2 : 1;
        final itemWidth = (constraints.maxWidth - 16 * (columns - 1)) / columns;
        return Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            for (final f in project.features)
              SizedBox(
                width: itemWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(Icons.check_circle_outline, size: 18, color: Colors.blue.shade300),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        f,
                        style: AppTheme.lexendRegular(
                          14,
                          color: Colors.grey.shade300,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildStack() {
    final p = project;
    if (p.stackByLayer.isEmpty) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (final t in p.technologies) _Pill(label: t, color: Colors.blueGrey),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in p.stackByLayer.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key.toUpperCase(),
                  style: AppTheme.labelSmall(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final t in entry.value) _Pill(label: t, color: Colors.blue),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRelated(BuildContext context, bool isSmall) {
    final all = AppData.getProjects();
    final related = <Project>[];
    for (final name in project.relatedProjects) {
      for (final candidate in all) {
        if (candidate.name.toLowerCase() == name.toLowerCase()) {
          related.add(candidate);
          break;
        }
      }
    }
    if (related.isEmpty) return const SizedBox.shrink();

    return _Section(
      title: 'Projets liés',
      isSmall: isSmall,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final r in related)
            Semantics(
              button: true,
              label: 'Ouvrir le projet ${r.name}',
              child: InkWell(
                onTap: () => openProject(context, r),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: AppTheme.glassDecoration(
                    color: Colors.blueGrey,
                    opacity: 0.1,
                    borderRadius: 14,
                    showShadow: false,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(categoryIcon(r.category), size: 16, color: categoryColor(r.category)),
                      const SizedBox(width: 10),
                      Text(
                        r.name,
                        style: AppTheme.lexendRegular(
                          14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_outward, size: 14, color: Colors.blue.shade300),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final bool isSmall;
  final Widget child;

  const _Section({
    required this.title,
    required this.isSmall,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: isSmall ? AppTheme.titleMediumMobile() : AppTheme.titleMedium(),
          ),
          const SizedBox(height: 8),
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blue, Colors.cyan]),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  final String text;

  const _Paragraph(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTheme.lexendRegular(15, color: Colors.grey.shade300, height: 1.7),
    );
  }
}

/// Architecture sous forme de liste structurée : un repère numéroté, un
/// libellé et une description par ligne, séparés par un filet fin
/// (pas de cadre ni de fond).
class _ArchitectureList extends StatelessWidget {
  final String intro;
  final List<ArchitectureItem> items;

  const _ArchitectureList({required this.intro, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 640;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (intro.isNotEmpty) ...[
              _Paragraph(intro),
              const SizedBox(height: 20),
            ],
            for (var i = 0; i < items.length; i++)
              _ArchitectureRow(
                index: i + 1,
                item: items[i],
                wide: wide,
              ),
            if (items.isNotEmpty) const Divider(height: 1, color: Colors.white12),
          ],
        );
      },
    );
  }
}

class _ArchitectureRow extends StatelessWidget {
  final int index;
  final ArchitectureItem item;
  final bool wide;

  const _ArchitectureRow({
    required this.index,
    required this.item,
    required this.wide,
  });

  @override
  Widget build(BuildContext context) {
    final number = Text(
      index.toString().padLeft(2, '0'),
      style: AppTheme.lexendRegular(12, color: Colors.blue.shade300, fontWeight: FontWeight.w600),
    );
    final label = Text(
      item.label,
      style: AppTheme.lexendRegular(15, color: Colors.white, fontWeight: FontWeight.bold, height: 1.4),
    );
    final detail = Text(
      item.detail,
      style: AppTheme.lexendRegular(14, color: Colors.grey.shade300, height: 1.6),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, color: Colors.white12),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 40, child: Padding(padding: const EdgeInsets.only(top: 3), child: number)),
                    SizedBox(width: 220, child: label),
                    Expanded(child: detail),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        number,
                        const SizedBox(width: 12),
                        Expanded(child: label),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: detail,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

/// Répartition des langages du dépôt (barre segmentée + légende chiffrée).
/// Les données viennent de l'API GitHub ; sans réponse, le langage principal
/// est affiché seul.
class _LanguageBreakdown extends ConsumerWidget {
  final String repoName;
  final String primaryLanguage;

  const _LanguageBreakdown({
    required this.repoName,
    required this.primaryLanguage,
  });

  static const int _maxVisible = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetched = ref.watch(repoLanguagesProvider(repoName)).asData?.value ??
        const <String, int>{};

    var entries = fetched.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    if (entries.isEmpty) {
      entries = [MapEntry(primaryLanguage, 1)];
    }

    final total = entries.fold<int>(0, (sum, e) => sum + e.value);
    final visible = entries.take(_maxVisible).toList();
    final othersSum =
        entries.skip(_maxVisible).fold<int>(0, (sum, e) => sum + e.value);
    if (othersSum > 0) visible.add(MapEntry('Autres', othersSum));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LANGAGES', style: AppTheme.labelSmall(color: Colors.grey)),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 10,
            child: Row(
              children: [
                for (final e in visible)
                  Expanded(
                    flex: (e.value * 1000 / total).round().clamp(1, 1000),
                    child: ColoredBox(color: languageBarColor(e.key)),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 22,
          runSpacing: 10,
          children: [
            for (final e in visible) _legendItem(e.key, e.value * 100 / total),
          ],
        ),
      ],
    );
  }

  Widget _legendItem(String name, double percent) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: languageBarColor(name),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: AppTheme.lexendRegular(13, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 6),
        Text(
          _formatPercent(percent),
          style: AppTheme.lexendRegular(13, color: Colors.grey.shade400),
        ),
      ],
    );
  }

  String _formatPercent(double p) {
    if (p >= 99.95) return '100\u202F%';
    if (p < 0.1) return '< 0,1\u202F%';
    return '${p.toStringAsFixed(1).replaceAll('.', ',')}\u202F%';
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  final IconData icon;

  const _BulletList({required this.items, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(icon, size: 18, color: Colors.blue.shade300),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item,
                    style: AppTheme.lexendRegular(14, color: Colors.grey.shade300, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final ProjectChallenge challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration(
        color: Colors.blueGrey,
        opacity: 0.08,
        showShadow: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.bolt, size: 20, color: Colors.amber),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  challenge.challenge,
                  style: AppTheme.lexendRegular(
                    15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              challenge.solution,
              style: AppTheme.lexendRegular(14, color: Colors.grey.shade300, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final ProjectMetric metric;

  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: AppTheme.glassDecoration(
        color: Colors.blue,
        opacity: 0.08,
        showShadow: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            metric.value,
            style: AppTheme.lexendRegular(
              24,
              color: Colors.blue.shade200,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(metric.label, style: AppTheme.caption()),
        ],
      ),
    );
  }
}

class _FactCard extends StatelessWidget {
  final String label;
  final String value;

  const _FactCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150, maxWidth: 320),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: AppTheme.glassDecoration(
        color: Colors.blueGrey,
        opacity: 0.08,
        showShadow: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.toUpperCase(), style: AppTheme.labelSmall(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTheme.lexendRegular(
              14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final FaIconData? faIcon;

  const _Pill({required this.label, required this.color, this.icon, this.faIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (faIcon != null) ...[
            FaIcon(faIcon, size: 14, color: color),
            const SizedBox(width: 6),
          ] else if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTheme.lexendRegular(12, color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool primary;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.url,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = primary ? Colors.blue : Colors.blueGrey;

    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: () => UrlLauncherService.launchURL(url),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: color.withValues(alpha: primary ? 0.25 : 0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTheme.lexendRegular(
                  14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreenshotStrip extends StatelessWidget {
  final List<String> paths;
  final bool isSmall;

  const _ScreenshotStrip({required this.paths, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 220 : 340,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: paths.length,
          separatorBuilder: (context, index) => const SizedBox(width: 14),
          itemBuilder: (indexContext, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                paths[index],
                fit: BoxFit.cover,
                cacheHeight: 700,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            );
          },
        ),
      ),
    );
  }
}
