import 'package:flutter/material.dart';
import 'package:myportfolio/services/url_launcher_service.dart';
import 'package:myportfolio/utils/app_theme.dart';

class SocialButton extends StatefulWidget {
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
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: AppTheme.glassDecoration(
          color: isHovered ? Colors.blue : Colors.blueGrey,
          opacity: isHovered ? 0.2 : 0.1,
          borderRadius: 30,
        ),
        child: ElevatedButton.icon(
          onPressed: () => UrlLauncherService.launchURL(widget.url),
          icon: Icon(
            widget.icon,
            size: 20,
            color: isHovered ? Colors.blue.shade300 : Colors.white,
          ),
          label: Text(
            widget.label,
            style: AppTheme.labelSmall(
              color: isHovered ? Colors.blue.shade300 : Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
