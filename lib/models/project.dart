/// Un défi technique et la solution retenue.
class ProjectChallenge {
  final String challenge;
  final String solution;

  const ProjectChallenge({required this.challenge, required this.solution});
}

/// Un chiffre vérifiable (version, nombre de tests, plateformes…).
class ProjectMetric {
  final String label;
  final String value;

  const ProjectMetric({required this.label, required this.value});
}

/// Un bloc d'architecture (couche, composant ou étape) et son rôle.
class ArchitectureItem {
  final String label;
  final String detail;

  const ArchitectureItem({required this.label, required this.detail});
}

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

  // --- Étude de cas (tous les champs sont optionnels : une section vide
  // n'est simplement pas affichée) ---
  final String tagline;
  final String status; // En production, En maintenance, Bêta…
  final String period;
  final String role;
  final String origin; // contexte : perso, side project, stage, université…
  final String problem; // contexte et objectif
  final String solution;
  final String architecture;
  final List<ArchitectureItem> architectureItems;
  final List<ProjectChallenge> challenges;
  final List<ProjectMetric> results;
  final List<String> roadmap; // à venir
  final List<String> learnings;
  final List<String> screenshots; // chemins d'assets (WebP optimisés)
  final String? demoUrl;
  final String? docsUrl;
  final Map<String, List<String>> stackByLayer;
  final List<String> relatedProjects;

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
    this.tagline = '',
    this.status = '',
    this.period = '',
    this.role = '',
    this.origin = '',
    this.problem = '',
    this.solution = '',
    this.architecture = '',
    this.architectureItems = const [],
    this.challenges = const [],
    this.results = const [],
    this.roadmap = const [],
    this.learnings = const [],
    this.screenshots = const [],
    this.demoUrl,
    this.docsUrl,
    this.stackByLayer = const {},
    this.relatedProjects = const [],
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
      tagline: tagline,
      status: status,
      period: period,
      role: role,
      origin: origin,
      problem: problem,
      solution: solution,
      architecture: architecture,
      architectureItems: architectureItems,
      challenges: challenges,
      results: results,
      roadmap: roadmap,
      learnings: learnings,
      screenshots: screenshots,
      demoUrl: demoUrl,
      docsUrl: docsUrl,
      stackByLayer: stackByLayer,
      relatedProjects: relatedProjects,
    );
  }
}
