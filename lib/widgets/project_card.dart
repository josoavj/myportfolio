import 'package:flutter/material.dart';
import 'package:myportfolio/services/url_launcher_service.dart';

class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final Color languageColor;

  const ProjectCard({
    super.key,
    required this.project,
    required this.languageColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => UrlLauncherService.launchURL(project['url']),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.folder, color: Colors.blue, size: 30),
                const Spacer(),
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 5),
                Text(
                  '${project['stars']}',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              project['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                project['description'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  height: 1.4,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: languageColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  project['language'],
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
