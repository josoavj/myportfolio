import 'package:flutter/material.dart';
import 'package:myportfolio/models/education.dart';
import 'package:myportfolio/models/experience.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/models/skill.dart';

class AppData {
  static List<Experience> getExperiences() {
    return [
      Experience(
        role: 'Développeur Full Stack',
        company: 'APEXNova Labs',
        period: '2023 - Présent',
        location: 'Antananarivo, Madagascar',
        description:
            'Développement d\'applications web et mobile multiplateforme. Contribution active à des projets open source. '
            'Travail sur des solutions avancées de sécurité, networking et data analytics.',
        achievements: [
          'ProspectiusFinal - Plateforme CRM complète de gestion de prospects et clients (7 stars)',
          'PlanificatorFinal - Application desktop Flutter pour planification (4 stars)',
          'Segma - Logiciel de segmentation d\'images utilisant SAM Model (6 stars)',
          'Contributions actives aux projets open source de l\'équipe',
          'Configuration et optimisation avancée de serveurs Linux',
          'Implémentation d\'algorithmes complexes (Jacobi, Machine Learning)',
        ],
        icon: Icons.business,
        color: Colors.blue,
      ),
      Experience(
        role: 'Développeur Back-End (Stage)',
        company: 'SFI Ankorondrano',
        period: '2024 (3 mois)',
        location: 'Ankorondrano, Antananarivo',
        description:
            'Stage de développement d\'un système complet de monitoring et collecte de données. '
            'Mise en place de l\'infrastructure Elasticsearch, développement de serveurs NodeJS/Express, '
            'et configuration avancée pour le traitement des données Fortinet avec architecture asynchrone.',
        achievements: [
          'sfiDashMonitoring - Dashboard React avec Elasticsearch en temps réel (6 stars)',
          'elasticsearch-nodejs-server - Serveur pour filtrer données Fortinet (15 stars)',
          'Intégration Filebeat et Kibana pour monitoring complète',
          'Configuration d\'Elasticsearch et Grafana',
          'API REST robuste avec authentification JWT',
          'Architecture socket.io pour communication temps réel',
          'Optimisation des performances de la collecte de données',
        ],
        icon: Icons.code,
        color: Colors.orange,
      ),
      Experience(
        role: 'Développeur Full Stack',
        company: 'Projets Universitaires & Freelance',
        period: '2021 - 2024',
        location: 'Madagascar',
        description:
            'Développement de solutions complètes full stack incluant applications mobiles, '
            'applications desktop, APIs et bases de données. '
            'Conception et implémentation architectures robustes avec technologies modernes.',
        achievements: [
          'lvlmindapp - Application e-learning mobile Flutter avec 19 stars sur GitHub',
          'myportfolio - Portfolio multiplateforme Flutter intégré à l\'API GitHub (7 stars)',
          'ProspectiusFinal - Plateforme CRM complète pour la gestion de prospects et clients (7 stars)',
          'PlanificatorFinal - Application desktop Flutter pour planification (4 stars)',
          'elasticsearchconfig - Configuration et optimisation Elasticsearch (5 stars)',
          'elasticsearch-nodejs-server - Solution de monitoring Fortinet (15 stars)',
          'Contribution à 43 projets open source sur GitHub',
          'Participation à des TP avancés d\'algorithmique et machine learning',
        ],
        icon: Icons.storage,
        color: Colors.green,
      ),
    ];
  }

