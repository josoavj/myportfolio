import 'package:flutter/material.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/services/url_launcher_service.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final isLargeScreen = MediaQuery.of(context).size.width > 1200;

    if (isLargeScreen) {
      // Layout pour les grands écrans - contenu sur la gauche avec largeur maximale
      return Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D1117),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: _buildDetailContent(context, isSmall),
          ),
        ),
      );
    }

    // Layout normal pour les petits écrans
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 15 : 30,
            vertical: 20,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: _buildDetailContent(context, isSmall),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre et Github
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: isSmall
                        ? AppTheme.titleLargeMobile()
                        : AppTheme.titleLarge(),
                  ).withFadeIn(delay: const Duration(milliseconds: 100)),
                  const SizedBox(height: 10),
                  if (project.stars > 0)
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '${project.stars} stars',
                          style: AppTheme.bodyMedium(),
                        ),
                      ],
                    ).withFadeIn(delay: const Duration(milliseconds: 200)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Description détaillée
        if (project.detailedDescription.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'À propos',
                style: isSmall
                    ? AppTheme.titleMediumMobile()
                    : AppTheme.titleMedium(),
              ).withFadeIn(delay: const Duration(milliseconds: 250)),
              const SizedBox(height: 15),
              Text(
                project.detailedDescription,
                style:
                    isSmall ? AppTheme.bodyLargeMobile() : AppTheme.bodyLarge(),
                textAlign: TextAlign.justify,
              ).withFadeIn(delay: const Duration(milliseconds: 300)),
              const SizedBox(height: 40),
            ],
          ),

        // Fonctionnalités
        if (project.features.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fonctionnalités principales',
                style: isSmall
                    ? AppTheme.titleMediumMobile()
                    : AppTheme.titleMedium(),
              ).withFadeIn(delay: const Duration(milliseconds: 250)),
              const SizedBox(height: 15),
              ...project.features.asMap().entries.map((entry) {
                final index = entry.key;
                final feature = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.blue, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: isSmall
                              ? AppTheme.bodyLargeMobile()
                              : AppTheme.bodyMedium(),
                        ),
                      ),
                    ],
                  ),
                ).withFadeIn(
                  delay: Duration(milliseconds: 350 + (index * 50)),
                );
              }),
              const SizedBox(height: 40),
            ],
          ),

        // Technologies
        if (project.technologies.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Technologies utilisées',
                style: isSmall
                    ? AppTheme.titleMediumMobile()
                    : AppTheme.titleMedium(),
              ).withFadeIn(delay: const Duration(milliseconds: 250)),
              const SizedBox(height: 15),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: project.technologies.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tech = entry.value;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: AppTheme.label(color: Colors.blue),
                    ),
                  ).withSlideUp(
                    delay: Duration(milliseconds: 400 + (index * 40)),
                    distance: 10.0,
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
            ],
          ),

        // Boutons GitHub Final
        if (isSmall)
          // Layout mobile : boutons en colonne
          Column(
            spacing: 12,
            children: [
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.withValues(alpha: 0.15),
                        Colors.blue.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => UrlLauncherService.launchURL(project.url),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Voir sur GitHub'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
              if (project.releaseUrl != null && project.releaseUrl!.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.green.withValues(alpha: 0.15),
                          Colors.green.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          UrlLauncherService.launchURL(project.releaseUrl!),
                      icon: const Icon(Icons.download),
                      label: const Text('Voir les releases'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
            ],
          ).withScaleIn(delay: const Duration(milliseconds: 500))
        else
          // Layout desktop : boutons côte à côte
          Center(
            child: Wrap(
              spacing: 16,
              children: [
                SizedBox(
                  width: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.withValues(alpha: 0.15),
                          Colors.blue.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          UrlLauncherService.launchURL(project.url),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Voir sur GitHub'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
                if (project.releaseUrl != null &&
                    project.releaseUrl!.isNotEmpty)
                  SizedBox(
                    width: 250,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.green.withValues(alpha: 0.15),
                            Colors.green.withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            UrlLauncherService.launchURL(project.releaseUrl!),
                        icon: const Icon(Icons.download),
                        label: const Text('Voir les releases'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ).withScaleIn(delay: const Duration(milliseconds: 500)),
      ],
    );
  }
}
