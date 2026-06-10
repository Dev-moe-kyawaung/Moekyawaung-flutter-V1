// main.dart - Premium Ultra Portfolio v1 enhanced with animations, toggle, and download
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PremiumPortfolioV1());
}

class PremiumPortfolioV1 extends StatefulWidget {
  const PremiumPortfolioV1({super.key});

  @override
  State<PremiumPortfolioV1> createState() => _PremiumPortfolioV1State();
}

class _PremiumPortfolioV1State extends State<PremiumPortfolioV1> {
  bool _isDark = true;
  
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _isDark ? _darkTheme() : _lightTheme(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: MaterialApp(
        title: 'Moe Kyaw Aung - Senior Android Developer',
        debugShowCheckedModeBanner: false,
        home: PortfolioHomePage(isDark: _isDark, toggleTheme: () {
          setState(() {
            _isDark = !_isDark;
          });
        }),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C63FF),
        brightness: Brightness.dark,
      ),
      fontFamily: 'Inter',
      backgroundColor: const Color(0xFF0A0E1A),
      scaffoldBackgroundColor: const Color(0xFF0A0E1A),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C63FF),
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      backgroundColor: const Color(0xFFF8F9FF),
      scaffoldBackgroundColor: const Color(0xFFF8F9FF),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const PortfolioHomePage({
    super.key,
    required this.isDark,
    required this.toggleTheme,
  });

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};
  bool _isResuming = false;
  bool _isDownloading = false;
  bool _showFloatingActions = false;

  @override
  void initState() {
    super.initState();
    _initializeSections();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // Show floating actions after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showFloatingActions = true;
        });
      }
    });
  }

  void _initializeSections() {
    _sectionKeys['hero'] = GlobalKey();
    _sectionKeys['stats'] = GlobalKey();
    _sectionKeys['focus'] = GlobalKey();
    _sectionKeys['tech'] = GlobalKey();
    _sectionKeys['featured'] = GlobalKey();
    _sectionKeys['projects'] = GlobalKey();
    _sectionKeys['certs'] = GlobalKey();
    _sectionKeys['contact'] = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          // Animated Background Particles
          if (widget.isDark) _buildAnimatedBackground(colorScheme),
          
          // Main Content
          AnimatedBuilder(
            animation: _scrollController,
            builder: (context, _) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Floating Theme Toggle
                  _buildFloatingThemeToggle(colorScheme),
                  
                  // Floating Action Buttons
                  _buildFloatingActions(colorScheme),
                  
                  // Hero Section with Fade Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['hero']!,
                    child: _buildHeroSection(context),
                  ),
                  
                  // Stats Section with Slide Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['stats']!,
                    delay: 0.2,
                    child: _buildStatsSection(context),
                  ),
                  
                  // Quick Actions with Scale Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['quick']!,
                    delay: 0.4,
                    child: _buildQuickActions(context),
                  ),
                  
                  // Divider
                  _buildDivider(context),
                  
                  // Focus Areas with Stagger Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['focus']!,
                    delay: 0.6,
                    child: _buildFocusAreas(context),
                  ),
                  
                  _buildDivider(context),
                  
                  // Tech Stack with Wrap Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['tech']!,
                    delay: 0.8,
                    child: _buildTechStack(context),
                  ),
                  
                  _buildDivider(context),
                  
                  // Featured Project with Float Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['featured']!,
                    delay: 1.0,
                    child: _buildFeaturedProject(context),
                  ),
                  
                  _buildDivider(context),
                  
                  // All Projects with Grid Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['projects']!,
                    delay: 1.2,
                    child: _buildAllProjects(context),
                  ),
                  
                  _buildDivider(context),
                  
                  // Certifications with Flip Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['certs']!,
                    delay: 1.4,
                    child: _buildCertifications(context),
                  ),
                  
                  _buildDivider(context),
                  
                  // Contact with Pulse Animation
                  _buildAnimatedSection(
                    context,
                    key: _sectionKeys['contact']!,
                    delay: 1.6,
                    child: _buildContact(context),
                  ),
                  
                  // Footer
                  _buildFooter(context),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(ColorScheme colorScheme) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        return IgnorePointer(
          child: CustomPaint(
            painter: ParticlePainter(
              color: colorScheme.primary.withOpacity(0.1),
              scrollOffset: _scrollController.offset,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingThemeToggle(ColorScheme colorScheme) {
    return Positioned(
      top: 20,
      right: 20,
      child: AnimatedOpacity(
        opacity: _showFloatingActions ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: widget.toggleTheme,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.isDark 
                  ? const Color(0xFF6C63FF) 
                  : const Color(0xFFF8F9FF),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.isDark
                      ? const Color(0xFF6C63FF).withOpacity(0.4)
                      : Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                widget.isDark ? Icons.light_mode : Icons.dark_mode,
                size: 28,
                color: widget.isDark ? Colors.white : const Color(0xFF6C63FF),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActions(ColorScheme colorScheme) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: AnimatedOpacity(
        opacity: _showFloatingActions ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFloatingActionButton(
              context,
              '📄 Resume',
              Icons.download,
              const Color(0xFF3DDC97),
              () => _downloadResume(),
            ),
            const SizedBox(height: 12),
            _buildFloatingActionButton(
              context,
              '📱 Apps',
              Icons.phone_android,
              const Color(0xFF6C63FF),
              () => _scrollToSection('projects'),
            ),
            const SizedBox(height: 12),
            _buildFloatingActionButton(
              context,
              '💼 LinkedIn',
              Icons.business,
              const Color(0xFF0077B5),
              () => _openLinkedIn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: color,
            ),
            const SizedBox(width: 10),
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

  Widget _buildAnimatedSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: SlideTransition(
            position: TweenVector2(
              begin: const Vector2(0, 0.2),
              end: const Vector2(0, 0),
            ).animate(
              CurvedAnimation(
                parent: AlwaysStoppedAnimation(isVisible ? 1.0 : 0.0),
                curve: Curves.easeOut,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 100, 24, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo with Scale Animation
          ScaleTransition(
            scale: CurvedAnimation(
              parent: AlwaysStoppedAnimation(1.0),
              curve: Curves.easeOut,
            ),
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
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: colorScheme.primary,
                        ),
                      );
                    },
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
          
          // Open to Work Badge with Pulse Animation
          PulseAnimation(
            child: Center(
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
          ),
          
          const SizedBox(height: 24),
          
          // Name with Fade Animation
          FadeTransition(
            opacity: AlwaysStoppedAnimation(1.0),
            child: Text(
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
          ),
          
          const SizedBox(height: 12),
          
          // Title with Slide Animation
          SlideTransition(
            position: TweenVector2(
              begin: const Vector2(-0.1, 0),
              end: const Vector2(0, 0),
            ).animate(
              CurvedAnimation(
                parent: AlwaysStoppedAnimation(1.0),
                curve: Curves.easeOut,
              ),
            ),
            child: Text(
              'Senior Android Developer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
                letterSpacing: 0.5,
              ),
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
          
          // Languages with Stagger Animation
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildLanguageBadge(context, '🇲🇲 Burmese', 'Native', 0.0),
              _buildLanguageBadge(context, '🌐 English', 'Professional', 0.2),
              _buildLanguageBadge(context, '☕ Kotlin', 'Expert', 0.4),
            ],
          ),
          
          const SizedBox(height: 28),
          
          // Summary with Fade Animation
          FadeTransition(
            opacity: AlwaysStoppedAnimation(1.0),
            child: Text(
              'Senior Android Engineer with 3+ years designing high-performance mobile apps using Kotlin, Jetpack Compose, MVVM, and Clean Architecture. Built 40+ projects with 82+ certifications. Expert in Firebase and REST APIs. Setting up CI/CD with GitHub Actions.',
              style: TextStyle(
                fontSize: 15,
                color: colorScheme.onBackground.withOpacity(0.8),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageBadge(
    BuildContext context,
    String lang,
    String level,
    double delay,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation(1.0),
      builder: (context, _) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: AlwaysStoppedAnimation(1.0),
            curve: Curves.easeOut,
          ),
          child: SlideTransition(
            position: TweenVector2(
              begin: const Vector2(-0.1, 0),
              end: const Vector2(0, 0),
            ).animate(
              CurvedAnimation(
                parent: AlwaysStoppedAnimation(1.0),
                curve: Curves.easeOut,
              ),
            ),
            child: Container(
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAnimatedStatItem(context, '82+', 'Certificates', const Color(0xFF3DDC97), 0.0),
          _buildDividerVertical(colorScheme),
          _buildAnimatedStatItem(context, '40+', 'Projects', const Color(0xFFFFB454), 0.2),
          _buildDividerVertical(colorScheme),
          _buildAnimatedStatItem(context, '3+', 'Years', const Color(0xFF6C63FF), 0.4),
        ],
      ),
    );
  }

  Widget _buildAnimatedStatItem(
    BuildContext context,
    String number,
    String label,
    Color color,
    double delay,
  ) {
    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation(1.0),
      builder: (context, _) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: AlwaysStoppedAnimation(1.0),
            curve: Curves.easeOut,
          ),
          child: Column(
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
          ),
        );
      },
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
            child: _buildAnimatedActionButton(
              context,
              '📱 Apps',
              Icons.phone_android,
              colorScheme.primary,
              () => _scrollToSection('projects'),
              0.0,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildAnimatedActionButton(
              context,
              '📄 Resume',
              Icons.download,
              const Color(0xFF3DDC97),
              () => _downloadResume(),
              0.2,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildAnimatedActionButton(
              context,
              '💼 LinkedIn',
              Icons.business,
              const Color(0xFF0077B5),
              () => _openLinkedIn(),
              0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
    double delay,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: AlwaysStoppedAnimation(1.0),
        builder: (context, _) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: AlwaysStoppedAnimation(1.0),
              curve: Curves.easeOut,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.card,
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
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              Colors.transparent,
              colorScheme.primary.withOpacity(0.3),
              Colors.transparent,
            ],
          ).createShader(bounds);
        },
        child: Container(
          height: 1,
          color: Colors.white,
        ),
      ),
    );
  }

  // ... [Continue with remaining sections using same animation patterns]
  // Focus Areas, Tech Stack, Projects, Certifications, Contact, Footer
  // Use the same animation patterns as above

  Widget _buildFocusAreas(BuildContext context) {
    // Use same animation pattern as other sections
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✨ What I Build',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Focus Areas',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.onBackground,
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
              _buildFocusCard(context, '📱 Mobile', 'Kotlin · Jetpack Compose · MVVM · Clean Arch', const Color(0xFF6C63FF)),
              _buildFocusCard(context, '☁️ Backend', 'Firebase · REST APIs · Python', const Color(0xFF3DDC97)),
              _buildFocusCard(context, '🔐 Security', 'Ethical Hacking · Cybersecurity', const Color(0xFFFF6B6B)),
              _buildFocusCard(context, '🤖 AI / ML', 'Claude API · TFLite · On-Device ML', const Color(0xFFFFB454)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFocusCard(BuildContext context, String title, String tech, Color color) {
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

  // Action Methods
  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      final renderBox = key!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      _scrollController.animateTo(
        _scrollController.offset + position.dy - 100,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _downloadResume() async {
    if (_isResuming) return;
    setState(() => _isResuming = true);

    try {
      // Download resume PDF
      final Uri url = Uri.parse('https://moekyawaung.github.io/resume.pdf');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Show error
    }

    setState(() => _isResuming = false);
  }

  void _openLinkedIn() async {
    final Uri url = Uri.parse('https://linkedin.com/in/moe-kyaw-aung-2653093a1');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _openGitHub(String project) async {
    final Uri url = Uri.parse('https://github.com/Dev-moe-kyawaung');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _downloadAPK(String project) async {
    setState(() => _isDownloading = true);
    // Implement APK download
    setState(() => _isDownloading = false);
  }

  void _sendEmail() async {
    final Uri emailUri = Uri.parse('mailto:moekyawaung@programmer.net');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}

// Pulse Animation Widget
class PulseAnimation extends StatefulWidget {
  final Widget child;

  const PulseAnimation({super.key, required this.child});

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation(1.0),
      builder: (context, _) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 1.0, end: 1.05),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: widget.child,
        );
      },
    );
  }
}

// Particle Painter for Animated Background
class ParticlePainter extends CustomPainter {
  final Color color;
  final double scrollOffset;

  ParticlePainter({required this.color, required this.scrollOffset});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw animated particles
    for (int i = 0; i < 20; i++) {
      final x = (i * 50 + scrollOffset * 0.1) % size.width;
      final y = (i * 30) % size.height;
      
      final paint = Paint()
        .color = color
        .shader = RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [color.withOpacity(0.5), color.withOpacity(0.0)],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: 20));
      
      canvas.drawCircle(Offset(x, y), 20, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