  static List<Education> getEducation() {
    return [
      Education(
        degree: 'Master 2 en Informatique et Télécommunication',
        school: 'ISPM (Institut Supérieur Polytechnique de Madagascar)',
        period: '2024 - En cours',
        location: 'Antananarivo, Madagascar',
        description:
            'Formation avancée en systèmes d\'information, réseaux et télécommunications. '
            'Spécialisation en architecture logicielle, sécurité des systèmes et technologies cloud. '
            'Parcours ESIIA (Électronique, Systèmes Informatiques, Informatique et Intelligence Artificielle).',
        icon: Icons.school,
        color: Colors.blue,
        status: 'En cours',
      ),
      Education(
        degree: 'Master 1 en Informatique et Télécommunication',
        school: 'ISPM (Institut Supérieur Polytechnique de Madagascar)',
        period: '2023 - 2024',
        location: 'Antananarivo, Madagascar',
        description:
            'Approfondissement des connaissances en développement logiciel, réseaux, bases de données avancées et cybersécurité.',
        icon: Icons.school,
        color: Colors.purple,
        status: 'Terminé',
      ),
      Education(
        degree: 'Licence en Informatique et Télécommunication',
        school: 'ISPM (Institut Supérieur Polytechnique de Madagascar)',
        period: '2020 - 2023',
        location: 'Antananarivo, Madagascar',
        description:
            'Formation en développement logiciel, bases de données, networking et télécommunications avec spécialisation en systèmes distribués et monitoring de données.',
        icon: Icons.school,
        color: Colors.green,
        status: 'Obtenu',
        thesisTitle:
            'PLATEFORME DE MONITORING DE BANDE PASSANTE ET SERVEUR DE TRAITEMENT DE JOURNAUX FORTIGATE',
        capstoneProjects: [
          {
            'title': 'sfiDashMonitoring',
            'description':
                'Dashboard React avec Elasticsearch en temps réel pour monitoring Fortinet',
            'url': 'https://github.com/josoavj/sfiDashMonitoring',
            'stars': '6',
            'technologies': 'ReactJS, ExpressJS, Elasticsearch',
          },
          {
            'title': 'elasticsearch-config',
            'description':
                'Configuration et optimisation avancée d\'Elasticsearch pour la gestion de données',
            'url': 'https://github.com/josoavj/elasticsearch-config',
            'stars': '5',
            'technologies': 'Elasticsearch, Kibana, Filebeat',
          },
        ],
      ),
      Education(
        degree: 'Formations Techniques Complémentaires',
        school: 'Auto-formation & Projets Pratiques',
        period: '2021 - Présent',
        location: 'En ligne & Présentiel',
        description:
            'Formations spécialisées en Elasticsearch, Kibana, Grafana, Docker, Linux Administration, '
            'sécurité réseau et développement d\'APIs avec Node.js/Express.',
        icon: Icons.card_membership,
        color: Colors.orange,
        status: 'Continue',
      ),
    ];
  }

