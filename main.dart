import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dartui:ui' as ui;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PremiumPortfolioV1());
}

class PremiumPortfolioV1 extends StatelessWidget {
  const PremiumPortfolioV1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moe Kyaw Aung - Senior Android Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Inter',
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  int _selectedIndex = 0;
  bool _isDark = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, _) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Section with Photo
              _buildHeroSection(context),
              
              // Stats Section
              _buildStatsSection(context),
              
              // Quick Actions
              _buildQuickActions(context),
              
              // Divider
              _buildDivider(context),
              
              // Focus Areas
              _buildFocusAreas(context),
              
              _buildDivider(context),
              
              // Tech Stack
              _buildTechStack(context),
              
              _buildDivider(context),
              
              // Featured Projects
              _buildFeaturedProjects(context),
              
              _buildDivider(context),
              
              // All Projects Grid
              _buildAllProjects(context),
              
              _buildDivider(context),
              
              // Certifications
              _buildCertifications(context),
              
              _buildDivider(context),
              
              // Contact Info
              _buildContact(context),
              
              // Footer
              _buildFooter(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo with Animation
          Center(
            child: Hero(
              tag: 'profile-photo',
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.primary,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://res.cloudinary.com/dye5qpwii/image/upload/v1778527878/IMG_20260430_053105_uef0yr.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return Icon(
                        Icons.person,
                        size: 80,
                        color: colorScheme.primary,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Open to Work Badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3DDC97),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3DDC97).withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '🟢 Open to Work',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Name
          Text(
            'မိုးကျော်အောင်
Moe Kyaw Aung',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: colorScheme.onBackground,
              letterSpacing: -1,
              height: 1.2,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Title
          Text(
            'Senior Android Developer',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Location
          Text(
            'Tachileik, Myanmar 🇲🇲  ↔  Bangkok, Thailand 🇹🇭',
            style: TextStyle(
              fontSize: 15,
              color: colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Languages
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildLanguageBadge(context, '🇲🇲 Burmese', 'Native'),
              _buildLanguageBadge(context, '🌐 English', 'Professional'),
              _buildLanguageBadge(context, '☕ Kotlin', 'Expert'),
            ],
          ),
          
          const SizedBox(height: 28),
          
          // Summary
          Text(
            'Senior Android Engineer with 3+ years designing high-performance mobile apps using Kotlin, Jetpack Compose, MVVM, and Clean Architecture. Built 40+ projects with 82+ certifications. Expert in Firebase and REST APIs. Setting up CI/CD with GitHub Actions.',
            style: TextStyle(
              fontSize: 15,
              color: colorScheme.onBackground.withOpacity(0.8),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageBadge(BuildContext context, String lang, String level) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            level,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            '82+',
            'Certificates',
            const Color(0xFF3DDC97),
          ),
          _buildDividerVertical(colorScheme),
          _buildStatItem(
            context,
            '40+',
            'Projects',
            const Color(0xFFFFB454),
          ),
          _buildDividerVertical(colorScheme),
          _buildStatItem(
            context,
            '3+',
            'Years',
            const Color(0xFF6C63FF),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String number,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildDividerVertical(ColorScheme colorScheme) {
    return Container(
      width: 2,
      height: 60,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              context,
              '📱 Apps',
              Icons.phone_android,
              colorScheme.primary,
              () => _scrollToSection('projects'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              context,
              '📄 Resume',
              Icons.download,
              const Color(0xFF3DDC97),
              () => _downloadResume(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              context,
              '💼 LinkedIn',
              Icons.business,
              const Color(0xFF0077B5),
              () => _openLinkedIn(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: LinearGradient(
        colors: [
          Colors.transparent,
          colorScheme.primary.withOpacity(0.3),
          Colors.transparent,
        ],
      ),
    );
  }

  Widget _buildFocusAreas(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✨ What I Build',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Focus Areas',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: colorScheme.onBackground,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 28),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildFocusCard(
                context,
                '📱 Mobile',
                'Kotlin · Jetpack Compose · MVVM · Clean Arch',
                const Color(0xFF6C63FF),
              ),
              _buildFocusCard(
                context,
                '☁️ Backend',
                'Firebase · REST APIs · Python',
                const Color(0xFF3DDC97),
              ),
              _buildFocusCard(
                context,
                '🔐 Security',
                'Ethical Hacking · Cybersecurity',
                const Color(0xFFFF6B6B),
              ),
              _buildFocusCard(
                context,
                '🤖 AI / ML',
                'Claude API · TFLite · On-Device ML',
                const Color(0xFFFFB454),
              ),
            ],
          ),
          const SizedBox(height: 28),
          
          // Currently Building
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary.withOpacity(0.2),
                  colorScheme.secondary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.primary.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🚀 Currently Building',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'MoekyawTranslator — AI Translation App',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"Code with culture. Build with purpose."',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onBackground.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusCard(
    BuildContext context,
    String title,
    String tech,
    Color color,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tech,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onBackground.withOpacity(0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStack(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🛠️ Technologies I Use',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: colorScheme.onBackground,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 28),
          
          // Skills Grid
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildSkillTag(context, 'Kotlin', const Color(0xFF7F52FF)),
              _buildSkillTag(context, 'Jetpack Compose', const Color(0xFF4285F4)),
              _buildSkillTag(context, 'Android', const Color(0xFF3DDC84)),
              _buildSkillTag(context, 'MVVM', const Color(0xFFC9A84C)),
              _buildSkillTag(context, 'Clean Arch', const Color(0xFF1A1A2E)),
              _buildSkillTag(context, 'Firebase', const Color(0xFFFFCA28)),
              _buildSkillTag(context, 'Retrofit', const Color(0xFF48B983)),
              _buildSkillTag(context, 'Room', const Color(0xFF3DDC84)),
              _buildSkillTag(context, 'Coroutines', const Color(0xFF7F52FF)),
              _buildSkillTag(context, 'GitHub Actions', const Color(0xFF2088FF)),
              _buildSkillTag(context, 'CI/CD', const Color(0xFF007ACC)),
              _buildSkillTag(context, 'Flutter', const Color(0xFF02569B)),
              _buildSkillTag(context, 'Python', const Color(0xFF3776AB)),
              _buildSkillTag(context, 'Machine Learning', const Color(0xFFFF6F00)),
              _buildSkillTag(context, 'Cyber Security', const Color(0xFF0D0D0D)),
              _buildSkillTag(context, 'Linux', const Color(0xFFFC C624)),
              _buildSkillTag(context, 'Git', const Color(0xFFF05032)),
              _buildSkillTag(context, 'Docker', const Color(0xFF2496ED)),
              _buildSkillTag(context, 'PostgreSQL', const Color(0xFF336791)),
              _buildSkillTag(context, 'MongoDB', const Color(0xFF47A248)),
              _buildSkillTag(context, 'React', const Color(0xFF61DAFB)),
              _buildSkillTag(context, 'Vue.js', const Color(0xFF42B883)),
              _buildSkillTag(context, 'Java', const Color(0xFF007396)),
              _buildSkillTag(context, 'JavaScript', const Color(0xFFF7DF1E)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillTag(BuildContext context, String label, Color color) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFeaturedProjects(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔥 Featured Project',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: colorScheme.onBackground,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 28),
          
          // PulseSync Featured Card
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary.withOpacity(0.3),
                  colorScheme.primary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: colorScheme.primary,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '🔥 FEATURED',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'PulseSync – Real-time Sync Platform',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Advanced multi-module Android application demonstrating senior-level architecture, Firebase backend, offline-first design, and full CI/CD pipeline with GitHub Actions.',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onBackground.withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildProjectButton(
                        context,
                        '📱 GitHub',
                        Icons.code,
                        colorScheme.primary,
                        () => _openGitHub('pulsesync'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildProjectButton(
                        context,
                        '⬇️ APK',
                        Icons.download,
                        const Color(0xFF3DDC97),
                        () => _downloadAPK('pulsesync'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllProjects(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📱 My Android & Web Apps',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: colorScheme.onBackground,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '16 Production Projects',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 28),
          
          // Projects Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildProjectCard(context, '📱', '1', 'Social Dashboard', 'NEW', const Color(0xFF6C63FF)),
              _buildProjectCard(context, '📱', '2', 'PWA App', '', const Color(0xFF4285F4)),
              _buildProjectCard(context, '📊', '3', 'Admin Dashboard', '', const Color(0xFF3DDC97)),
              _buildProjectCard(context, '📈', '4', 'Stock Market', '', const Color(0xFFFFB454)),
              _buildProjectCard(context, '🎮', '5', 'Game Collection', '', const Color(0xFFFF6B6B)),
              _buildProjectCard(context, '🎵', '6', 'Music Player', '', const Color(0xFF9C27B0)),
              _buildProjectCard(context, '💬', '7', 'Chat App', '', const Color(0xFF00BCD4)),
              _buildProjectCard(context, '⚽', '8', 'World Cup', '', const Color(0xFF4CAF E5)),
              _buildProjectCard(context, '🛒', '9', 'E-commerce', '', const Color(0xFFFF9800)),
              _buildProjectCard(context, '💼', '10', 'Portfolio', '', const Color(0xFF6C63FF)),
              _buildProjectCard(context, '💰', '11', 'Money Tracker', '', const Color(0xFF3DDC97)),
              _buildProjectCard(context, '🌤️', '12', 'Weather', '', const Color(0xFF2196F3)),
              _buildProjectCard(context, '💸', '13', 'Crypto', '', const Color(0xFFFF6B6B)),
              _buildProjectCard(context, '📝', '14', 'Todo', '', const Color(0xFFFFC107)),
              _buildProjectCard(context, '🎯', '15', 'Video Player', '', const Color(0xFFE91E63)),
              _buildProjectCard(context, '🎯', '16', 'LEGEND!', 'MASTER', const Color(0xFF3DDC97)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    String icon,
    String number,
    String title,
    String badge,
    Color color,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  icon,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onBackground.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (badge.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badge == 'MASTER' 
                    ? const Color(0xFF3DDC97) 
                    : const Color(0xFFFFB454),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          if (badge.isNotEmpty) const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertifications(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🏆 Certifications',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: colorScheme.onBackground,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 10),
          
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF3DDC97),
                  const Color(0xFF4EF5A8),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3DDC97).withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  color: Colors.black,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  '82+ Certificates · Programming Hub · Google Developers Launchpad',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          
          // Cert Grid
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildCertCard(context, '⌨️ C Programming', 'Jul 2024'),
              _buildCertCard(context, '🤖 Kotlin / Android', '2023-24'),
              _buildCertCard(context, '🌐 Web Development', '2023-24'),
              _buildCertCard(context, '🤖 Machine Learning', '2023-24'),
              _buildCertCard(context, '🔐 Cyber Security', '2023-24'),
              _buildCertCard(context, '⛓️ Blockchain', '2023-24'),
              _buildCertCard(context, '🐘 PostgreSQL', '2023-24'),
              _buildCertCard(context, '🛠️ Software Eng', '2023-24'),
              _buildCertCard(context, '📈 Marketing', '2023-24'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCertCard(BuildContext context, String title, String date) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: colorScheme.onBackground,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: colorScheme.onBackground.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContact(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📬 Get In Touch',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: colorScheme.onBackground,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 28),
          
          // Contact Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildContactCard(
                context,
                '📱 Phone',
                '+95 9 889 000 889',
                const Color(0xFF6C63FF),
              ),
              _buildContactCard(
                context,
                '📧 Email',
                'moekyawaung@programmer.net',
                const Color(0xFFFF6B6B),
              ),
              _buildContactCard(
                context,
                '💼 LinkedIn',
                'moe-kyaw-aung',
                const Color(0xFF0077B5),
              ),
              _buildContactCard(
                context,
                '🖥️ GitHub',
                'Dev-moe-kyawaung',
                const Color(0xFF6E5494),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onBackground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            '"Code with culture. Build with purpose."',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '© 2026 Moe Kyaw Aung | Senior Android Developer',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onBackground.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Built with Kotlin · Jetpack Compose · Flutter | Hosted on GitHub Pages',
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onBackground.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          
          // Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(context, Icons.code, colorScheme.primary, () => _openGitHub('main')),
              const SizedBox(width: 20),
              _buildSocialIcon(context, Icons.business, const Color(0xFF0077B5), () => _openLinkedIn()),
              const SizedBox(width: 20),
              _buildSocialIcon(context, Icons.email, const Color(0xFFEA4335), () => _sendEmail()),
              const SizedBox(width: 20),
              _buildSocialIcon(context, Icons.download, const Color(0xFF3DDC97), () => _downloadResume()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(
    BuildContext context,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 24,
          color: color,
        ),
      ),
    );
  }

  // Action Methods
  void _scrollToSection(String sectionId) {
    // Implement scroll logic
  }

  void _downloadResume() {
    // Implement resume download
  }

  void _openLinkedIn() {
    // Implement LinkedIn open
  }

  void _openGitHub(String project) {
    // Implement GitHub open
  }

  void _downloadAPK(String project) {
    // Implement APK download
  }

  void _sendEmail() {
    // Implement email send
  }
}
