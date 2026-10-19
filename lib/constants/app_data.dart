import 'package:flutter/material.dart';
import 'package:myportfolio/models/project.dart';
import 'package:myportfolio/models/skill.dart';
import 'package:myportfolio/models/timeline_entry.dart';

class AppData {
  /// Parcours professionnel : stage et side projects (arbre « Professionnel »).
  static List<TimelineEntry> getProfessionalTimeline() {
    return [
      const TimelineEntry(
        title: 'Développeur Full Stack',
        organization: 'APEXNova Labs',
        location: 'Antananarivo, Madagascar',
        period: '2023 - Présent',
        badge: 'Side project',
        status: 'En cours',
        isOngoing: true,
        icon: Icons.rocket_launch_outlined,
        summary:
            'Side project mené en parallèle de mes études, en dehors de tout cadre salarié : développement de plateformes ERP et CRM, et d\'autres plateformes''Digitaliser et centraliser la gestion d\'entreprise (comme la facturation et planification de tâches)'
            ' et optimiser le suivi de la relation client grâce à des interfaces intuitives et performantes. '
            '\n J\'accorde également une place importante à la création d\'applications utilitaires et aux contributions Open Source.',
        highlights: [
          'Prospectius : plateforme CRM complète de gestion de prospects et clients',
          'lanificator : Solution logicielle sur mesure pour l\'organisation des plannings d\'intervention et le suivi de facturation dans le secteur de l\'hygiène et de l\'assainissement.',
          'Segma : logiciel de segmentation d\'images utilisant le modèle SAM de Meta',
          'Contributions actives aux projets Open Source de l\'équipe',
          'Configuration et optimisation avancée de serveurs Linux',
        ],
        technologies: ['Flutter', 'Linux', 'SAM', 'Python'],
        relatedProjects: ['Prospectius', 'Planificator', 'segma'],
      ),
      const TimelineEntry(
        title: 'Développeur Back-End',
        organization: 'SFI Ankorondrano',
        location: 'Ankorondrano, Antananarivo',
        period: '2024',
        duration: '3 mois',
        badge: 'Stage',
        status: 'Terminé',
        icon: Icons.business_center_outlined,
        summary:
            'Stage de développement d\'un système complet de monitoring et collecte de données de journaux Fortinet. '
            'Mise en place de l\'infrastructure Elasticsearch, développement de serveurs NodeJS/Express, '
            'et configuration avancée pour le traitement des données Fortinet avec architecture asynchrone.',
        highlights: [
          'elasticsearch-config : configuration et optimisation d\'Elasticsearch',
          'sfiDashMonitoring : dashboard React lié à avec Elasticsearch pour une visualisation des données du traffic réseau en temps réel',
          'elasticsearch-nodejs-server : serveur pour accéder aux données des journaux Fortinet avec Elasticsearch',
          'Intégration de Filebeat et Kibana pour un monitoring complet',
          'Configuration d\'Elasticsearch et Grafana pour une visualisation des données reçus par Elasticsearch',
          'API REST robuste avec authentification JWT',
          'Architecture socket.io pour la communication temps réel',
          'Optimisation des performances de la collecte de données',
        ],
        technologies: [
          'Elasticsearch',
          'Kibana',
          'Filebeat',
          'Grafana',
          'Node.js',
          'Express',
          'React',
          'JWT',
          'Socket.IO',
          'Fortinet',
        ],
        relatedProjects: ['sfiDashMonitoring', 'elasticsearch-nodejs-server', 'elasticsearch-config'],
      ),
      const TimelineEntry(
        title: 'Développeur Full Stack',
        organization: 'Projets Universitaires et Side Projects',
        location: 'Madagascar',
        period: '2021 - 2026',
        badge: 'Projets',
        status: 'Terminé',
        icon: Icons.storage_outlined,
        summary:
            'Développement de solutions complètes full stack incluant applications mobiles, '
            'applications desktop, APIs et bases de données. '
            'Conception et implémentation d\'architectures robustes avec des technologies modernes.',
        highlights: [
          'Levelmind : application e-learning mobile Flutter.',
          'myportfolio : portfolio developpé avec Flutter, intégré à l\'API GitHub.',
          'magicmirror : Miroir intelligent pour la suggestion de tenues basé sur le profil utilisateur, ainsi que la météo.'
          'mloutfitSuggestion : Moteur de recommandation vestimentaire basé sur un modèle Random Forest et un pipeline RAG.',
          'orientIA : Plateforme d\'assistant virtuel d\'orientation pédagogique.'
          'mAIntenanceAssistance : Plateforme de maintenance et d\'assistance intelligente',
          'Contribution à 43 projets open source sur GitHub',
          'Participation à des TP avancés d\'algorithmique et de machine learning',
        ],
        technologies: ['Flutter', 'Python', 'RAG', 'ML', 'Ontology'],
        relatedProjects: ['Levelmind', 'myportfolio', 'MagicMirror', 'mloutfitsuggestion'],
      ),
    ];
  }