  static List<Project> getProjects() {
    return [
      // Projets principaux (affichés en premier)
      Project(
        name: 'lvlmindapp',
        description:
            'Application mobile Flutter pour la gestion de l\'apprentissage et du développement personnel',
        language: 'Dart',
        stars: 19,
        url: 'https://github.com/josoavj/lvlmindapp',
        releaseUrl: 'https://github.com/josoavj/lvlmindapp/releases',
        technologies: [
          'Flutter',
          'Dart',
          'Provider',
          'Hive',
          'Crypto',
          'Google Fonts'
        ],
        features: [
          'Authentification sécurisée avec hachage SHA256',
          'Base de données Hive pour stockage local',
          'Gestion des profils utilisateur',
          'Emplois du temps intégrés',
          'Partage de cours et ressources pédagogiques',
          'Architecture MVVM avec Provider',
        ],
        detailedDescription:
            'lvlmindapp est une application mobile complète développée en Flutter pour révolutionner l\'expérience d\'apprentissage. Elle offre une plateforme d\'e-learning innovante pour les étudiants et enseignants avec authentification sécurisée, gestion de profil, emplois du temps et partage de ressources pédagogiques. Conçue avec une architecture MVVM robuste et une base de données Hive optimisée.',
      ),
      Project(
        name: 'segma',
        description:
            'Logiciel de segmentation d\'images utilisant le modèle SAM (Segment Anything Model)',
        language: 'Dart',
        stars: 6,
        url: 'https://github.com/josoavj/segma',
        releaseUrl: 'https://github.com/josoavj/segma/releases',
        technologies: [
          'Flutter',
          'Dart',
          'Python',
          'SAM Model',
          'Google Fonts'
        ],
        features: [
          'Interface multi-plateforme (Android, iOS, Web, Windows, Linux, macOS)',
          'Intégration backend Python avec SAM',
          'Segmentation d\'images haute précision',
          'API REST pour traitement des images',
          'Gestion complète des workflows de segmentation',
          'Architecture séparation Frontend/Backend',
        ],
        detailedDescription:
            'Segma est un logiciel innovant de segmentation d\'images utilisant le puissant modèle SAM (Segment Anything Model). Développé en Flutter pour le frontend et Python pour le backend, il offre une solution multi-plateforme pour le traitement d\'images et la computer vision. Interface intuitive avec API REST pour une intégration facile dans d\'autres applications.',
      ),
      Project(
        name: 'PlanificatorFinal',
        description:
            'Application desktop multiplateforme pour planification et gestion de projets avec Flutter',
        language: 'Dart',
        stars: 4,
        url: 'https://github.com/josoavj/PlanificatorFinal',
        technologies: [
          'Flutter',
          'Dart',
          'Provider',
          'SQLite',
          'Material Design'
        ],
        features: [
          'Interface multiplateforme Flutter (Android, iOS, Windows, Linux, macOS)',
          'Gestion complète des tâches et plannings',
          'Base de données SQLite intégrée',
          'Opérations CRUD optimisées',
          'Système de notifications et reminders',
          'Architecture Provider pour gestion d\'état',
          'Design Material moderne et responsive',
        ],
        detailedDescription:
            'Application desktop multiplateforme de planification développée en Flutter. Utilise SQLite pour la persistance des données avec Provider pour la gestion d\'état. Offre une solution complète et moderne pour la gestion des projets, tâches et plannings avec interface intuitive et Material Design.',
      ),
      Project(
        name: 'sfiDashMonitoring',
        description:
            'Plateforme de monitoring en temps réel avec React et Elasticsearch',
        language: 'JavaScript',
        stars: 6,
        url: 'https://github.com/josoavj/sfiDashMonitoring',
        technologies: [
          'React',
          'Node.js/Express',
          'Elasticsearch',
          'Socket.io',
          'Material-UI',
          'Vite'
        ],
        features: [
          'Dashboard temps réel avec WebSocket (Socket.io)',
          'Monitoring Elasticsearch complète',
          'Alertes haute bande passante',
          'Deux modes de déploiement (LOCAL et DEPLOYED)',
          'Authentification JWT intégrée',
          'Interface responsive Material-UI',
        ],
        detailedDescription:
            'Plateforme de monitoring sophistiquée développée lors du stage chez SFI Ankorondrano. Utilise React 19 en frontend avec Material-UI, Node.js/Express en backend, et Elasticsearch pour la gestion des données. Supporte deux modes de déploiement (local pour développement et déploiement réseau). Communication en temps réel via Socket.io avec authentification JWT robuste.',
      ),

      // Projets secondaires
      Project(
        name: 'elasticsearch-nodejs-server',
        description:
            'Serveur NodeJS pour filtrer et traiter les données Fortinet avec Elasticsearch',
        language: 'JavaScript',
        stars: 15,
        url: 'https://github.com/josoavj/elasticsearch-nodejs-server',
        technologies: [
          'Node.js',
          'Express.js',
          'Elasticsearch',
          'Filebeat',
          'Kibana',
          'Docker'
        ],
        features: [
          'Intégration complète avec Elasticsearch et Kibana',
          'Filtrage avancé des données Fortinet',
          'API REST pour requêtes de données',
          'Configuration Filebeat automatisée',
          'Gestion des indices et mappings',
          'Documentation Docker complète',
        ],
        detailedDescription:
            'Serveur Node.js/Express conçu pour traiter et filtrer les données Fortinet en utilisant Elasticsearch. Développé pendant le stage chez SFI, il fournit une API robuste pour l\'accès aux données, la gestion des indices et des mappings. Inclut configuration Filebeat et Kibana pour une solution de monitoring complète.',
      ),
      Project(
        name: 'myportfolio',
        description:
            'Application portfolio mobile multiplateforme développée en Flutter',
        language: 'Dart',
        stars: 7,
        url: 'https://github.com/josoavj/myportfolio',
        releaseUrl: 'https://github.com/josoavj/myportfolio/releases',
        technologies: [
          'Flutter',
          'Dart',
          'Provider',
          'GitHub API',
          'Responsive Design'
        ],
        features: [
          'Interface multiplateforme (iOS, Android, Web, Windows, Linux, macOS)',
          'Intégration en temps réel avec l\'API GitHub',
          'Affichage dynamique des projets et contributions',
          'Statistiques GitHub en direct',
          'Design responsive et moderne',
          'Cache service pour optimisation',
        ],
        detailedDescription:
            'Portfolio personnel multiplateforme développé en Flutter qui affiche dynamiquement les projets et les statistiques GitHub. Utilise l\'API GitHub pour récupérer les données en temps réel, offrant une présentation moderne et interactive de vos réalisations. Accessible sur tous les appareils avec une interface cohérente et professionnelle.',
      ),
      Project(
        name: 'ProspectiusFinal',
        description:
            'Plateforme CRM complète pour la gestion de prospects et clients',
        language: 'Dart',
        stars: 7,
        url: 'https://github.com/josoavj/ProspectiusFinal',
        technologies: [
          'Flutter',
          'Dart',
          'Provider',
        ],
        features: [
          'Gestion complète des prospects et clients',
          'Système de suivi et pipelines de vente',
          'Analytics et rapports détaillés',
          'Notifications temps réel',
          'Architecture MVVM avec Provider',
          'Recherche et filtrage avancés',
        ],
        detailedDescription:
            'ProspectiusFinal est une plateforme CRM professionnelle développée en Flutter pour la gestion complète des prospects et clients. Utilise Firebase et Firestore pour le stockage des données en temps réel. Offre des outils de suivi, d\'analyse et de gestion des pipelines de vente avec une interface intuitive et multiplateforme.',
      ),
      Project(
        name: 'elasticsearchconfig',
        description:
            'Configuration et optimisation avancée d\'Elasticsearch pour la recherche et l\'analyse de données',
        language: 'Bash',
        stars: 5,
        url: 'https://github.com/josoavj/elasticsearchconfig',
        technologies: [
          'Elasticsearch',
          'Bash',
          'Docker',
          'Kibana',
          'Filebeat',
          'Linux'
        ],
        features: [
          'Scripts de configuration Elasticsearch optimisés',
          'Gestion des indices et mappings',
          'Configuration Filebeat automatisée',
          'Pipelines de traitement de données',
          'Monitoring avec Kibana',
          'Backup et restore procedures',
          'Performance tuning et scaling',
          'Documentation et exemples complets',
        ],
        detailedDescription:
            'Dépôt de configuration et d\'optimisation pour Elasticsearch. Inclut des scripts bash réutilisables pour l\'installation, la configuration et la gestion des clusters Elasticsearch. Couvre les aspects de monitoring avec Kibana, l\'intégration de Filebeat et les meilleures pratiques de performance.',
      ),
    ];
  }

