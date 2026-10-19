import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/models/timeline_entry.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/project_navigation.dart';

/// Arbre du parcours : un tronc vertical avec des nœuds et des branches.
/// Large écran : cartes en alternance gauche / droite, date du côté opposé.
/// Écran étroit : tronc à gauche, cartes à droite.
class TimelineTree extends StatelessWidget {
  final List<TimelineEntry> entries;
  final Color color;

  static const double wideBreakpoint = 900;

  const TimelineTree({
    super.key,
    required this.entries,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= wideBreakpoint;
        final projects = AppData.getProjects();

        return Column(
          children: [
            for (var i = 0; i < entries.length; i++)
              _TimelineRow(
                entry: entries[i],
                index: i,
                isFirst: i == 0,
                isLast: i == entries.length - 1,
                wide: wide,
                color: color,
                projects: projects,
              ),
          ],
        );
      },
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final TimelineEntry entry;
  final int index;
  final bool isFirst;
  final bool isLast;
  final bool wide;
  final Color color;
  final List<Project> projects;

  /// Position verticale du nœud, alignée sur le haut de la carte.
  static const double _nodeY = 34;

  const _TimelineRow({
    required this.entry,
    required this.index,
    required this.isFirst,
    required this.isLast,
    required this.wide,
    required this.color,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final bottomGap = isLast ? 0.0 : 32.0;
    final card = Padding(
      padding: EdgeInsets.only(bottom: bottomGap),
      child: _TimelineCard(
        entry: entry,
        color: color,
        projects: projects,
        showPeriod: !wide,
        initiallyExpanded: index == 0,
      ),
    );

    if (!wide) {
      return Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: 44,
            child: _buildTrunk(width: 44, branch: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: card,
          ),
        ],
      );
    }

    final cardOnLeft = index.isEven;
    final cardSide = Align(
      alignment: cardOnLeft ? Alignment.topRight : Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: card,
      ),
    );
    final dateSide = Align(
      alignment: cardOnLeft ? Alignment.topLeft : Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: _nodeY - 14, left: 12, right: 12),
        child: _DateLabel(entry: entry, alignEnd: !cardOnLeft),
      ),
    );

    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: _buildTrunk(width: 72, branch: cardOnLeft ? -1 : 1),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: cardOnLeft ? cardSide : dateSide),
            const SizedBox(width: 72),
            Expanded(child: cardOnLeft ? dateSide : cardSide),
          ],
        ),
      ],
    );
  }

  Widget _buildTrunk({required double width, required int branch}) {
    return SizedBox(
      width: width,
      height: double.infinity,
      child: CustomPaint(
        painter: _TrunkPainter(
          color: color,
          isFirst: isFirst,
          isLast: isLast,
          ongoing: entry.isOngoing,
          nodeY: _nodeY,
          branch: branch,
        ),
      ),
    );
  }
}

class _TrunkPainter extends CustomPainter {
  final Color color;
  final bool isFirst;
  final bool isLast;
  final bool ongoing;
  final double nodeY;

  /// -1 : branche vers la gauche, 1 : branche vers la droite.
  final int branch;

  const _TrunkPainter({
    required this.color,
    required this.isFirst,
    required this.isLast,
    required this.ongoing,
    required this.nodeY,
    required this.branch,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final line = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Tronc : continu d'une ligne à l'autre, il commence au premier nœud
    // et s'arrête au dernier.
    final top = isFirst ? nodeY : 0.0;
    final bottom = isLast ? nodeY : size.height;
    if (bottom > top) {
      canvas.drawLine(Offset(cx, top), Offset(cx, bottom), line);
    }

    // Branche horizontale entre le nœud et la carte.
    final branchEnd = branch < 0 ? 0.0 : size.width;
    canvas.drawLine(Offset(cx + branch * 9, nodeY), Offset(branchEnd, nodeY), line);

    // Nœud.
    final center = Offset(cx, nodeY);
    if (ongoing) {
      canvas.drawCircle(center, 17, Paint()..color = color.withValues(alpha: 0.18));
    }
    canvas.drawCircle(center, 10, Paint()..color = AppConstants.primaryDark);
    canvas.drawCircle(
      center,
      10,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    canvas.drawCircle(center, 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TrunkPainter old) =>
      old.color != color ||
      old.isFirst != isFirst ||
      old.isLast != isLast ||
      old.ongoing != ongoing ||
      old.nodeY != nodeY ||
      old.branch != branch;
}

class _DateLabel extends StatelessWidget {
  final TimelineEntry entry;
  final bool alignEnd;

  const _DateLabel({required this.entry, required this.alignEnd});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          entry.period,
          style: AppTheme.lexendRegular(
            16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (entry.duration != null) ...[
          const SizedBox(height: 4),
          Text(entry.duration!, style: AppTheme.caption()),
        ],
      ],
    );
  }
}

class _TimelineCard extends StatefulWidget {
  final TimelineEntry entry;
  final Color color;
  final List<Project> projects;
  final bool showPeriod;
  final bool initiallyExpanded;

