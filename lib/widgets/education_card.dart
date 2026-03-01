import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/models/education.dart';
import 'package:myportfolio/utils/app_theme.dart';

class EducationCard extends StatelessWidget {
  final Education education;
  final int index;

  const EducationCard({
    super.key,
    required this.education,
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
          border: Border.all(color: education.color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: isMobile
            ? _buildMobileLayout(education, iconSize, iconPadding, spacingSmall,
                spacingMedium, spacingLarge)
            : _buildDesktopLayout(education, iconSize, iconPadding,
                spacingSmall, spacingMedium, spacingLarge),
      ),
    );
  }

  Widget _buildDesktopLayout(
    Education education,
    double iconSize,
    double iconPadding,
    double spacingSmall,
    double spacingMedium,
    double spacingLarge,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(iconPadding),
          decoration: BoxDecoration(
            color: education.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            education.icon,
            color: education.color,
            size: iconSize,
          ),
        ),
        SizedBox(width: spacingLarge),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      education.degree,
                      style: AppTheme.titleMedium(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: spacingMedium, vertical: spacingSmall),
                    decoration: BoxDecoration(
                      color: education.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: education.color,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      education.status,
                      style: AppTheme.labelSmall(color: education.color),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacingSmall),
              Text(
                education.school,
                style: AppTheme.subtitle(color: education.color),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: spacingSmall),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                  SizedBox(width: spacingSmall),
                  Flexible(
                    child: Text(
                      education.period,
                      style: AppTheme.labelSmall(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: spacingLarge),
                  Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                  SizedBox(width: spacingSmall),
                  Flexible(
                    child: Text(
                      education.location,
                      style: AppTheme.labelSmall(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacingLarge),
              Text(
                education.description,
                style: AppTheme.bodyMedium(),
              ),
              if (education.thesisTitle != null &&
                  education.thesisTitle!.isNotEmpty) ...[
                SizedBox(height: spacingLarge),
                Container(
                  padding: EdgeInsets.all(spacingMedium),
                  decoration: BoxDecoration(
                    color: education.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: education.color.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📜 Titre de la mémoire',
                        style: AppTheme.labelSmall(color: education.color),
                      ),
                      SizedBox(height: spacingSmall),
                      Text(
                        education.thesisTitle!,
                        style: AppTheme.subtitleSmall(),
                      ),
                    ],
                  ),
                ),
              ],
              if (education.capstoneProjects != null &&
                  education.capstoneProjects!.isNotEmpty) ...[
                SizedBox(height: spacingLarge),
                Text(
                  '🎓 Projets de fin d\'étude',
                  style: AppTheme.titleSmall(color: education.color),
                ),
                SizedBox(height: spacingMedium),
                ...education.capstoneProjects!.map((project) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spacingMedium),
                    child: Container(
                      padding: EdgeInsets.all(spacingMedium),
                      decoration: BoxDecoration(
                        color: education.color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: education.color.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  project['title']!,
                                  style: AppTheme.subtitleSmall(
                                      color: education.color),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star,
                                        size: 12, color: Colors.amber),
                                    SizedBox(width: 4),
                                    Text(
                                      project['stars']!,
                                      style: AppTheme.labelSmall(
                                          color: Colors.amber),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spacingSmall),
                          Text(
                            project['description']!,
                            style: AppTheme.labelSmall(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          if (project['technologies'] != null &&
                              project['technologies']!.isNotEmpty) ...[
                            SizedBox(height: spacingSmall),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: (project['technologies']!
                                          .split(',')
                                          .map((tech) => tech.trim()))
                                  .map((tech) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.purple.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    tech,
                                    style: AppTheme.labelSmall(
                                        color: Colors.purple),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                          SizedBox(height: spacingSmall),
                          GestureDetector(
                            onTap: () => _launchURL(project['url']!),
                            child: Text(
                              'Voir sur GitHub →',
                              style: AppTheme.labelSmall(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildMobileLayout(
    Education education,
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
                color: education.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                education.icon,
                color: education.color,
                size: iconSize,
              ),
            ),
            SizedBox(width: spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    education.degree,
                    style: AppTheme.titleSmallMobile(),
                  ),
                  SizedBox(height: spacingSmall),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: spacingMedium, vertical: spacingSmall / 2),
                    decoration: BoxDecoration(
                      color: education.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: education.color,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      education.status,
                      style: AppTheme.labelSmall(color: education.color),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: spacingMedium),
        Text(
          education.school,
          style: AppTheme.subtitleMobile(color: education.color),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: spacingSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, size: 12, color: Colors.grey[500]),
                SizedBox(width: spacingSmall),
                Flexible(
                  child: Text(
                    education.period,
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
                    education.location,
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
          education.description,
          style: AppTheme.bodyLargeMobile(),
          textAlign: TextAlign.justify,
        ),
        if (education.thesisTitle != null &&
            education.thesisTitle!.isNotEmpty) ...[
          SizedBox(height: spacingLarge),
          Container(
            padding: EdgeInsets.all(spacingMedium),
            decoration: BoxDecoration(
              color: education.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: education.color.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📜 Titre de la mémoire',
                  style: AppTheme.labelSmall(color: education.color),
                ),
                SizedBox(height: spacingSmall),
                Text(
                  education.thesisTitle!,
                  style: AppTheme.subtitleSmall(),
                ),
              ],
            ),
          ),
        ],
        if (education.capstoneProjects != null &&
            education.capstoneProjects!.isNotEmpty) ...[
          SizedBox(height: spacingLarge),
          Text(
            '🎓 Projets de fin d\'étude',
            style: AppTheme.titleSmallMobile(color: education.color),
          ),
          SizedBox(height: spacingMedium),
          ...education.capstoneProjects!.map((project) {
            return Padding(
              padding: EdgeInsets.only(bottom: spacingMedium),
              child: Container(
                padding: EdgeInsets.all(spacingMedium),
                decoration: BoxDecoration(
                  color: education.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: education.color.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            project['title']!,
                            style:
                                AppTheme.subtitleSmall(color: education.color),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 12, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                project['stars']!,
                                style: AppTheme.labelSmall(color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spacingSmall),
                    Text(
                      project['description']!,
                      style: AppTheme.labelSmall(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    if (project['technologies'] != null &&
                        project['technologies']!.isNotEmpty) ...[
                      SizedBox(height: spacingSmall),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: (project['technologies']!
                                .split(',')
                                .map((tech) => tech.trim()))
                            .map((tech) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tech,
                              style: AppTheme.labelSmall(color: Colors.purple),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    SizedBox(height: spacingSmall),
                    GestureDetector(
                      onTap: () => _launchURL(project['url']!),
                      child: Text(
                        'Voir sur GitHub →',
                        style: AppTheme.labelSmall(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ],
    );
  }
}
