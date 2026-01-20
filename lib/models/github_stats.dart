class GitHubStats {
  final int totalContributions;
  final int thisYearContributions;
  final int longestStreak;
  final Map<int, int> contributionsByYear; // année -> nombre de contributions
  final double averageContributionsPerDay;
  final int followers;
  final int following;
  final int publicRepos;
  final int totalStars;
  final List<RepoData> topRepositories;
  final DateTime lastUpdated;

  GitHubStats({
    required this.totalContributions,
    required this.thisYearContributions,
    required this.longestStreak,
    required this.contributionsByYear,
    this.averageContributionsPerDay = 0.0,
    this.followers = 0,
    this.following = 0,
    this.publicRepos = 0,
    this.totalStars = 0,
    this.topRepositories = const [],
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();
}

class RepoData {
  final String name;
  final String description;
  final int stars;
  final String language;
  final String url;

  RepoData({
    required this.name,
    required this.description,
    required this.stars,
    required this.language,
    required this.url,
  });

  factory RepoData.fromJson(Map<String, dynamic> json) {
    return RepoData(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      stars: json['stargazers_count'] ?? 0,
      language: json['language'] ?? 'Unknown',
      url: json['html_url'] ?? '',
    );
  }
}
