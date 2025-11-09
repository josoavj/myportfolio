import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Josoa Vonjiniaina - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        fontFamily: 'Roboto',
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({Key? key}) : super(key: key);

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildHeader(context),
              _buildAbout(context),
              _buildExperience(context),
              _buildEducation(context),
              _buildSkills(context),
              _buildProjects(context),
              _buildContact(context),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0D1117),
            const Color(0xFF161B22),
            Colors.blue.shade900.withOpacity(0.3),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(isSmall ? 15.0 : 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isSmall ? 120 : 150,
                height: isSmall ? 120 : 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF161B22),
                  child: Icon(
                    Icons.person,
                    size: isSmall ? 60 : 80,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Josoa Vonjiniaina',
                style: TextStyle(
                  fontSize: isSmall ? 32 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Full Stack Developer | Linux & Security Enthusiast',
                style: TextStyle(
                  fontSize: isSmall ? 16 : 20,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.grey[400], size: 20),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      'Antananarivo, Madagascar',
                      style: TextStyle(color: Colors.grey[400]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.code,
                    label: 'GitHub',
                    url: 'https://github.com/josoavj',
                  ),
                  _buildSocialButton(
                    icon: Icons.work,
                    label: 'LinkedIn',
                    url: 'https://www.linkedin.com/in/josoavonjiniaina',
                  ),
                  _buildSocialButton(
                    icon: Icons.facebook,
                    label: 'Facebook',
                    url: 'https://www.facebook.com/josoa.vonjiniaina.17',
                  ),
                  _buildSocialButton(
                    icon: Icons.alternate_email,
                    label: 'Twitter',
                    url: 'https://twitter.com/j_Josoa',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return ElevatedButton.icon(
      onPressed: () => _launchURL(url),
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          children: [
            const Text(
              'À propos de moi',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Développeur passionné par Linux, le networking et la cybersécurité. '
                  'Je travaille sur des projets variés allant du développement mobile avec Flutter '
                  'aux configurations de serveurs et bases de données. Membre de l\'équipe APEXNova Labs, '
                  'je contribue à des projets open source et explore continuellement de nouvelles technologies.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[300],
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, color: Colors.amber, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        'Top 15 Développeur GitHub Madagascar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Classement basé sur les contributions publiques',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperience(BuildContext context) {
    final experiences = [
      {
        'role': 'Développeur Full Stack',
        'company': 'APEXNova Labs',
        'period': '2023 - Présent',
        'location': 'Antananarivo, Madagascar',
        'description':
        'Développement d\'applications web et mobile. Contribution aux projets open source. '
            'Travail sur des solutions de sécurité et networking.',
        'achievements': [
          'Développement de lvlmindapp (18+ stars sur GitHub)',
          'Contribution aux projets open source de l\'équipe',
          'Configuration et optimisation de serveurs Linux',
        ],
        'icon': Icons.business,
        'color': Colors.blue,
      },
      {
        'role': 'Développeur Back-End (Stage)',
        'company': 'SFI Ankorondrano',
        'period': '2023',
        'location': 'Ankorondrano, Antananarivo',
        'description':
        'Participation au développement d\'un système de monitoring. '
            'Mise en place complète de l\'infrastructure de collecte et visualisation de données.',
        'achievements': [
          'Déploiement et configuration du serveur Elasticsearch',
          'Configuration de Kibana pour l\'analyse de données',
          'Création de dashboards personnalisés dans Grafana',
          'Optimisation des performances de la base de données',
        ],
        'icon': Icons.code,
        'color': Colors.orange,
      },
      {
        'role': 'Développeur Back-End',
        'company': 'Projets Universitaires & Freelance',
        'period': '2021 - 2023',
        'location': 'Madagascar',
        'description':
        'Développement de solutions back-end pour divers projets. '
            'Conception et implémentation de bases de données et APIs.',
        'achievements': [
          'Prospectius (dbProspectius) - Base de données et API',
          'Planificator (dbPlanificator) - Système de planification',
          'Application Casier Judiciaire N3 (13+ stars sur GitHub)',
          'Elasticsearch NodeJS Server pour données Fortinet (14+ stars)',
        ],
        'icon': Icons.storage,
        'color': Colors.green,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      color: const Color(0xFF161B22),
      child: Column(
        children: [
          const Text(
            '💼 Expérience Professionnelle',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final exp = entry.value;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 600 + (index * 200)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: _buildExperienceCard(exp),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: (exp['color'] as Color).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: (exp['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  exp['icon'] as IconData,
                  color: exp['color'] as Color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp['role'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.business, size: 16, color: Colors.grey[500]),
                        const SizedBox(width: 5),
                        Text(
                          exp['company'],
                          style: TextStyle(
                            fontSize: 16,
                            color: exp['color'] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 5),
                        Text(
                          exp['period'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 5),
                        Text(
                          exp['location'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            exp['description'],
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[300],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Réalisations clés :',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 10),
          ...(exp['achievements'] as List<String>).map((achievement) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: exp['color'] as Color,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      achievement,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEducation(BuildContext context) {
    final education = [
      {
        'degree': 'Master 2 en Informatique et Télécommunication',
        'school': 'ISPM (Institut Supérieur Polytechnique de Madagascar)',
        'period': '2024 - En cours',
        'location': 'Antananarivo, Madagascar',
        'description':
        'Formation avancée en systèmes d\'information, réseaux et télécommunications. '
            'Spécialisation en architecture logicielle, sécurité des systèmes et technologies cloud.',
        'icon': Icons.school,
        'color': Colors.blue,
        'status': 'En cours',
      },
      {
        'degree': 'Master 1 en Informatique et Télécommunication',
        'school': 'ISPM (Institut Supérieur Polytechnique de Madagascar)',
        'period': '2023 - 2024',
        'location': 'Antananarivo, Madagascar',
        'description':
        'Approfondissement des connaissances en développement logiciel, réseaux, bases de données avancées et cybersécurité.',
        'icon': Icons.school,
        'color': Colors.purple,
        'status': 'Terminé',
      },
      {
        'degree': 'Licence en Informatique et Télécommunication',
        'school': 'ISPM (Institut Supérieur Polytechnique de Madagascar)',
        'period': '2020 - 2023',
        'location': 'Antananarivo, Madagascar',
        'description':
        'Formation complète en développement logiciel, bases de données, networking et télécommunications. '
            'Projet de fin d\'études : Application mobile lvlmindapp développée avec Flutter.',
        'icon': Icons.school,
        'color': Colors.green,
        'status': 'Obtenu',
      },
      {
        'degree': 'Formations Techniques Complémentaires',
        'school': 'Auto-formation & Projets Pratiques',
        'period': '2021 - Présent',
        'location': 'En ligne & Terrain',
        'description':
        'Formations spécialisées en Elasticsearch, Kibana, Grafana, Docker, Linux Administration, '
            'sécurité réseau et développement d\'APIs avec Node.js/Express.',
        'icon': Icons.card_membership,
        'color': Colors.orange,
        'status': 'Continue',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          const Text(
            '🎓 Formation Académique',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: education.asMap().entries.map((entry) {
                final index = entry.key;
                final edu = entry.value;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 600 + (index * 200)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: _buildEducationCard(edu),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(Map<String, dynamic> edu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: (edu['color'] as Color).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: (edu['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              edu['icon'] as IconData,
              color: edu['color'] as Color,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        edu['degree'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: (edu['color'] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: edu['color'] as Color,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        edu['status'],
                        style: TextStyle(
                          fontSize: 12,
                          color: edu['color'] as Color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  edu['school'],
                  style: TextStyle(
                    fontSize: 16,
                    color: edu['color'] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 5),
                    Text(
                      edu['period'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        edu['location'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  edu['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      color: const Color(0xFF161B22),
      child: Column(
        children: [
          const Text(
            '🛠️ Stack Technique & Compétences',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 60),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                _buildSkillCategory(
                  '💻 Langages de Programmation',
                  [
                    {'name': 'Dart', 'level': 0.9, 'color': Colors.blue},
                    {'name': 'JavaScript', 'level': 0.85, 'color': Colors.yellow},
                    {'name': 'Python', 'level': 0.8, 'color': Colors.green},
                    {'name': 'Java', 'level': 0.75, 'color': Colors.red},
                    {'name': 'Shell', 'level': 0.85, 'color': Colors.grey},
                  ],
                ),
                const SizedBox(height: 50),
                _buildSkillCategory(
                  '🎨 Frameworks & Technologies',
                  [
                    {'name': 'Flutter', 'level': 0.9, 'color': Colors.blue},
                    {'name': 'Node.js', 'level': 0.85, 'color': Colors.green},
                    {'name': 'Express.js', 'level': 0.8, 'color': Colors.grey},
                    {'name': 'React', 'level': 0.7, 'color': Colors.cyan},
                  ],
                ),
                const SizedBox(height: 50),
                _buildSkillCategory(
                  '🗄️ Bases de Données',
                  [
                    {'name': 'MySQL', 'level': 0.85, 'color': Colors.blue},
                    {'name': 'Elasticsearch', 'level': 0.8, 'color': Colors.teal},
                    {'name': 'MongoDB', 'level': 0.7, 'color': Colors.green},
                  ],
                ),
                const SizedBox(height: 50),
                _buildSkillCategory(
                  '🔧 DevOps & Outils',
                  [
                    {'name': 'Linux', 'level': 0.9, 'color': Colors.orange},
                    {'name': 'Docker', 'level': 0.75, 'color': Colors.blue},
                    {'name': 'Git', 'level': 0.9, 'color': Colors.orange},
                    {'name': 'Nginx', 'level': 0.7, 'color': Colors.green},
                  ],
                ),
                const SizedBox(height: 50),
                _buildSkillCategory(
                  '🔐 Sécurité & Networking',
                  [
                    {'name': 'Cybersécurité', 'level': 0.85, 'color': Colors.red},
                    {'name': 'Networking', 'level': 0.8, 'color': Colors.indigo},
                    {'name': 'Fortinet', 'level': 0.75, 'color': Colors.deepOrange},
                    {'name': 'Firewall Config', 'level': 0.8, 'color': Colors.purple},
                  ],
                ),
                const SizedBox(height: 60),
                _buildStatsCards(),
                const SizedBox(height: 60),
                _buildTechBadges(),
                const SizedBox(height: 60),
                _buildContributionGraph(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechBadges() {
    final badges = [
      {'name': 'Flutter', 'icon': '📱', 'color': Colors.blue},
      {'name': 'Dart', 'icon': '🎯', 'color': Colors.blue},
      {'name': 'Linux', 'icon': '🐧', 'color': Colors.orange},
      {'name': 'Node.js', 'icon': '🟢', 'color': Colors.green},
      {'name': 'Python', 'icon': '🐍', 'color': Colors.yellow},
      {'name': 'Java', 'icon': '☕', 'color': Colors.red},
      {'name': 'MySQL', 'icon': '🗄️', 'color': Colors.blue},
      {'name': 'Elasticsearch', 'icon': '🔍', 'color': Colors.teal},
      {'name': 'Git', 'icon': '📦', 'color': Colors.orange},
      {'name': 'Docker', 'icon': '🐳', 'color': Colors.blue},
      {'name': 'Security', 'icon': '🔐', 'color': Colors.red},
      {'name': 'Networking', 'icon': '🌐', 'color': Colors.indigo},
      {'name': 'MongoDB', 'icon': '🍃', 'color': Colors.green},
      {'name': 'React', 'icon': '⚛️', 'color': Colors.cyan},
      {'name': 'Firebase', 'icon': '🔥', 'color': Colors.amber},
      {'name': 'VS Code', 'icon': '💻', 'color': Colors.blue},
    ];

    return Column(
      children: [
        const Text(
          '🎯 Technologies & Outils',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: badges.asMap().entries.map((entry) {
            final index = entry.key;
            final badge = entry.value;
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 300 + (index * 50)),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: _buildBadge(
                    badge['name'] as String,
                    badge['icon'] as String,
                    badge['color'] as Color,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBadge(String name, String icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributionGraph() {
    return Column(
      children: [
        const Text(
          '📊 Activité de Contribution',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Simulation de graphique type GitHub',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 30),
        _buildContributionHeatmap(),
        const SizedBox(height: 20),
        _buildContributionLegend(),
      ],
    );
  }

  Widget _buildContributionHeatmap() {
    // Génération de données aléatoires pour simulation
    final random = [
      [0, 1, 2, 1, 3, 2, 0],
      [2, 3, 1, 2, 4, 3, 1],
      [1, 2, 3, 4, 3, 2, 1],
      [3, 4, 2, 3, 2, 1, 2],
      [2, 1, 3, 2, 4, 3, 2],
      [4, 3, 2, 1, 2, 3, 1],
      [1, 2, 1, 3, 2, 1, 0],
      [2, 3, 4, 3, 2, 1, 2],
      [3, 2, 1, 2, 3, 4, 3],
      [1, 2, 3, 2, 1, 2, 3],
      [2, 4, 3, 2, 1, 3, 2],
      [3, 1, 2, 4, 3, 2, 1],
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildDayLabel('Lun'),
                      const SizedBox(height: 15),
                      _buildDayLabel('Mer'),
                      const SizedBox(height: 15),
                      _buildDayLabel('Ven'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: random.map((week) {
                    return Row(
                      children: week.asMap().entries.map((entry) {
                        final index = entry.key;
                        final level = entry.value;
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 800 + (index * 100)),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: _buildContributionSquare(level),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayLabel(String day) {
    return SizedBox(
      height: 12,
      child: Text(
        day,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildContributionSquare(int level) {
    Color getColor() {
      switch (level) {
        case 0:
          return const Color(0xFF161B22);
        case 1:
          return Colors.green.withOpacity(0.3);
        case 2:
          return Colors.green.withOpacity(0.5);
        case 3:
          return Colors.green.withOpacity(0.7);
        case 4:
          return Colors.green;
        default:
          return const Color(0xFF161B22);
      }
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 0.5,
        ),
      ),
    );
  }

  Widget _buildContributionLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Moins',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(width: 8),
        _buildContributionSquare(0),
        const SizedBox(width: 4),
        _buildContributionSquare(1),
        const SizedBox(width: 4),
        _buildContributionSquare(2),
        const SizedBox(width: 4),
        _buildContributionSquare(3),
        const SizedBox(width: 4),
        _buildContributionSquare(4),
        const SizedBox(width: 8),
        Text(
          'Plus',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSkillCategory(String title, List<Map<String, dynamic>> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ...skills.map((skill) => _buildAnimatedSkillBar(
          skill['name'] as String,
          skill['level'] as double,
          skill['color'] as Color,
        )),
      ],
    );
  }

  Widget _buildAnimatedSkillBar(String name, double level, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: level),
        duration: Duration(milliseconds: 1500 + (level * 500).toInt()),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${(value * 100).toInt()}%',
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1117),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _buildStatCard(
              icon: Icons.code,
              title: '5+',
              subtitle: 'Projets Complétés',
              color: Colors.blue,
              width: isMobile ? constraints.maxWidth : 200,
            ),
            _buildStatCard(
              icon: Icons.star,
              title: '56',
              subtitle: 'GitHub Stars',
              color: Colors.amber,
              width: isMobile ? constraints.maxWidth : 200,
            ),
            _buildStatCard(
              icon: Icons.terminal,
              title: '3+',
              subtitle: 'Années d\'Expérience',
              color: Colors.green,
              width: isMobile ? constraints.maxWidth : 200,
            ),
            _buildStatCard(
              icon: Icons.people,
              title: 'APEXNova',
              subtitle: 'Membre Actif',
              color: Colors.purple,
              width: isMobile ? constraints.maxWidth : 200,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required double width,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: width,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1117),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjects(BuildContext context) {
    final projects = [
      {
        'name': 'lvlmindapp',
        'description':
        'Application mobile basée sur Flutter pour la gestion de l\'apprentissage et du développement personnel',
        'language': 'Dart',
        'stars': 18,
        'url': 'https://github.com/josoavj/lvlmindapp',
      },
      {
        'name': 'elasticsearch-nodejs-server',
        'description':
        'Serveur NodeJS avec Elasticsearch pour filtrer les données Fortinet',
        'language': 'JavaScript',
        'stars': 14,
        'url': 'https://github.com/josoavj/elasticsearch-nodejs-server',
      },
      {
        'name': 'Casier-Judiciare-N3',
        'description':
        'Logiciel de saisie pour le Casier Judiciaire N3 avec stockage sécurisé',
        'language': 'Java',
        'stars': 13,
        'url': 'https://github.com/josoavj/Casier-Judiciare-N3',
      },
      {
        'name': 'dbPlanificator',
        'description': 'Base de données MySQL pour logiciel de planification',
        'language': 'Python',
        'stars': 11,
        'url': 'https://github.com/josoavj/dbPlanificator',
      },
      {
        'name': 'forLinuxUser',
        'description':
        'Configurations et scripts pour utilisateurs Linux, networking et cybersécurité',
        'language': 'Shell',
        'stars': 0,
        'url': 'https://github.com/josoavj/forLinuxUser',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          const Text(
            'Projets',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 900
                    ? 3
                    : MediaQuery.of(context).size.width > 600
                    ? 2
                    : 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _buildProjectCard(projects[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return InkWell(
      onTap: () => _launchURL(project['url']),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF161B22),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.folder, color: Colors.blue, size: 30),
                const Spacer(),
                Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 5),
                Text(
                  '${project['stars']}',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              project['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                project['description'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  height: 1.4,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _getLanguageColor(project['language']),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  project['language'],
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getLanguageColor(String language) {
    switch (language) {
      case 'Dart':
        return Colors.blue;
      case 'JavaScript':
        return Colors.yellow;
      case 'Java':
        return Colors.red;
      case 'Python':
        return Colors.green;
      case 'Shell':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  Widget _buildContact(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      color: const Color(0xFF161B22),
      child: Column(
        children: [
          const Text(
            'Contactez-moi',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Je suis ouvert aux collaborations et discussions!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[300],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 900;

                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildContactForm(context),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 2,
                        child: _buildContactInfo(),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildContactForm(context),
                      const SizedBox(height: 30),
                      _buildContactInfo(),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Envoyez-moi un message',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 25),
          _buildTextField(
            controller: nameController,
            label: 'Nom',
            icon: Icons.person,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: messageController,
            label: 'Message',
            icon: Icons.message,
            maxLines: 5,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              _sendEmail(
                nameController.text,
                emailController.text,
                messageController.text,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.send),
                SizedBox(width: 10),
                Text(
                  'Envoyer le message',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(icon, color: Colors.blue),
        filled: true,
        fillColor: const Color(0xFF161B22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contact Direct',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              _buildContactInfoItem(
                icon: Icons.chat,
                title: 'WhatsApp',
                subtitle: '+261 33 60 223 60',
                onTap: () => _launchURL('https://wa.me/261336022360'),
              ),
              const SizedBox(height: 20),
              _buildContactInfoItem(
                icon: Icons.location_on,
                title: 'Localisation',
                subtitle: 'Antananarivo, Madagascar',
              ),
              const SizedBox(height: 20),
              _buildContactInfoItem(
                icon: Icons.work_outline,
                title: 'Organisation',
                subtitle: 'APEXNova Labs',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _launchURL('https://wa.me/261336022360'),
            icon: const Icon(Icons.phone, size: 24),
            label: const Text(
              'WhatsApp',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _launchURL('https://github.com/josoavj'),
            icon: const Icon(Icons.code),
            label: const Text('GitHub'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () =>
                _launchURL('https://www.linkedin.com/in/josoavonjiniaina'),
            icon: const Icon(Icons.work),
            label: const Text('LinkedIn'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (onTap != null)
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 16,
            ),
        ],
      ),
    );
  }

  void _sendEmail(String name, String email, String message) {
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      debugPrint('Tous les champs sont requis');
      return;
    }

    final String subject = Uri.encodeComponent('Contact Portfolio - $name');
    final String body = Uri.encodeComponent(
      'Nom: $name\nEmail: $email\n\nMessage:\n$message',
    );

    // Remplacez par votre adresse email
    final String mailtoUrl = 'mailto:votre.email@example.com?subject=$subject&body=$body';

    _launchURL(mailtoUrl);
  }



  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: const Color(0xFF0D1117),
      child: Column(
        children: [
          Text(
            '© 2025 Josoa Vonjiniaina. Tous droits réservés.',
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Développé avec Flutter ❤️',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}