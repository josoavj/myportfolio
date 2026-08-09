import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/models/github_stats.dart';
import 'package:myportfolio/services/github_service.dart';

/// Provider pour les statistiques GitHub
final githubStatsProvider = FutureProvider<GitHubStats>((ref) async {
  return GitHubService.getGitHubStats();
});

/// Provider pour les infos utilisateur
final githubUserProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return GitHubService.getUserInfo();
});
