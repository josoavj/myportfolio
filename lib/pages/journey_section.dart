import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_data.dart';
import 'package:myportfolio/models/timeline_entry.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/widgets/section_title.dart';
import 'package:myportfolio/widgets/timeline_tree.dart';

/// Parcours : deux arbres séparés, professionnel et académique.
class JourneySection extends StatefulWidget {
  const JourneySection({super.key});

  @override
  State<JourneySection> createState() => _JourneySectionState();
}

class _JourneySectionState extends State<JourneySection> {
  static const Color _professionalColor = Color(0xFF25D366);
  static const Color _academicColor = Colors.blue;

  bool _professional = true;
  late final List<TimelineEntry> _professionalEntries;
  late final List<TimelineEntry> _academicEntries;

  @override
  void initState() {
    super.initState();
    _professionalEntries = AppData.getProfessionalTimeline();
    _academicEntries = AppData.getAcademicTimeline();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 60 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(title: 'Parcours'),
              SizedBox(height: isMobile ? 28 : 36),
              _buildSwitcher(),
              SizedBox(height: isMobile ? 32 : 48),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: TimelineTree(
                  key: ValueKey(_professional),
                  entries:
                      _professional ? _professionalEntries : _academicEntries,
                  color: _professional ? _professionalColor : _academicColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitcher() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTab(
              label: 'Professionnel',
              icon: Icons.work_outline,
              selected: _professional,
              color: _professionalColor,
              onTap: () => setState(() => _professional = true),
            ),
            _buildTab(
              label: 'Académique',
              icon: Icons.school_outlined,
              selected: !_professional,
              color: _academicColor,
              onTap: () => setState(() => _professional = false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required IconData icon,
    required bool selected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          decoration: BoxDecoration(
            color: selected ? color.withValues(alpha: 0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: selected ? color.withValues(alpha: 0.6) : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: selected ? color : Colors.white70),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTheme.lexendRegular(
                  14,
                  color: selected ? color : Colors.white70,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