  const _TimelineCard({
    required this.entry,
    required this.color,
    required this.projects,
    required this.showPeriod,
    required this.initiallyExpanded,
  });

  @override
  State<_TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<_TimelineCard> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final color = widget.color;
    final isOngoingStatus = entry.status == 'En cours' || entry.status == 'Continue';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration(
        color: color,
        opacity: 0.08,
        showShadow: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Chip(label: entry.badge, color: color, icon: entry.icon),
              if (entry.status != null)
                _Chip(
                  label: entry.status!,
                  color: isOngoingStatus ? Colors.amber : Colors.green,
                ),
              if (widget.showPeriod && entry.duration != null)
                _Chip(label: entry.duration!, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            entry.title,
            style: AppTheme.lexendRegular(
              18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${entry.organization} · ${entry.location}',
            style: AppTheme.lexendRegular(13, color: color, height: 1.4),
          ),
          if (widget.showPeriod) ...[
            const SizedBox(height: 4),
            Text(entry.period, style: AppTheme.caption()),
          ],
          const SizedBox(height: 12),
          Text(
            entry.summary,
            style: AppTheme.lexendRegular(
              13,
              color: Colors.grey.shade300,
              height: 1.6,
            ),
          ),
          if (entry.hasDetails) ...[
            const SizedBox(height: 14),
            _buildToggle(),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: _expanded
                  ? _buildDetails()
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Semantics(
      button: true,
      expanded: _expanded,
      label: _expanded ? 'Masquer les détails' : 'Voir les détails',
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _expanded ? 'Masquer les détails' : 'Voir les détails',
                style: AppTheme.lexendRegular(
                  13,
                  color: Colors.blue.shade300,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 250),
                child: Icon(Icons.expand_more, size: 20, color: Colors.blue.shade300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    final entry = widget.entry;
    final color = widget.color;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entry.thesisTitle != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MÉMOIRE', style: AppTheme.labelSmall(color: color)),
                  const SizedBox(height: 6),
                  Text(
                    entry.thesisTitle!,
                    style: AppTheme.lexendRegular(
                      12,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],
          for (final item in entry.highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(Icons.check_circle_outline, size: 16, color: color),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTheme.lexendRegular(
                        13,
                        color: Colors.grey.shade300,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (entry.technologies.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tech in entry.technologies)
                  _Chip(label: tech, color: Colors.blueGrey),
              ],
            ),
          ],
          if (entry.relatedProjects.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('PROJETS LIÉS', style: AppTheme.labelSmall(color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final name in entry.relatedProjects) _buildProjectChip(name),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectChip(String name) {
    Project? project;
    for (final p in widget.projects) {
      if (p.name.toLowerCase() == name.toLowerCase()) {
        project = p;
        break;
      }
    }

    if (project == null) {
      return _Chip(label: name, color: Colors.blue);
    }

    final found = project;
    return Semantics(
      button: true,
      label: 'Ouvrir le projet ${found.name}',
      child: InkWell(
        onTap: () => openProject(context, found),
        borderRadius: BorderRadius.circular(20),
        child: _Chip(
          label: found.name,
          color: Colors.blue,
          trailing: Icons.arrow_outward,
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final IconData? trailing;

  const _Chip({
    required this.label,
    required this.color,
    this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTheme.lexendRegular(
                11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 4),
            Icon(trailing, size: 12, color: color),
          ],
        ],
      ),
    );
  }
}
