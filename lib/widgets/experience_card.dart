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
          color: AppConstants.secondaryDark,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: experience.color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
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
            SizedBox(width: spacingLarge),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.role,
                    style: AppTheme.titleMedium(),
                  ),
                  SizedBox(height: spacingSmall),
                  Row(
                    children: [
                      Icon(Icons.business, size: 16, color: Colors.grey[500]),
                      SizedBox(width: spacingSmall),
                      Flexible(
                        child: Text(
                          experience.company,
                          style: AppTheme.subtitle(color: experience.color),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacingSmall),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey[500]),
                      SizedBox(width: spacingSmall),
                      Flexible(
                        child: Text(
                          experience.period,
                          style: AppTheme.labelSmall(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: spacingLarge),
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey[500]),
                      SizedBox(width: spacingSmall),
                      Flexible(
                        child: Text(
                          experience.location,
                          style: AppTheme.labelSmall(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: spacingLarge),
        Text(
          experience.description,
          style: AppTheme.bodyLarge(),
        ),
        SizedBox(height: spacingLarge),
        Text(
          'Réalisations clés :',
          style: AppTheme.subtitle(),
        ),
        SizedBox(height: spacingMedium),
        ...experience.achievements.map((achievement) {
          return Padding(
            padding: EdgeInsets.only(bottom: spacingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 18,
                  color: experience.color,
                ),
                SizedBox(width: spacingMedium),
                Expanded(
                  child: Text(
                    achievement,
                    style: AppTheme.bodySmall(),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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
        }).toList(),
      ],
    );
  }
}
