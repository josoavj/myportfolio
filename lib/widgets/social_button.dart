import 'package:flutter/material.dart';
import 'package:myportfolio/services/url_launcher_service.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => UrlLauncherService.launchURL(url),
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
