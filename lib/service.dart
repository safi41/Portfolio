import 'dart:ui';
import 'package:flutter/material.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  // 1. Controller is now nullable so we can dynamically recreate it
  // when the screen size changes between mobile and desktop.
  PageController? _pageController;
  double _currentPage = 0;

  final List<Map<String, String>> services = [
    {"title": "Mobile App\nDevelopment", "image": "assets/images/mobile.png"},
    {"title": "Responsive\nWeb Apps", "image": "assets/images/web.webp"},
    {"title": "Custom Desktop\nSolutions", "image": "assets/images/desktop.png"},
    {"title": "UI/UX Design\n& Animation", "image": "assets/images/ui.webp"},
  ];

  void _scrollListener() {
    if (_pageController != null && _pageController!.hasClients) {
      setState(() {
        _currentPage = _pageController!.page ?? 0;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 2. Check screen width
    final isMobile = MediaQuery.of(context).size.width < 800;

    // 3. Dynamic Viewport: 85% width on mobile, 35% on desktop
    final expectedFraction = isMobile ? 0.85 : 0.35;

    // Safely recreate the PageController if the screen size crosses the breakpoint
    if (_pageController == null || _pageController!.viewportFraction != expectedFraction) {
      int initialPage = 0;
      if (_pageController != null && _pageController!.hasClients) {
        initialPage = _pageController!.page?.round() ?? 0;
        _pageController!.removeListener(_scrollListener);
        _pageController!.dispose();
      }
      _pageController = PageController(viewportFraction: expectedFraction, initialPage: initialPage);
      _pageController!.addListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    _pageController?.removeListener(_scrollListener);
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      // Reduce padding on mobile
      padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 80, horizontal: isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        // Reduce corner curves on mobile so it doesn't cut off content
        borderRadius: BorderRadius.circular(isMobile ? 40.0 : 90.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.secondary, Colors.black],
        ),
      ),
      child: Column(
        children: [
          // 4. Responsive Header (Stack vertically on mobile, horizontally on desktop)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 30.0),
            child: isMobile
                ? _buildMobileHeader(theme, colorScheme)
                : _buildDesktopHeader(theme, colorScheme),
          ),

          SizedBox(height: isMobile ? 40 : 60),

          // Horizontal Scrollable Cards
          SizedBox(
            height: 480, // Matched perfectly with the card height
            child: PageView.builder(
              controller: _pageController,
              itemCount: services.length,
              padEnds: isMobile, // Centers the single card on mobile, aligns left on desktop
              itemBuilder: (context, index) {
                return Padding(
                  // Adjust spacing between cards
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 25),
                  child: ServiceCard(
                    title: services[index]["title"]!,
                    imageAsset: services[index]["image"]!,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 50),

          // 5. Fixed Dots Indicator (Scales dynamically with the number of services)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(services.length, (index) {
              bool isActive = index == _currentPage.round();

              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _pageController?.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? (isMobile ? 30 : 40) : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? colorScheme.primary : Colors.white38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  // --- Header Helpers ---

  Widget _buildDesktopHeader(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: theme.textTheme.displayLarge?.copyWith(color: Colors.white, fontSize: 48),
            children: [
              const TextSpan(text: "My "),
              TextSpan(text: "Services", style: TextStyle(color: colorScheme.primary)),
            ],
          ),
        ),
        const SizedBox(
          width: 400,
          child: Text(
            "Providing top-tier digital solutions tailored to your business needs, from conceptual design to full-scale development.",
            style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: theme.textTheme.displayLarge?.copyWith(color: Colors.white, fontSize: 40), // Smaller font
            children: [
              const TextSpan(text: "My\n"),
              TextSpan(text: "Services", style: TextStyle(color: colorScheme.primary)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Providing top-tier digital solutions tailored to your business needs, from conceptual design to full-scale development.",
          style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
        ),
      ],
    );
  }
}

class ServiceCard extends StatefulWidget {
  final String title;
  final String imageAsset;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imageAsset,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // 6. Flexible width for mobile devices
            width: isMobile ? double.infinity : 350,
            height: 480,
            decoration: BoxDecoration(
              color: _isHovered ? colorScheme.primary.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: _isHovered ? colorScheme.primary : Colors.white.withValues(alpha: 0.2),
                  width: 1.5
              ),
            ),
            child: Stack(
              children: [
                // Top Text and Divider
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 13.0, right: 30.0, bottom: 15.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 24 : 28, // Slightly smaller on mobile
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ],
                ),

                // Inner Content area
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  child: SizedBox(
                    height: 310,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          top: 0,
                          left: 40,
                          right: 40,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 20,
                          right: 20,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipPath(
                            clipper: CardCutoutClipper(cutoutRadius: 80),
                            child: Container(
                              height: 275,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2E8DF),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: AnimatedScale(
                                  scale: _isHovered ? 1.08 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutBack,
                                  child: Image.asset(
                                    widget.imageAsset,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Icon(Icons.image, size: 80, color: colorScheme.secondary.withValues(alpha: 0.3)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Arrow Button
                Positioned(
                  bottom: 12,
                  right: isMobile ? -20 : -30, // Pull it slightly inward on mobile to prevent clipping
                  child: Image.asset('assets/images/flu.png', width: isMobile ? 120 : 150, fit: BoxFit.contain,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper (remains unchanged)
class CardCutoutClipper extends CustomClipper<Path> {
  final double cutoutRadius;
  final double cornerRadius;

  CardCutoutClipper({required this.cutoutRadius, this.cornerRadius = 20.0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double r = cornerRadius;

    path.moveTo(0, r);
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));

    path.lineTo(size.width - r, 0);
    path.arcToPoint(Offset(size.width, r), radius: Radius.circular(r));

    path.lineTo(size.width, size.height - cutoutRadius);

    path.arcToPoint(
      Offset(size.width - cutoutRadius, size.height),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(r, size.height);
    path.arcToPoint(Offset(0, size.height - r), radius: Radius.circular(r));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}