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
          'Développement de lvlmindapp (18+ stars sur GitHub)',
          'Contribution aux projets open source de l\'équipe',
          'Configuration et optimisation de serveurs Linux',
        ],
        icon: Icons.business,
        color: Colors.blue,
      ),
      Experience(
        role: 'Développeur Back-End (Stage)',
        company: 'SFI Ankorondrano',
        period: '2023',
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
        period: '2021 - 2023',
        location: 'Madagascar',
        description: 'Développement de solutions back-end pour divers projets. '
            'Conception et implémentation de bases de données et APIs.',
        achievements: [
          'Prospectius (dbProspectius) - Base de données et API',
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
            'Spécialisation en architecture logicielle, sécurité des systèmes et technologies cloud.',
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
      // Projets du Stage SFI Ankorondrano (2023)
      Project(
        name: 'sfiDashMonitoring',
        description:
            'Plateforme de monitoring React JS avec Elasticsearch. Collecte et visualisation de données en temps réel - Projet SFI Ankorondrano',
        language: 'JavaScript',
        stars: 0,
        url: 'https://github.com/josoavj/sfiDashMonitoring',
      ),
      Project(
        name: 'elasticsearch-nodejs-server',
        description:
            'Serveur NodeJS/Express avec Elasticsearch pour filtrer et traiter les données Fortinet - Déploiement SFI Ankorondrano',
        language: 'JavaScript',
        stars: 14,
        url: 'https://github.com/josoavj/elasticsearch-nodejs-server',
      ),
      Project(
        name: 'elasticsearch-config',
        description:
            'Configuration et optimisation d\'Elasticsearch sur serveur Linux Ubuntu - Infrastructure SFI Ankorondrano',
        language: 'Shell',
        stars: 12,
        url: 'https://github.com/josoavj/elasticsearch-config',
      ),
      // Autres projets
      Project(
        name: 'lvlmindapp',
        description:
            'Application mobile basée sur Flutter pour la gestion de l\'apprentissage et du développement personnel',
        language: 'Dart',
        stars: 18,
        url: 'https://github.com/josoavj/lvlmindapp',
      ),
      Project(
        name: 'Casier-Judiciare-N3',
        description:
            'Logiciel de saisie pour le Casier Judiciaire N3 avec stockage sécurisé',
        language: 'Java',
        stars: 13,
        url: 'https://github.com/josoavj/Casier-Judiciare-N3',
      ),
      Project(
        name: 'dbPlanificator',
        description: 'Base de données MySQL pour logiciel de planification',
        language: 'Python',
        stars: 11,
        url: 'https://github.com/josoavj/dbPlanificator',
      ),
      Project(
        name: 'forLinuxUser',
        description:
            'Configurations et scripts pour utilisateurs Linux, networking et cybersécurité',
        language: 'Shell',
        stars: 0,
        url: 'https://github.com/josoavj/forLinuxUser',
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
        Skill(name: 'React', level: 0.7, color: Colors.cyan),
      ],
      'Bases de Données': [
        Skill(name: 'MySQL', level: 0.85, color: Colors.blue),
        Skill(name: 'Elasticsearch', level: 0.8, color: Colors.teal),
        Skill(name: 'MongoDB', level: 0.7, color: Colors.green),
      ],
      'DevOps & Outils': [
        Skill(name: 'Linux', level: 0.9, color: Colors.orange),
        Skill(name: 'Docker', level: 0.75, color: Colors.blue),
        Skill(name: 'Git', level: 0.9, color: Colors.orange),
        Skill(name: 'Nginx', level: 0.7, color: Colors.green),
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
      {'name': 'Firebase', 'icon': '🔥', 'color': Colors.amber},
      // Bases de Données
      {'name': 'MySQL', 'icon': '🗄️', 'color': Colors.blue},
      {'name': 'Elasticsearch', 'icon': '🔍', 'color': Colors.teal},
      {'name': 'MongoDB', 'icon': '🍃', 'color': Colors.green},
      // DevOps & Outils
      {'name': 'Linux', 'icon': '🐧', 'color': Colors.orange},
      {'name': 'Docker', 'icon': '🐳', 'color': Colors.blue},
      {'name': 'Git', 'icon': '📦', 'color': Colors.orange},
      {'name': 'Nginx', 'icon': '🌐', 'color': Colors.green},
      {'name': 'Kibana', 'icon': '📊', 'color': Colors.yellow},
      {'name': 'Grafana', 'icon': '📈', 'color': Colors.orange},
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
