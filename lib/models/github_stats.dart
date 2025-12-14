class GitHubStats {
  final int totalContributions;
  final int thisYearContributions;
  final int longestStreak;
  final Map<int, int> contributionsByYear; // année -> nombre de contributions

  GitHubStats({
    required this.totalContributions,
    required this.thisYearContributions,
    required this.longestStreak,
    required this.contributionsByYear,
  });
}
