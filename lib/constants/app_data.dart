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
            'Développement d\'applications web et mobile. Contribution aux projets open source. '
            'Travail sur des solutions de sécurité et networking.',
        achievements: [
          'Prospectius - Plateforme CRM complète de gestion de prospects et clients',
          'Planificator - Système de planification avec base de données MySQL',
          'Segma - Logiciel de segmentation d\'images utilisant le modèle SAM',
          'Contribution aux projets open source de l\'équipe',
          'Configuration et optimisation de serveurs Linux',
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
            'et configuration avancée pour le traitement des données Fortinet.',
        achievements: [
          'Plateforme sfiDashMonitoring - Dashboard React avec Elasticsearch',
          'Serveur elasticsearch-nodejs-server pour filtrer données Fortinet (14+ stars)',
          'Configuration complète d\'Elasticsearch sur Ubuntu Server (12+ stars)',
          'Déploiement et configuration de Kibana et Grafana',
          'Optimisation des performances et de la collecte de données',
        ],
        icon: Icons.code,
        color: Colors.orange,
      ),
      Experience(
        role: 'Développeur Back-End',
        company: 'Projets Universitaires & Freelance',
        period: '2021 - 2024',
        location: 'Madagascar',
        description: 'Développement de solutions back-end pour divers projets. '
            'Conception et implémentation de bases de données et APIs.',
        achievements: [
          'Développement de lvlmindapp (18+ stars sur GitHub) - Frontend Only',
          'Prospectius (dbProspectius) - Base de données CRM complète',
          'Planificator (dbPlanificator) - Système de planification',
          'Application Casier Judiciaire N3 (13+ stars sur GitHub)',
          'Elasticsearch NodeJS Server pour données Fortinet (14+ stars)',
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
            'Formation complète en développement logiciel, bases de données, networking et télécommunications. '
            'Projet de fin d\'études : Application mobile lvlmindapp développée avec Flutter.',
        icon: Icons.school,
        color: Colors.green,
        status: 'Obtenu',
      ),
      Education(
        degree: 'Formations Techniques Complémentaires',
        school: 'Auto-formation & Projets Pratiques',
        period: '2021 - Présent',
        location: 'En ligne & Terrain',
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
        stars: 18,
        url: 'https://github.com/josoavj/lvlmindapp',
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
        stars: 0,
        url: 'https://github.com/josoavj/segma',
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
        name: 'Casier-Judiciaire-N3',
        description:
            'Logiciel de saisie sécurisé pour le Casier Judiciaire National N3',
        language: 'Java',
        stars: 13,
        url: 'https://github.com/josoavj/Casier-Judiciare-N3',
        technologies: ['Java', 'MySQL', 'Swing/AWT', 'JDBC', 'Maven', 'JPA'],
        features: [
          'Application desktop avec interface Swing complète',
          'Gestion des bulletins du Casier Judiciaire',
          'Saisie sécurisée des informations personnelles',
          'Gestion des données sensibles',
          'Requêtes CRUD optimisées',
          'Architecture Maven pour gestion des dépendances',
        ],
        detailedDescription:
            'Logiciel desktop professionnel pour le Casier Judiciaire N3, conçu pour faciliter la saisie et la gestion des informations des personnes lors des demandes de bulletin. Développé en Java avec interface Swing/AWT, il offre une solution robuste avec MySQL comme base de données. Architecture complète avec Maven et JPA pour l\'accès aux données.',
      ),
      Project(
        name: 'sfiDashMonitoring',
        description:
            'Plateforme de monitoring en temps réel avec React et Elasticsearch',
        language: 'JavaScript',
        stars: 1,
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
        name: 'dbPlanificator',
        description:
            'Base de données MySQL et scripts Python pour système de planification',
        language: 'Python',
        stars: 11,
        url: 'https://github.com/josoavj/dbPlanificator',
        technologies: [
          'MySQL',
          'Python',
          'mysql-connector-python',
          'Bcrypt',
          'Scripts SQL'
        ],
        features: [
          'Schéma MySQL complet pour planification',
          'Scripts Python CRUD pour gestion des données',
          'Gestion des contrats et clients',
          'Suivi des plannings et traitements',
          'Gestion des factures et historique',
          'Hachage sécurisé des mots de passe avec Bcrypt',
        ],
        detailedDescription:
            'Système complet de base de données MySQL couplé avec des scripts Python pour la gestion de planification. Inclut des requêtes CRUD optimisées, gestion des contrats, plannings, factures et suivi des opérations. Développé avec Python pour l\'accès aux données et Bcrypt pour la sécurité. Prend en charge les recherches avancées et le regroupement par catégories.',
      ),
      Project(
        name: 'ProspectiusFinal',
        description: 'Plateforme CRM pour la gestion des prospects et clients',
        language: 'Dart',
        stars: 1,
        url: 'https://github.com/josoavj/ProspectiusFinal',
        technologies: [
          'Flutter',
          'Dart',
          'Provider',
          'MySQL',
          'Exploration avancée',
          'Windows/Linux'
        ],
        features: [
          'Création, modification et suppression de prospects',
          'Exploration multi-critères en temps réel',
          'Filtrage par catégorie et plage de dates',
          'Tri personnalisé (récents, alphabétique, statut)',
          'Gestion des interactions (appels, emails, réunions)',
          'Génération de rapports Excel et PDF',
        ],
        detailedDescription:
            'Plateforme CRM multiplateforme développée pour la gestion complète des prospects et clients. Utilise Flutter pour le frontend multi-plateforme (Windows, Linux), Provider pour la gestion d\'état, et MySQL pour la persistance. Offre une exploration avancée avec filtrage multi-critères, suivi des interactions détaillé et génération de rapports professionnels.',
      ),
      Project(
        name: 'forLinuxUser',
        description:
            'Dépôt de configurations, tutoriels et scripts pour utilisateurs Linux',
        language: 'Shell',
        stars: 12,
        url: 'https://github.com/josoavj/forLinuxUser',
        technologies: ['Bash', 'Shell Script', 'Linux', 'Markdown', 'Git'],
        features: [
          'Tutoriels complets sur Cybersécurité, Networking et Databases',
          'Scripts et configurations pour Arch Linux et dérivés (Garuda)',
          'Guides de résolution de problèmes courants',
          'Configurations personnalisées d\'environnement',
          'Documentation technique complète en Markdown',
          'Partage de connaissances générales sur Linux',
        ],
        detailedDescription:
            'Dépôt collaboratif contenant des configurations, tutoriels et scripts pour utilisateurs Linux avancés. Organisé par catégories : cybersécurité, networking, bases de données, outils système. Incluant des guides spécifiques pour Arch Linux et dérivés, résolution de problèmes courants et partage de connaissances. Ressource idéale pour administrateurs système et passionnés Linux.',
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
