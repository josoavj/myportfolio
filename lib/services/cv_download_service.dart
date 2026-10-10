import 'package:myportfolio/services/url_launcher_service.dart';

class CVDownloadService {
  /// Télécharge ou ouvre le CV de l'utilisateur
  /// [cvUrl] : URL où se trouve le fichier CV (Google Drive, GitHub, etc.)
  static Future<bool> downloadCV(String cvUrl) async {
    try {
      if (cvUrl.isNotEmpty) {
        await UrlLauncherService.launchURL(cvUrl);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Vérifie si le CV est disponible (URL non vide)
  static bool isCVAvailable(String cvUrl) {
    return cvUrl.isNotEmpty;
  }
}
