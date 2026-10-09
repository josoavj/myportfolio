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
        color: const Color(0xFF25D366),
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
        color: Colors.blue,
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
            'Spécialisation en architecture logicielle, sécurité des systèmes, Machine Learning et Ontologie. '
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
            'Approfondissement en développement logiciel, réseaux et cybersécurité. '
            'Gestion des bases de données relationnelles, introduction au Machine Learning et optimisation des systèmes.',
        icon: Icons.school,
        color: const Color(0xFF25D366),
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
        color: Colors.blue,
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
        color: const Color(0xFF25D366),
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
            'Application desktop pour planification et gestion de projets avec Flutter',
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
            'Application desktop de planification développée en Flutter. Utilise SQLite pour la persistance des données avec Provider pour la gestion d\'état. Offre une solution complète et moderne pour la gestion des projets, tâches et plannings avec interface intuitive et Material Design.',
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

      Project(
        name: 'MagicMirror',
        category: 'Mobile',
        description:
            'Miroir intelligent modulaire : caméra temps réel, météo, agenda et suggestions de tenues par IA selon la morphologie et le contexte du jour',
        language: 'Dart',
        stars: 0,
        url: 'https://github.com/josoavj/magicmirror',
        releaseUrl: 'https://github.com/josoavj/magicmirror/releases',
        technologies: [
          'Flutter',
          'Dart',
          'Riverpod',
          'Supabase',
          'Google ML Kit',
          'OpenWeatherMap',
          'LightGBM',
          'Flutter TTS',
        ],
        features: [
          'Miroir caméra temps réel avec contrôles de zoom et d\'exposition',
          'Agenda cloud Supabase avec gestion complète (CRUD)',
          'Météo en temps réel et géolocalisation (OpenWeatherMap)',
          'Détection de la morphologie par IA (Google ML Kit)',
          'Suggestions de tenues : ranking hybride Heuristique + ML + LLM',
          'Garde-robe, profil synchronisé dans le cloud et synthèse vocale',
          'Architecture feature-first (Domain / Data / Presentation) avec Riverpod',
          'Sécurité : RLS Supabase strict et stockage local chiffré',
        ],
        detailedDescription:
            'Magic Mirror est un miroir intelligent modulaire développé en Flutter. Il combine un rendu caméra plein écran, la météo et l\'agenda de la journée pour proposer des tenues adaptées à la morphologie de l\'utilisateur et à sa garde-robe. L\'application suit une architecture feature-first stricte avec Riverpod, synchronise profil et agenda via Supabase, et traite la détection de pose localement avec Google ML Kit. Elle fonctionne sur Android, iOS et macOS (support partiel sur Linux et Windows) et dispose d\'une suite de plus de 20 tests unitaires et de widgets. Le projet est actuellement en phase de maintenance.',
      ),
      Project(
        name: 'mlOutfitSuggestion',
        category: 'Backend',
        description:
            'API de recommandation de tenues pour MagicMirror : moteur hybride (ontologie OWL, RAG ChromaDB, Random Forest) selon profil, météo et agenda',
        language: 'Python',
        stars: 0,
        url: 'https://github.com/josoavj/mlOutfitSuggestion',
        technologies: [
          'Python',
          'FastAPI',
          'scikit-learn',
          'ChromaDB',
          'Owlready2 (OWL)',
          'SQLite',
          'Docker',
          'GitHub Actions',
        ],
        features: [
          'Pipeline en 4 étapes : filtres, validation sémantique RAG, scoring ML, diversité MMR',
          'Ontologie OWL pour l\'harmonie des couleurs et la formalité',
          'Identification faciale pour charger le profil utilisateur',
          'Contexte réel : météo OpenWeather et agenda du jour',
          'Collecte de feedback et réentraînement sur données réelles',
          'API sécurisée : clé X-API-Key, protection Path Traversal, limite d\'upload',
          'Stockage JSON ou SQLite (WAL) et CI avec tests Pytest',
          'Interface web de test et dashboard de métriques',
        ],
        detailedDescription:
            'mlOutfitSuggestion est le moteur de recommandation de tenues de MagicMirror, exposé via une API FastAPI. Un pipeline en quatre étapes transforme la garde-robe de l\'utilisateur en tenues cohérentes : filtres durs (chaleur, formalité, genre), validation sémantique par RAG ChromaDB et ontologie OWL, scoring par un modèle Random Forest, puis diversité MMR pour éviter les répétitions. Le système tient compte du sexe, de l\'âge, de la taille, de la morphologie, des préférences vestimentaires, de la météo et du planning du jour, et peut identifier l\'utilisateur par caméra. Il inclut une collecte de feedback pour réentraîner le modèle sur des données réelles, une API protégée et une CI automatisée.',
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
        description: 'Portfolio multiplateforme développé en Flutter',
        language: 'Dart',
        stars: 9,
        url: 'https://github.com/josoavj/myportfolio',
        releaseUrl: 'https://github.com/josoavj/myportfolio/releases',
        technologies: [
          'Flutter',
          'Dart',
          'Riverpod',
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
            'Portfolio personnel multiplateforme développé en Flutter qui affiche dynamiquement les projets et les statistiques GitHub. Utilise l\'API GitHub pour récupérer les données en temps réel, offrant une présentation moderne et interactive de mes réalisations. Accessible sur tous les appareils avec une interface cohérente et professionnelle.',
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
        Skill(name: 'Dart', color: Colors.blue),
        Skill(name: 'JavaScript', color: Colors.yellow),
        Skill(name: 'Python', color: Colors.yellow),
      ],
      'Frameworks': [
        Skill(name: 'Flutter', color: Colors.blue),
        Skill(name: 'Node.js', color: Colors.green),
        Skill(name: 'Express.js', color: Colors.grey),
        Skill(name: 'React', color: Colors.cyan),
      ],
      'Bases de Données': [
        Skill(name: 'MySQL', color: Colors.blue),
        Skill(name: 'Elasticsearch', color: Colors.teal),
        Skill(name: 'Hive', color: Colors.green),
      ],
      'DevOps & Outils': [
        Skill(name: 'Linux', color: Colors.orange),
        Skill(name: 'Git', color: Colors.orange),
        Skill(name: 'Nginx', color: Colors.green),
        Skill(name: 'Bash', color: Colors.grey),
        Skill(name: 'VS Code', color: Colors.blue),
        Skill(name: 'Android Studio', color: Colors.green),
        Skill(name: 'PyCharm', color: Colors.blue),
        Skill(name: 'WebStorm', color: Colors.blue),
      ],
      'Sécurité & Networking': [
        Skill(name: 'Cybersécurité', color: Colors.red),
        Skill(name: 'Networking', color: Colors.indigo),
        Skill(name: 'Kali Linux', color: Colors.red),
        Skill(name: 'Firewall Config', color: Colors.red),
      ],
    };
  }
}
