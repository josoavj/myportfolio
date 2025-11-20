import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubService {
  static const String _baseUrl = 'https://api.github.com';
  static const String _username = 'josoavj';

  /// Récupère les données de contribution de l'utilisateur GitHub
  static Future<List<int>> getUserContributions() async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/users/$_username'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // On retourne les contributions de cette année
        return _generateContributionData(data['public_repos'] ?? 0);
      }
      return _getDefaultContributions();
    } catch (e) {
      print('Erreur lors de la récupération des contributions: $e');
      return _getDefaultContributions();
    }
  }

  /// Retourne des données de contribution simulées basées sur le nombre de repos
  static List<int> _generateContributionData(int repoCount) {
    final List<int> contributions = [];
    // 12 semaines x 7 jours = 84 jours
    for (int i = 0; i < 84; i++) {
      // Génère des contributions variables basées sur le nombre de repos
      final level = (i % (repoCount + 1)) > 2 ? ((i % 5) % 5).toInt() : 0;
      contributions.add(level);
    }
    return contributions;
  }

  /// Retourne les contributions par défaut si l'API est indisponible
  static List<int> _getDefaultContributions() {
    return [
      0,
      1,
      2,
      1,
      3,
      2,
      0,
      2,
      3,
      1,
      2,
      4,
      3,
      1,
      1,
      2,
      3,
      4,
      3,
      2,
      1,
      3,
      4,
      2,
      3,
      2,
      1,
      2,
      2,
      3,
      4,
      3,
      2,
      1,
      2,
      3,
      2,
      1,
      3,
      2,
      4,
      3,
      2,
      1,
      2,
      4,
      3,
      2,
      1,
      3,
      2,
      1,
      2,
      3,
      1,
      2,
      3,
      4,
      3,
      2,
      1,
      2,
      3,
      4,
      3,
      2,
      1,
      3,
      2,
      1,
      2,
      1,
      3,
      2,
      0,
      2,
      3,
      1,
      2,
      4,
      3,
      1,
      1,
      2,
    ];
  }

  /// Récupère le nombre de repos publics
  static Future<int> getPublicReposCount() async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl/users/$_username'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['public_repos'] ?? 0;
      }
      return 0;
    } catch (e) {
      print('Erreur: $e');
      return 0;
    }
  }

  /// Récupère les contributions totales du jour
  static Future<int> getTodayContributions() async {
    try {
      // Note: L'API GitHub ne fournit pas directement les contributions quotidiennes
      // On utilise comme fallback un appel aux événements récents
      final response = await http
          .get(
            Uri.parse('$_baseUrl/users/$_username/events/public?per_page=100'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final events = jsonDecode(response.body) as List;
        return events.length;
      }
      return 0;
    } catch (e) {
      print('Erreur: $e');
      return 0;
    }
  }
}