  static Map<String, List<Skill>> getSkillsByCategory() {
    return {
      'Langages': [
        Skill(name: 'Dart', level: 0.9, color: Colors.blue),
        Skill(name: 'JavaScript', level: 0.85, color: Colors.yellow),
        Skill(name: 'Python', level: 0.8, color: Colors.green),
        Skill(name: 'Java', level: 0.75, color: Colors.red),
        Skill(name: 'Shell', level: 0.85, color: Colors.grey),
      ],
      'Frameworks': [
        Skill(name: 'Flutter', level: 0.9, color: Colors.blue),
        Skill(name: 'Node.js', level: 0.85, color: Colors.green),
        Skill(name: 'Express.js', level: 0.8, color: Colors.grey),
        Skill(name: 'React', level: 0.5, color: Colors.cyan),
      ],
      'Bases de Données': [
        Skill(name: 'MySQL', level: 0.85, color: Colors.blue),
        Skill(name: 'Elasticsearch', level: 0.8, color: Colors.teal),
        Skill(name: 'Hive', level: 0.5, color: Colors.green),
      ],
      'DevOps & Outils': [
        Skill(name: 'Linux', level: 0.9, color: Colors.orange),
        Skill(name: 'Git', level: 0.9, color: Colors.orange),
        Skill(name: 'Nginx', level: 0.6, color: Colors.green),
        Skill(name: 'Bash', level: 0.85, color: Colors.grey),
      ],
      'Sécurité & Networking': [
        Skill(name: 'Cybersécurité', level: 0.85, color: Colors.red),
        Skill(name: 'Networking', level: 0.8, color: Colors.indigo),
        Skill(name: 'Kali Linux', level: 0.75, color: Colors.red),
        Skill(name: 'Firewall Config', level: 0.8, color: Colors.purple),
      ],
    };
  }

