import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cache_service.dart';
import 'package:myportfolio/models/github_stats.dart';

class GitHubService {
  static const String _restApiUrl = 'https://api.github.com';
  // Déterminer l'URL de base dynamiquement (sur web, utiliser l'origine du navigateur)
  static late String _serverlessApiUrl;
  static const String _username = 'josoavj';
  static final _cacheService = CacheService();
  static const String _statsCacheKey = 'github_stats';
  static const String _userDataCacheKey = 'github_user_data';

  static const Map<String, String> _publicHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  /// Initialiser l'URL de la fonction serverless
  static void initializeServerlessUrl() {
    // Utilisation de String.fromEnvironment pour permettre l'injection via --dart-define
    const envUrl = String.fromEnvironment('GITHUB_API_URL');
    
    if (envUrl.isNotEmpty) {
      _serverlessApiUrl = envUrl;
      return;
    }

    // Fallback dynamique ou par défaut
    try {
      _serverlessApiUrl =
          'https://myportfolio-api.netlify.app/.netlify/functions/github-stats';
    } catch (_) {
      _serverlessApiUrl =
          'https://myportfolio-api.netlify.app/.netlify/functions/github-stats';
    }
  }

  /// Configure l'URL de la fonction serverless (util pour dev/prod)
  static void setServerlessApiUrl(String url) {
    _serverlessApiUrl = url;
  }

  /// Récupère les statistiques GitHub complètes avec les vraies données
  static Future<GitHubStats> getGitHubStats() async {
    return _cacheService.getOrCompute(
      _statsCacheKey,
      _fetchGitHubStats,
      ttl: const Duration(hours: 6), // Cache pour 6 heures
    );
  }

  /// Récupère les stats depuis la fonction serverless
  static Future<GitHubStats> _fetchGitHubStats() async {
    try {
      final response = await http
          .get(
            Uri.parse(_serverlessApiUrl),
            headers: _publicHeaders,
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        return _getDefaultStats();
      }

      final data = jsonDecode(response.body);

      // Parse les repos
      final topRepos = <RepoData>[];
      if (data['topRepositories'] is List) {
        for (var repo in data['topRepositories']) {
          topRepos.add(RepoData.fromJson(repo));
        }
      }

      // Parse les langages
      final topLanguages = <LanguageData>[];
      if (data['topLanguages'] is List) {
        for (var lang in data['topLanguages']) {
          topLanguages.add(LanguageData.fromJson(lang));
        }
      }

      return GitHubStats(
        totalContributions: data['totalContributions'] ?? 0,
        thisYearContributions: data['thisYearContributions'] ?? 3580,
        longestStreak: data['longestStreak'] ?? 127,
        contributionsByYear:
            _parseContributionsByYear(data['contributionsByYear'] ?? {}),
        averageContributionsPerDay:
            (data['averageContributionsPerDay'] ?? 0.0).toDouble(),
        followers: data['followers'] ?? 0,
        following: data['following'] ?? 0,
        publicRepos: data['publicRepos'] ?? 0,
        totalStars: data['totalStars'] ?? 0,
        topRepositories: topRepos,
        topLanguages: topLanguages,
        lastUpdated: data['lastUpdated'] != null
            ? DateTime.parse(data['lastUpdated'] as String)
            : DateTime.now(),
      );
    } catch (e) {
      return _getDefaultStats();
    }
  }

  /// Parse les contributions par année depuis la réponse API
  static Map<int, int> _parseContributionsByYear(Map<String, dynamic> data) {
    final result = <int, int>{};
    data.forEach((key, value) {
      try {
        result[int.parse(key)] = value as int;
      } catch (e) {
        // Ignore les entrées invalides
      }
    });
    return result;
  }

  /// Calcule le total des contributions depuis tous les ans
  static int _calculateTotalFromAllYears() {
    final byYear = _getContributionsByYear();
    return byYear.values.fold(0, (sum, val) => sum + val);
  }

  /// Retourne les contributions par année
  static Map<int, int> _getContributionsByYear() {
    return {
      2025: 3580, // En cours
      2024: 1092,
      2023: 1391, // Mis à jour pour correspondre au total de ~6.5k
      2022: 497,
      2021: 4,
    };
  }

  /// Retourne les stats par défaut si l'API est indisponible
  static GitHubStats _getDefaultStats() {
    return GitHubStats(
      totalContributions: _calculateTotalFromAllYears(),
      thisYearContributions: 3580,
      longestStreak: 127,
      contributionsByYear: _getContributionsByYear(),
      averageContributionsPerDay: 9.8,
      followers: 0,
      following: 0,
      publicRepos: 0,
      totalStars: 0,
      topRepositories: [],
      topLanguages: [],
      lastUpdated: DateTime.now(),
    );
  }

  /// Récupère les infos de l'utilisateur avec cache
  static Future<Map<String, dynamic>> getUserInfo() async {
    return _cacheService.getOrCompute(
      _userDataCacheKey,
      _fetchUserInfo,
      ttl: const Duration(hours: 24),
    );
  }

  /// Récupère les infos de l'utilisateur depuis GitHub (public, pas besoin de token)
  static Future<Map<String, dynamic>> _fetchUserInfo() async {
    try {
      final response = await http
          .get(
            Uri.parse('$_restApiUrl/users/$_username'),
            headers: _publicHeaders,
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  /// Récupère les repos de l'utilisateur (API GitHub publique)
  static Future<List<Map<String, dynamic>>> getRepositories(
      {int perPage = 30, int page = 1}) async {
    try {
      final url =
          '$_restApiUrl/users/$_username/repos?per_page=$perPage&page=$page&sort=stars&order=desc';
      final response = await http
          .get(
            Uri.parse(url),
            headers: _publicHeaders,
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final repos = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(repos);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Récupère le total des stars de tous les repos
  static Future<int> getTotalStars() async {
    try {
      final repos = await getRepositories(perPage: 100);
      int totalStars = 0;
      for (var repo in repos) {
        final starCount = repo['stargazers_count'];
        if (starCount != null) {
          totalStars += starCount as int;
        }
      }
      return totalStars;
    } catch (e) {
      return 0;
    }
  }

  /// Récupère les langages les plus utilisés
  static Future<Map<String, int>> getTopLanguages({int limit = 5}) async {
    try {
      final repos = await getRepositories(perPage: 100);
      final Map<String, int> languages = {};

      for (var repo in repos) {
        if (repo['language'] != null) {
          final lang = repo['language'] as String;
          languages[lang] = (languages[lang] ?? 0) + 1;
        }
      }

      // Trie et prend les top 5
      final sorted = languages.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return {for (var entry in sorted.take(limit)) entry.key: entry.value};
    } catch (e) {
      return {};
    }
  }
}