  /// Parcours académique (arbre « Académique »).
  static List<TimelineEntry> getAcademicTimeline() {
    return [
      const TimelineEntry(
        title: 'Master 2 en Informatique et Télécommunication',
        organization: 'ISPM',
        location: 'Antananarivo, Madagascar',
        period: '2024 - En cours',
        badge: 'Master',
        status: 'En cours',
        isOngoing: true,
        icon: Icons.school_outlined,
        summary:
            'Diplôme en Informatique et Télécommunication en cours de préparation à l\'Institut Supérieur Polytechnique de Madagascar.',
        highlights: [
          'Diplôme de Master 2 en Informatique et Télécommunication (en cours)',
          'Spécialisation en architecture logicielle, sécurité des systèmes, Machine Learning et Ontologie',
          'Parcours ESIIA (Électronique, Systèmes Informatiques, Informatique et Intelligence Artificielle)',
        ],
      ),
      const TimelineEntry(
        title: 'Master 1 en Informatique et Télécommunication',
        organization: 'ISPM',
        location: 'Antananarivo, Madagascar',
        period: '2023 - 2024',
        badge: 'Master',
        status: 'Terminé',
        icon: Icons.school_outlined,
        summary:
            'Approfondissement en développement logiciel, réseaux et cybersécurité. '
            'Gestion des bases de données relationnelles, introduction au Machine Learning et optimisation des systèmes.',
      ),
      const TimelineEntry(
        title: 'Licence en Informatique et Télécommunication',
        organization: 'ISPM',
        location: 'Antananarivo, Madagascar',
        period: '2020 - 2023',
        badge: 'Licence',
        status: 'Obtenu',
        icon: Icons.workspace_premium_outlined,
        summary:
            'Formation en développement Web, le POO, les algorithmes et bases de données relationnels comme MySQL.',
        thesisTitle:
            'PLATEFORME DE MONITORING DE BANDE PASSANTE ET SERVEUR DE TRAITEMENT DE JOURNAUX FORTIGATE',
        relatedProjects: ['sfiDashMonitoring', 'elasticsearch-config'],
      ),
      const TimelineEntry(
        title: 'Auto-formation technique',
        organization: 'Autodidacte · projets pratiques',
        location: 'En ligne',
        period: '2021 - Présent',
        badge: 'Autodidacte',
        status: 'En continu',
        isOngoing: true,
        icon: Icons.menu_book_outlined,
        summary:
        'Apprentissage autodidacte du développement d\'applications (Flutter), de Python, '
            'd\'Elasticsearch, Kibana et Grafana, de l\'administration Linux et du développement '
            'd\'APIs avec Node.js et Express.js, avec une petite base en cybersécurité.',
        technologies: [
          'Flutter',
          'Python',
          'Elasticsearch',
          'Kibana',
          'Grafana',
          'Linux',
          'Node.js',
          'Express.js',
          'Cybersécurité (bases)',
        ],
        relatedProjects: [
          'Levelmind',
          'elasticsearch-config',
          'elasticsearch-nodejs-server',
          'mlOutfitSuggestion',
        ],
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
        tagline: 'Application mobile d\'e-learning pour les écoles et universités',
        status: 'Bêta (v1.0.0-beta.1)',
        problem:
            'Centraliser les ressources pédagogiques, les emplois du temps et la communication entre étudiants et enseignants dans une seule application mobile fluide, sécurisée et capable de grandir.',
        solution:
            'Une application Flutter avec authentification locale, gestion de profil, partage de cours organisé par matière, emploi du temps avec notifications et stockage Hive intégré.',
        architecture:
            'Trois couches : présentation (pages et widgets), métier (providers et services : UserNotifier, ThemeNotifier, EnhancedAuthService) et données (LocalDbService, base Hive, modèle UserProfile). Patterns utilisés : MVVM avec Provider, service locator (singleton), observer et repository.',
        challenges: [
          const ProjectChallenge(
            challenge: 'Authentification et session sans serveur',
            solution:
                'Inscription et connexion avec mot de passe haché (SHA-256), session conservée dans une box Hive et récupérée automatiquement au lancement, données supprimées à la déconnexion.',
          ),
         const ProjectChallenge(
            challenge: 'Garder le code évolutif',
            solution:
                'Séparation en trois couches, avec LocalDbService comme repository : l\'accès aux données reste isolé du reste de l\'application.',
          ),
        ],
        results: [
          const ProjectMetric(label: 'Version', value: 'v1.0.0-beta.1'),
        ],
        roadmap: [
          'Annonces et actualités',
          'Messagerie entre utilisateurs',
          'Suivi de progression académique',
          'Système d\'évaluation',
          'Notifications push',
        ],
        stackByLayer: {
          'Application': ['Flutter', 'Dart', 'Provider'],
          'Données': ['Hive'],
          'Sécurité': ['SHA-256'],
        },
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
        tagline: 'Plateforme de monitoring des données Fortigate depuis Elasticsearch',
        status: 'Prêt pour la production',
        origin: 'Stage SFI Ankorondrano · Mémoire de Licence',
        problem:
            'Suivre en temps réel la bande passante et les journaux d\'un pare-feu Fortigate à partir des données stockées dans Elasticsearch.',
        solution:
            'Un dashboard React alimenté par un backend Node.js/Express qui interroge Elasticsearch et pousse les mises à jour en temps réel via Socket.io, avec une authentification renforcée.',
        architecture:
            'Frontend React 19 (Vite, Material-UI), backend Node.js + Express 5, données dans Elasticsearch 8 et temps réel via Socket.io. Deux modes de lancement : LOCAL (développement, accessible en localhost) et DEPLOYED (serveur Ubuntu sans interface graphique, accessible depuis le réseau).',
        challenges: [
          const ProjectChallenge(
            challenge: 'Sécuriser l\'authentification',
            solution:
                'Token d\'accès JWT de 15 minutes, refresh token en cookie HttpOnly avec rotation et hachage en base, CORS strict, en-têtes Helmet, limitation de débit (5 tentatives par 15 minutes sur l\'authentification) et protection CSRF.',
          ),
          const ProjectChallenge(
            challenge: 'Garder le service observable',
            solution:
                'Endpoint /metrics au format Prometheus : nombre de requêtes, latence par endpoint, requêtes en cours, mémoire heap et uptime.',
          ),
          const ProjectChallenge(
            challenge: 'Fiabiliser le code d\'authentification',
            solution:
                'Tests Vitest et React Testing Library sur le JWT, le hachage des mots de passe, l\'expiration et la rotation des tokens.',
          ),
        ],
        results: [
          const ProjectMetric(label: 'Vulnérabilités npm', value: '0'),
        ],
        stackByLayer: {
          'Frontend': ['React 19', 'Vite', 'Material-UI'],
          'Backend': ['Node.js', 'Express 5', 'Socket.io', 'JWT'],
          'Données': ['Elasticsearch 8'],
          'Qualité & exploitation': ['Vitest', 'React Testing Library', 'ESLint', 'Prometheus'],
        },
        relatedProjects: ['elasticsearch-nodejs-server', 'elasticsearch-config'],
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
        tagline: 'Miroir intelligent qui suggère des tenues selon la météo, l\'agenda et la morphologie',
        status: 'En maintenance (v1.1.0)',
        problem:
            'Aider à choisir sa tenue chaque matin en tenant compte de la météo, de l\'agenda de la journée, de la morphologie et de la garde-robe.',
        solution:
            'Un miroir connecté sous Flutter : rendu caméra plein écran, météo et agenda en direct, et suggestions de tenues issues d\'un ranking hybride (heuristique, ML et LLM).',
        architecture:
            'Architecture feature-first en couches, inspirée de la Clean Architecture : chaque fonctionnalité est isolée en domain (entités, services métier), data (modèles, services techniques) et presentation (providers, widgets, écrans). État géré avec Riverpod (providers séparés des widgets, FutureProvider et AsyncNotifier) et design system commun « glassmorphism ».',
        challenges: [
          const ProjectChallenge(
            challenge: 'Respecter la vie privée de l\'utilisateur',
            solution:
                'Détection de la morphologie traitée localement avec Google ML Kit, politiques RLS strictes côté Supabase et stockage local chiffré.',
          ),
          const ProjectChallenge(
            challenge: 'Produire des suggestions pertinentes',
            solution:
                'Ranking hybride combinant heuristique, modèle ML (LightGBM) et LLM, alimenté par la météo, l\'agenda et le profil.',
          ),
          const ProjectChallenge(
            challenge: 'Garder une base de code testable',
            solution:
                'Architecture feature-first avec providers Riverpod isolés, couverte par plus de 20 tests unitaires et de widgets.',
          ),
        ],
        results: [
          const ProjectMetric(label: 'Tests', value: '20+'),
          const ProjectMetric(label: 'Plateformes', value: 'Android, iOS, macOS'),
        ],
        stackByLayer: {
          'Application': ['Flutter', 'Dart', 'Riverpod'],
          'Données & cloud': ['Supabase'],
          'IA': ['Google ML Kit', 'LightGBM'],
          'Services': ['OpenWeatherMap', 'Flutter TTS'],
        },
        relatedProjects: ['mlOutfitSuggestion'],
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
        tagline: 'Moteur de recommandation de tenues de MagicMirror, exposé en API',
        problem:
            'Proposer des tenues cohérentes à partir de la garde-robe, du profil (sexe, âge, taille, morphologie, préférences), de la météo et du planning du jour.',
        solution:
            'Une API FastAPI qui enchaîne quatre étapes : filtres durs, validation sémantique (RAG ChromaDB et ontologie OWL), scoring par Random Forest, puis diversité MMR.',
        architecture:
            'Pipeline en quatre étapes derrière une API FastAPI : (1) filtres durs (chaleur, formalité, genre), (2) validation sémantique par RAG ChromaDB et ontologie OWL, (3) scoring par un modèle Random Forest, (4) diversité MMR pour éviter les répétitions. Stockage JSON ou SQLite, interface web de test et dashboard de métriques.',
        challenges: [
          const ProjectChallenge(
            challenge: 'Garantir des tenues cohérentes',
            solution:
                'Ontologie OWL pour l\'harmonie des couleurs et la formalité, associée à une validation sémantique par RAG.',
          ),
          const ProjectChallenge(
            challenge: 'Éviter les suggestions répétitives',
            solution: 'Diversité MMR appliquée aux tenues les mieux notées.',
          ),
          const ProjectChallenge(
            challenge: 'Améliorer le modèle dans le temps',
            solution: 'Collecte de feedback et réentraînement sur des données réelles.',
          ),
          const ProjectChallenge(
            challenge: 'Protéger l\'API',
            solution:
                'Clé X-API-Key, protection contre le Path Traversal et limite de taille des uploads.',
          ),
        ],
        results: [
          const ProjectMetric(label: 'Étapes du pipeline', value: '4'),
        ],
        stackByLayer: {
          'API': ['Python', 'FastAPI'],
          'IA': ['scikit-learn (Random Forest)', 'ChromaDB', 'Owlready2 (OWL)'],
          'Données': ['JSON', 'SQLite'],
          'Qualité & exploitation': ['Pytest', 'Docker', 'GitHub Actions'],
        },
        relatedProjects: ['MagicMirror'],
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
      'Langages': const [
        Skill(name: 'Dart', color: Colors.blue),
        Skill(name: 'JavaScript', color: Colors.yellow),
        Skill(name: 'Python', color: Colors.yellow),
      ],
      'Frameworks': const [
        Skill(name: 'Flutter', color: Colors.blue),
        Skill(name: 'Node.js', color: Colors.green),
        Skill(name: 'Express.js', color: Colors.grey),
        Skill(name: 'React', color: Colors.cyan),
      ],
      'Bases de Données': const [
        Skill(name: 'MySQL', color: Colors.blue),
        Skill(name: 'Elasticsearch', color: Colors.teal),
        Skill(name: 'Hive', color: Colors.green),
      ],
      'DevOps & Outils': const [
        Skill(name: 'Linux', color: Colors.orange),
        Skill(name: 'Git', color: Colors.orange),
        Skill(name: 'Nginx', color: Colors.green),
        Skill(name: 'Bash', color: Colors.grey),
        Skill(name: 'VS Code', color: Colors.blue),
        Skill(name: 'Android Studio', color: Colors.green),
        Skill(name: 'PyCharm', color: Colors.blue),
        Skill(name: 'WebStorm', color: Colors.blue),
      ],
      'Sécurité & Networking': const [
        Skill(name: 'Cybersécurité', color: Colors.red),
        Skill(name: 'Networking', color: Colors.indigo),
        Skill(name: 'Kali Linux', color: Colors.red),
        Skill(name: 'Firewall Config', color: Colors.red),
      ],
    };
  }
}
