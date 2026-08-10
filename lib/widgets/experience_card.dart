import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/models/experience.dart';
import 'package:myportfolio/utils/app_theme.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final int index;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = isMobile ? 20.0 : 30.0;
    final iconSize = isMobile ? 24.0 : 30.0;
    const iconPadding = 12.0;
    const spacingSmall = 6.0;
    const spacingMedium = 12.0;
    const spacingLarge = 20.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(
        milliseconds: AppConstants.cardAnimationDuration +
            (index * AppConstants.cardAnimationDelay),
      ),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: isMobile ? 20 : 30),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              experience.color.withValues(alpha: 0.12),
              experience.color.withValues(alpha: 0.06),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: experience.color.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: experience.color.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isMobile
            ? _buildMobileLayout(experience, iconSize, iconPadding,
                spacingSmall, spacingMedium, spacingLarge)
            : _buildDesktopLayout(experience, iconSize, iconPadding,
                spacingSmall, spacingMedium, spacingLarge),
      ),
    );
  }

  Widget _buildDesktopLayout(
    Experience experience,
    double iconSize,
    double iconPadding,
    double spacingSmall,
    double spacingMedium,
    double spacingLarge,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Colonne de gauche : Infos entreprise
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(iconPadding),
                decoration: BoxDecoration(
                  color: experience.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  experience.icon,
                  color: experience.color,
                  size: iconSize,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                experience.role,
                style: AppTheme.titleSmall(),
              ),
              const SizedBox(height: 10),
              Text(
                experience.company,
                style: AppTheme.subtitle(color: experience.color),
              ),
              const SizedBox(height: 15),
              _buildInfoRow(Icons.calendar_today, experience.period),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.location_on, experience.location),
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Colonne de droite : Description et réalisations
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                experience.description,
                style: AppTheme.bodyLarge().copyWith(height: 1.6),
              ),
              const SizedBox(height: 25),
              Text(
                'Réalisations clés :',
                style: AppTheme.label(color: experience.color),
              ),
              const SizedBox(height: 15),
              ...experience.achievements.map((achievement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.bolt, size: 18, color: experience.color),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          achievement,
                          style: AppTheme.bodyMedium(color: Colors.grey.shade300),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTheme.labelSmall(color: Colors.grey[400]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    Experience experience,
    double iconSize,
    double iconPadding,
    double spacingSmall,
    double spacingMedium,
    double spacingLarge,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(iconPadding),
              decoration: BoxDecoration(
                color: experience.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                experience.icon,
                color: experience.color,
                size: iconSize,
              ),
            ),
            SizedBox(width: spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.role,
                    style: AppTheme.titleSmallMobile(),
                  ),
                  SizedBox(height: spacingSmall),
                  Row(
                    children: [
                      Icon(Icons.business, size: 14, color: Colors.grey[500]),
                      SizedBox(width: spacingSmall),
                      Flexible(
                        child: Text(
                          experience.company,
                          style:
                              AppTheme.subtitleMobile(color: experience.color),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: spacingMedium),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, size: 12, color: Colors.grey[500]),
                SizedBox(width: spacingSmall),
                Flexible(
                  child: Text(
                    experience.period,
                    style: AppTheme.bodyLargeMobile(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacingSmall),
            Row(
              children: [
                Icon(Icons.location_on, size: 12, color: Colors.grey[500]),
                SizedBox(width: spacingSmall),
                Flexible(
                  child: Text(
                    experience.location,
                    style: AppTheme.bodyLargeMobile(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: spacingMedium),
        Text(
          experience.description,
          style: AppTheme.bodyLargeMobile(),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: spacingMedium),
        Text(
          'Réalisations clés :',
          style: AppTheme.subtitleMobile(),
        ),
        SizedBox(height: spacingMedium),
        ...experience.achievements.map((achievement) {
          return Padding(
            padding: EdgeInsets.only(bottom: spacingSmall),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: spacingSmall / 2),
                  child: Icon(
                    Icons.check_circle,
                    size: 16,
                    color: experience.color,
                  ),
                ),
                SizedBox(width: spacingMedium),
                Expanded(
                  child: Text(
                    achievement,
                    style: AppTheme.bodyLargeMobile(),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