  static List<Map<String, dynamic>> getTechBadges() {
    return [
      // Langages
      {'name': 'Dart', 'icon': '🎯', 'color': Colors.blue},
      {'name': 'Python', 'icon': '🐍', 'color': Colors.yellow},
      {'name': 'JavaScript', 'icon': '⚡', 'color': Colors.yellow},
      {'name': 'Java', 'icon': '☕', 'color': Colors.red},
      {'name': 'Shell', 'icon': '🔧', 'color': Colors.grey},
      // Frameworks & Librairies
      {'name': 'Flutter', 'icon': '📱', 'color': Colors.blue},
      {'name': 'React', 'icon': '⚛️', 'color': Colors.cyan},
      {'name': 'Node.js', 'icon': '🟢', 'color': Colors.green},
      {'name': 'Express.js', 'icon': '🚀', 'color': Colors.grey},
      {'name': 'Provider', 'icon': '📦', 'color': Colors.blue},
      // Bases de Données
      {'name': 'MySQL', 'icon': '🗄️', 'color': Colors.blue},
      {'name': 'Elasticsearch', 'icon': '🔍', 'color': Colors.teal},
      {'name': 'Hive', 'icon': '🍯', 'color': Colors.green},
      // DevOps & Outils
      {'name': 'Linux', 'icon': '🐧', 'color': Colors.orange},
      {'name': 'Git', 'icon': '📦', 'color': Colors.orange},
      {'name': 'Nginx', 'icon': '🌐', 'color': Colors.green},
      {'name': 'Bash', 'icon': '⚙️', 'color': Colors.grey},
      // Outils de Développement
      {'name': 'VS Code', 'icon': '💻', 'color': Colors.blue},
      {'name': 'Android Studio', 'icon': '🤖', 'color': Colors.green},
      {'name': 'PyCharm', 'icon': '🐍', 'color': Colors.blue},
      {'name': 'WebStorm', 'icon': '🌐', 'color': Colors.blue},
      // Sécurité & Networking
      {'name': 'Security', 'icon': '🔐', 'color': Colors.red},
      {'name': 'Networking', 'icon': '🔗', 'color': Colors.indigo},
      {'name': 'Kali Linux', 'icon': '🐉', 'color': Colors.red},
      {'name': 'Machine Learning', 'icon': '🤖', 'color': Colors.deepPurple},
    ];
  }
}
