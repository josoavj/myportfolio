class Project {
  final String name;
  final String description;
  final String language;
  final int stars;
  final String url;
  final List<String> technologies;
  final List<String> features;
  final String detailedDescription;
  final String? releaseUrl;
  final String category; // Web, Mobile, Desktop, Backend, Tools

  Project({
    required this.name,
    required this.description,
    required this.language,
    required this.stars,
    required this.url,
    required this.category,
    this.technologies = const [],
    this.features = const [],
    this.detailedDescription = '',
    this.releaseUrl,
  });

  /// Nom du dépôt GitHub (dernier segment de l'URL, en minuscules).
  String get repoName => Uri.parse(url).pathSegments.last.toLowerCase();

  Project withStars(int newStars) {
    return Project(
      name: name,
      description: description,
      language: language,
      stars: newStars,
      url: url,
      category: category,
      technologies: technologies,
      features: features,
      detailedDescription: detailedDescription,
      releaseUrl: releaseUrl,
    );
  }
}
