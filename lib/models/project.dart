class Project {
  final String name;
  final String description;
  final String language;
  final int stars;
  final String url;
  final List<String> technologies;
  final List<String> features;
  final String detailedDescription;

  Project({
    required this.name,
    required this.description,
    required this.language,
    required this.stars,
    required this.url,
    this.technologies = const [],
    this.features = const [],
    this.detailedDescription = '',
  });
}
