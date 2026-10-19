import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static Future<void> launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (kIsWeb) {
        if (uri.scheme == 'mailto') {
          await launchUrl(uri, webOnlyWindowName: '_self');
        } else {
          await launchUrl(uri, webOnlyWindowName: '_blank');
        }
      } else {
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint('Could not launch $url');
        }
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
    }
  }

  static Future<void> launchEmail({
    required String email,
    required String subject,
    required String body,
  }) async {
    final String mailtoUrl =
        'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
    await launchURL(mailtoUrl);
  }
}
