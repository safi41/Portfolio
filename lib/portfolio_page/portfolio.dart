import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:porfolio/experince.dart';
import 'package:porfolio/footer.dart';
import 'package:porfolio/hire_me.dart';
import 'package:porfolio/hover_home.dart';
import 'package:porfolio/navbar.dart';
import 'package:porfolio/portfolio_section.dart';
import 'package:porfolio/service.dart';

class PortfolioHeroPage extends ConsumerStatefulWidget {
  const PortfolioHeroPage({super.key});

  @override
  ConsumerState<PortfolioHeroPage> createState() => _ConsumerPortfolioHeroPageState();
}

class _ConsumerPortfolioHeroPageState extends ConsumerState<PortfolioHeroPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  String _activeTab = "Home";

  // --- 1. CREATE GLOBAL KEYS FOR EACH SECTION ---
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _serviceKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _hireMeKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // 1. Handle the shrink/expand animation of the navbar
    bool sc = _scrollController.offset > 50;
    if (sc != _isScrolled) {
      setState(() => _isScrolled = sc);
    }

    // 2. Automatically highlight the correct tab based on scroll position
    _updateActiveTabOnScroll();
  }
  void _updateImageState({required bool isHoveringContainer}) {
    // 1. Tell the app to zoom in or out
    ref.read(isHoveredProvider.notifier).state = isHoveringContainer;

    // 2. Change the image
    if (isHoveringContainer) {
      ref.read(profileImageProvider.notifier).state = 'assets/dummy2.png';
    }else{
      ref.read(profileImageProvider.notifier).state = 'assets/dummy.png';

    }
  }
  void _updateActiveTabOnScroll() {
    // If we are at the very bottom of the page, force highlight the last tab (Contact)
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
      if (_activeTab != "Contact") setState(() => _activeTab = "Contact");
      return;
    }

    // Check sections from BOTTOM to TOP.
    // We look for the first section whose top edge has reached the top third of the screen.
    String newActiveTab = _activeTab;

    if (_isSectionActive(_contactKey)) { // Make sure you added _contactKey!
      newActiveTab = "Contact";
    } else if (_isSectionActive(_portfolioKey)) {
      newActiveTab = "Project";
    } else if (_isSectionActive(_hireMeKey)) {
      newActiveTab = "Hire me";
    } else if (_isSectionActive(_experienceKey)) {
      newActiveTab = "Experience";
    } else if (_isSectionActive(_serviceKey)) {
      newActiveTab = "Service";
    } else if (_isSectionActive(_homeKey)) {
      newActiveTab = "Home";
    }

    // Only update the state if the tab actually changed
    if (newActiveTab != _activeTab) {
      setState(() => _activeTab = newActiveTab);
    }
  }

  // Helper method to calculate if a section is currently visible at the top of the screen
  bool _isSectionActive(GlobalKey key) {
    if (key.currentContext == null) return false;

    // Get the render box of the section
    final RenderBox? box = key.currentContext!.findRenderObject() as RenderBox?;
    if (box == null) return false;

    // Get the Y position of the section relative to the viewport (the screen)
    final Offset position = box.localToGlobal(Offset.zero);

    // If the top of the section is less than 300 pixels from the top of the screen,
    // we consider it the "active" section.
    return position.dy < 300;
  }

  // --- 2. UPDATE SCROLL FUNCTION TO USE KEYS ---
  void _scrollToSection(String tabName) {
    setState(() {
      _activeTab = tabName;
    });

    BuildContext? targetContext;

    // Map the tab name to the corresponding GlobalKey's context
    if (tabName == "Home") targetContext = _homeKey.currentContext;
    if (tabName == "Service") targetContext = _serviceKey.currentContext;
    if (tabName == "Experience") targetContext = _experienceKey.currentContext;
    if (tabName == "Hire me") targetContext = _hireMeKey.currentContext;
    if (tabName == "Project") targetContext = _portfolioKey.currentContext; // Assuming "Project" links to Portfolio
    if (tabName == "Contact") targetContext = _contactKey.currentContext; // Assuming "Project" links to Portfolio

    if (targetContext != null) {
      // Ensure the widget is rendered before calculating its position
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        // Optional: offset so the header doesn't cover the top of the section
        // alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = ref.watch(profileImageProvider);
    final isHovered = ref.watch(isHoveredProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Detect if the screen is mobile (width < 800)
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // HOME SECTION
                Container(
                  key: _homeKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      SizedBox(
                        // Slightly shorter stack height on mobile
                        height: isMobile ? 600 : 700,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.none,
                          children: [
                            // Layer 1: Background Arch
                            Positioned(
                              bottom: 0,
                              child: Container(
                                // Scale down arch height and width for mobile
                                height: isMobile ? 350 : 450,
                                width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 650,
                                decoration: BoxDecoration(
                                  color: colorScheme.tertiary,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(350),
                                    topRight: Radius.circular(350),
                                  ),
                                ),
                              ),
                            ),

                            // Layer 2: Profile Image
                            Positioned(
                              bottom: 0,
                              child: MouseRegion(
                                onEnter: (_) {
                                  ref.read(isHoveredProvider.notifier).state = true;
                                  _updateImageState(isHoveringContainer: true);
                                },
                                onExit: (_) {
                                  ref.read(isHoveredProvider.notifier).state = false;
                                  _updateImageState(isHoveringContainer: false);
                                },
                                child: SizedBox(
                                  // Scale down the image height on mobile
                                  height: isMobile ? 380 : 490,
                                  child: AnimatedScale(
                                    scale: isHovered ? 1.05 : 1.0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeOutBack,
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 600),
                                      transitionBuilder: (Widget child, Animation<double> animation) {
                                        return FadeTransition(opacity: animation, child: child);
                                      },
                                      child: Image.asset(
                                        currentImage,
                                        key: ValueKey(currentImage),
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) => Icon(
                                          Icons.person,
                                          size: 400,
                                          color: colorScheme.primary.withValues(alpha: 0.1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Layer 3: Text Content
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: AnimatedOpacity(
                                opacity: isHovered ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.easeInOut,
                                child: AnimatedSlide(
                                  offset: isHovered ? const Offset(0, 0.5) : Offset.zero,
                                  duration: const Duration(milliseconds: 900),
                                  curve: isHovered ? Curves.easeIn : Curves.easeOutBack,
                                  child: Column(
                                    children: [
                                      SizedBox(height: isMobile ? 10 : 30),

                                      // Hello Bubble
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black12),
                                              borderRadius: BorderRadius.circular(20),
                                              color: colorScheme.secondary.withValues(alpha: 0.9),
                                            ),
                                            child:  Text(
                                              "Hello!",
                                              style: TextStyle(fontWeight: FontWeight.w600,color:colorScheme.onSecondary),
                                            ),
                                          ),
                                          Positioned(
                                            top: -15,
                                            right: -15,
                                            child: SvgPicture.asset('assets/hello.svg', width: 25),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: isMobile ? 10 : 20),

                                      // Main Heading
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: theme.textTheme.displayLarge?.copyWith(
                                                // 2. Dramatically reduce font size for mobile
                                                fontSize: isMobile ? 42 : 72,
                                                color: Colors.black,
                                                height: 1.05,
                                                letterSpacing: -1,
                                              ),
                                              children: [
                                                TextSpan(text: "I'm ",
                                                  style: TextStyle(color: colorScheme.onSurface),
                                                ),
                                                TextSpan(
                                                  text: "Sufian,\n",
                                                  style: TextStyle(color: colorScheme.primary),
                                                ),
                                                 TextSpan(text: "Flutter Developer",
                                                  style: TextStyle(color: colorScheme.onSurface),

                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            // Adjust SVG position so it doesn't clip on small screens
                                            left: isMobile ? -15 : -40,
                                            bottom: isMobile ? -10 : -20,
                                            child: SvgPicture.asset('assets/pro.svg', width: isMobile ? 30 : 40),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Layer 4: Floating Badges
                            // 3. Hide floating badges on mobile because they will overflow and cover the user's face
                            if (!isMobile)
                              Positioned(
                                top: 320,
                                left: 60,
                                right: 60,
                                child: AnimatedSlide(
                                  offset: isHovered ? const Offset(0, -0.90) : Offset.zero,
                                  duration: const Duration(milliseconds: 700),
                                  curve: isHovered ? Curves.easeOut : Curves.easeOutBack,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildSideQuote(context),
                                      _buildExperienceBadge(context),
                                    ],
                                  ),
                                ),
                              ),

                            // Hero Buttons
                            Positioned(
                              bottom: isMobile ? 10 : 30, // Pull up slightly on mobile
                              child: Material(
                                color: Colors.transparent,
                                child: const HoverHeroButtons(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // OTHER SECTIONS WRAPPED WITH KEYS
                Container(key: _serviceKey, child: const ServicesSection()),
                Container(key: _experienceKey, child: WorkExperienceSection()),
                Container(key: _hireMeKey, child: WhyHireMeSection()),
                Container(key: _portfolioKey, child: PortfolioSection()),
                Container(
                  key: _contactKey,
                  child: CustomFooter(onTabSelected: _scrollToSection),
                )
              ],
            ),
          ),

          // Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavHeader(
              isScrolled: _isScrolled,
              activeTab: _activeTab,
              onTabSelected: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideQuote(BuildContext context) {
    return const SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote, size: 40, color: Colors.black26),
          Text(
            "Sufian's Flutter expertise ensured our platform's rapid growth and stability.",
            style: TextStyle(fontSize: 14, height: 1.5, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceBadge(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          children: List.generate(
            5,
                (index) => Icon(Icons.star, color: colorScheme.primary, size: 20),
          ),
        ),
        const SizedBox(height: 8),
        const Text("3 Years", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const Text("Experience", style: TextStyle(color: Colors.black45)),
      ],
    );
  }
}