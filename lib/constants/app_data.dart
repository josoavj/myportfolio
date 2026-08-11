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
          'Prospectius - Plateforme CRM complète de gestion de prospects et clients (7 stars)',
          'Planificator - Application desktop Flutter pour planification (4 stars)',
          'Segma - Logiciel de segmentation d\'images utilisant SAM Model (6 stars)',
          'Contributions actives aux projets open source de l\'équipe',
          'Configuration et optimisation avancée de serveurs Linux',
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
        color: Colors.blue,
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
          'lvlmind - Application e-learning mobile Flutter avec 19 stars sur GitHub',
          'myportfolio - Portfolio multiplateforme Flutter intégré à l\'API GitHub (7 stars)',
          'Prospectius - Plateforme CRM complète pour la gestion de prospects et clients (7 stars)',
          'Planificator - Application desktop Flutter pour planification (4 stars)',
          'elasticsearchconfig - Configuration et optimisation Elasticsearch (5 stars)',
          'elasticsearch-nodejs-server - Solution de monitoring Fortinet (15 stars)',
          'Contribution à 43 projets open source sur GitHub',
          'Participation à des TP avancés d\'algorithmique et machine learning',
        ],
        icon: Icons.storage,
        color: const Color(0xFF25D366),
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
        color: const Color(0xFF25D366),
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
        color: Colors.blue,
        status: 'Continue',
      ),
    ];
  }

  static List<Project> getProjects() {
    return [
      // Projets principaux (affichés en premier)
      Project(
        name: 'Levelmind',
        category: 'Mobile',
        description:
            'Application mobile e-learning innovante conçue pour centraliser les ressources pédagogiques et faciliter la communication académique',
        language: 'Dart',
        stars: 19,
        url: 'https://github.com/josoavj/lvlmindapp',
        releaseUrl: 'https://github.com/josoavj/lvlmindapp/releases',
        technologies: [
          'Flutter',
          'Dart',
          'Provider (MVVM)',
          'Hive (NoSQL)',
          'SHA256 Security',
          'Iconsax'
        ],
        features: [
          'Authentification sécurisée (SHA256 & Session Recovery)',
          'Gestion de profil avec persistance automatique',
          'Partage et consultation de cours hiérarchisés',
          'Visualisation des emplois du temps',
          'Base de données locale Hive ultra-rapide',
          'Architecture scalable (Singleton, Repository, Observer)',
        ],
        detailedDescription:
            'LevelMind est un écosystème numérique complet pour étudiants et enseignants. Actuellement en phase BETA, l\'application offre une expérience mobile fluide et sécurisée. Elle repose sur une architecture MVVM rigoureuse et utilise Hive pour garantir un accès rapide aux données, même hors connexion. Le projet met un accent fort sur l\'extensibilité pour inclure prochainement de la messagerie et du suivi académique.',
      ),
      Project(
        name: 'segma',
        category: 'Desktop',
        description:
            'Logiciel de segmentation d\'images haute performance utilisant Meta SAM 3 et architecture Flutter/FastAPI',
        language: 'Dart',
        stars: 6,
        url: 'https://github.com/josoavj/segma',
        releaseUrl: 'https://github.com/josoavj/segma/releases',
        technologies: [
          'Flutter 3.6+',
          'Riverpod',
          'FastAPI (Python)',
          'PyTorch (SAM 3)',
          'CUDA (NVIDIA GPU)',
          'Docker'
        ],
        features: [
          'Segmentation interactive via clics (inclure/exclure)',
          'Segmentation textuelle par requêtes naturelles',
          'Traitement par lots (Batch) de dossiers complets',
          'Streaming NDJSON pour suivi de progression réel',
          'Exploration intelligente des fichiers système',
          'Gestion d\'historique avec filtres de confiance',
        ],
        detailedDescription:
            'SEGMA est une solution industrielle de computer vision alliant la puissance de Meta SAM 3 et la flexibilité de Flutter. Conçue pour la rapidité, elle supporte nativement l\'accélération GPU via CUDA. Le logiciel propose un workflow complet allant de l\'exploration intelligente des dossiers au traitement automatisé par lots, le tout piloté par un backend FastAPI asynchrone.',
      ),
      Project(
        name: 'Planificator',
        category: 'Desktop',
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
        category: 'Web',
        description:
            'Plateforme de monitoring de production pour visualiser et suivre les données Fortigate depuis Elasticsearch',
        language: 'JavaScript',
        stars: 6,
        url: 'https://github.com/josoavj/sfiDashMonitoring',
        technologies: [
          'React 19',
          'Vite',
          'Node.js',
          'Express',
          'Elasticsearch 8.x',
          'Socket.io',
          'JWT (HttpOnly)',
          'Docker',
          'Prometheus'
        ],
        features: [
          'Dashboard temps réel via WebSockets',
          'Monitoring direct des données Fortigate',
          'Système d\'alertes haute bande passante',
          'Sécurité renforcée : Rotation de Refresh Token & HttpOnly Cookies',
          'Observabilité avec métriques Prometheus',
          'Documentation interactive Swagger/OpenAPI',
          'Support déploiement Docker & Nginx',
        ],
        detailedDescription:
            'sfiDashMonitoring est une solution complète de monitoring "full-stack" conçue pour transformer les journaux bruts d\'Elasticsearch en visualisations exploitables. Développée avec un focus majeur sur la sécurité (protection XSS/CSRF, rotation de tokens) et l\'observabilité, la plateforme permet un suivi en temps réel des flux réseau Fortigate. Elle intègre des tests unitaires et de sécurité rigoureux via Vitest.',
      ),

      // Projets secondaires
      Project(
        name: 'elasticsearch-nodejs-server',
        category: 'Backend',
        description:
            'Serveur Node.js/Express et client React pour filtrer, rechercher et explorer les journaux syslog (Fortinet) avec Elasticsearch',
        language: 'JavaScript',
        stars: 15,
        url: 'https://github.com/josoavj/elasticsearch-nodejs-server',
        technologies: [
          'Node.js',
          'Express',
          'Elasticsearch',
          'React',
          'WebSockets',
          'JWT',
          'Docker',
          'Dotenv-vault'
        ],
        features: [
          'Syslog Explorer : Interface de recherche avancée',
          'API REST robuste avec pagination Offset & Cursor',
          'Streaming temps réel via WebSockets',
          'Sécurité : Protection JWT & Dotenv-vault',
          'Performance : Circuit Breaker (ES Guard) & Rate Limiting',
          'Normalisation des sorties Syslog/Raw',
          'Gestion complète des indices et mappings',
        ],
        detailedDescription:
            'elasticsearch-nodejs-server est une solution d\'interfaçage sophistiquée pour l\'Elastic Stack. Elle fournit un backend robuste capable de traiter des volumes importants de journaux syslog tout en garantissant la stabilité du serveur via des mécanismes de "Circuit Breaker". Le projet inclut un client React moderne pour une exploration intuitive des données et une gestion sécurisée des variables d\'environnement.',
      ),
      Project(
        name: 'myportfolio',
        category: 'Mobile',
        description: 'Portfolio multiplateforme développée en Flutter',
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
        name: 'Prospectius',
        category: 'Desktop',
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
            'Prospectius est une plateforme CRM professionnelle développée en Flutter pour la gestion complète des prospects et clients. Utilise Firebase et Firestore pour le stockage des données en temps réel. Offre des outils de suivi, d\'analyse et de gestion des pipelines de vente avec une interface intuitive et multiplateforme.',
      ),
      Project(
        name: 'elasticsearch-config',
        category: 'Tools',
        description:
            'Configuration et optimisation de l\'Elastic Stack (ELK 8.14+) pour serveurs Ubuntu',
        language: 'Markdown',
        stars: 5,
        url: 'https://github.com/josoavj/elasticsearch-config',
        technologies: [
          'Elasticsearch 8.14+',
          'Kibana',
          'Filebeat',
          'Ubuntu Server',
          'Linux',
          'ELK Stack'
        ],
        features: [
          'Installation pas à pas de l\'ELK Stack',
          'Configuration Multi-Node optimisée',
          'Gestion de la licence "Basic" Elastic',
          'Intégration complète Kibana & Filebeat',
          'Optimisations pour Ubuntu Server',
          'Documentation technique détaillée',
        ],
        detailedDescription:
            'elasticsearch-config est un guide pratique et une base de configuration pour le déploiement de l\'Elastic Stack en environnement Linux. Il couvre l\'installation, la sécurisation de base et l\'optimisation des performances pour les versions 8.14+, avec des configurations spécifiques pour les architectures à plusieurs nœuds.',
      ),
    ];
  }

  static Map<String, List<Skill>> getSkillsByCategory() {
    return {
      'Langages': [
        Skill(name: 'Dart', level: 0.9, color: Colors.blue),
        Skill(name: 'JavaScript', level: 0.75, color: Colors.yellow),
        Skill(name: 'Python', level: 0.8, color: Colors.green),
        Skill(name: 'Java', level: 0.55, color: Colors.red),
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
        Skill(name: 'Cybersécurité', level: 0.65, color: Colors.red),
        Skill(name: 'Networking', level: 0.60, color: Colors.indigo),
        Skill(name: 'Kali Linux', level: 0.75, color: Colors.red),
        Skill(name: 'Firewall Config', level: 0.45, color: Colors.purple),
      ],
    };
  }

  static List<Map<String, dynamic>> getTechBadges() {
    return [
      // Langages
      {'name': 'Dart', 'icon': '', 'color': Colors.blue},
      {'name': 'Python', 'icon': '', 'color': Colors.yellow},
      {'name': 'JavaScript', 'icon': '', 'color': Colors.yellow},
      {'name': 'Java', 'icon': '', 'color': Colors.red},
      // Frameworks & Librairies
      {'name': 'Flutter', 'icon': '', 'color': Colors.blue},
      {'name': 'React', 'icon': '', 'color': Colors.cyan},
      {'name': 'Node.js', 'icon': '', 'color': Colors.green},
      {'name': 'Express.js', 'icon': '', 'color': Colors.grey},
      // Bases de Données
      {'name': 'MySQL', 'icon': '', 'color': Colors.blue},
      {'name': 'Elasticsearch', 'icon': '', 'color': Colors.teal},
      {'name': 'Hive', 'icon': '', 'color': Colors.green},
      // DevOps & Outils
      {'name': 'Linux', 'icon': '', 'color': Colors.orange},
      {'name': 'Git', 'icon': '', 'color': Colors.orange},
      {'name': 'Nginx', 'icon': '', 'color': Colors.green},
      {'name': 'Bash', 'icon': '', 'color': Colors.grey},
      // Outils de Développement
      {'name': 'VS Code', 'icon': '', 'color': Colors.blue},
      {'name': 'Android Studio', 'icon': '', 'color': Colors.green},
      {'name': 'PyCharm', 'icon': '', 'color': Colors.blue},
      {'name': 'WebStorm', 'icon': '', 'color': Colors.blue},
      // Sécurité & Networking
      {'name': 'Security', 'icon': '', 'color': Colors.red},
      {'name': 'Networking', 'icon': '', 'color': Colors.indigo},
      {'name': 'Kali Linux', 'icon': '', 'color': Colors.red},
    ];
  }
}
