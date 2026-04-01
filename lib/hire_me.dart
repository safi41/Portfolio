import 'package:flutter/material.dart';

import 'hire_me dialog.dart';

class WhyHireMeSection extends StatefulWidget {
  const WhyHireMeSection({super.key});

  @override
  State<WhyHireMeSection> createState() => _WhyHireMeSectionState();
}

class _WhyHireMeSectionState extends State<WhyHireMeSection> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Detect screen size
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      // 2. Adjust padding for mobile
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 60,
        horizontal: isMobile ? 20 : 0, // Add horizontal padding on mobile so it doesn't touch edges
      ),
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(40),
      ),
      // 3. Switch between Column (Mobile) and Row (Desktop)
      child: isMobile
          ? Column(
        children: [
          _buildImageArea(colorScheme, isMobile: true),
          const SizedBox(height: 40),
          _buildContentArea(theme, colorScheme, isMobile: true),
        ],
      )
          : Row(
        children: [
          Expanded(
            flex: 4,
            child: _buildImageArea(colorScheme, isMobile: false),
          ),
          Expanded(
            flex: 4,
            child: _buildContentArea(theme, colorScheme, isMobile: false),
          ),
        ],
      ),
    );
  }

  // --- IMAGE AREA HELPER ---
  Widget _buildImageArea(ColorScheme colorScheme, {required bool isMobile}) {
    // 4. Wrap with GestureDetector so mobile users can tap to see the image swap!
    return GestureDetector(
      onTap: () {
        if (isMobile) {
          setState(() => _isHovering = !_isHovering);
        }
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // The Orange Shape
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              // Scale down the background shape on mobile
              width: _isHovering
                  ? (isMobile ? 260 : 340)
                  : (isMobile ? 240 : 320),
              height: _isHovering
                  ? (isMobile ? 320 : 420)
                  : (isMobile ? 300 : 400),
              decoration: BoxDecoration(
                color: _isHovering
                    ? colorScheme.primary.withValues(alpha: 0.85)
                    : colorScheme.primary.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(120),
              ),
            ),

            // The Person Image
            Positioned(
              bottom: isMobile ? -10 : -20,
              child: AnimatedScale(
                scale: _isHovering ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Image.asset(
                    _isHovering ? 'assets/dod.png' : 'assets/dummy.png',
                    key: ValueKey<String>(_isHovering ? 'dod' : 'dummy'),
                    // Scale down image height on mobile
                    height: isMobile ? 350 : 450,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- CONTENT AREA HELPER ---
  Widget _buildContentArea(ThemeData theme, ColorScheme colorScheme, {required bool isMobile}) {
    return Padding(
      // Remove heavy left padding on mobile so text centers nicely
      padding: EdgeInsets.only(
          left: isMobile ? 0 : 60,
          right: isMobile ? 0 : 20
      ),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            text: TextSpan(
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                // Scale down header font on mobile
                fontSize: isMobile ? 40 : 52,
                color: colorScheme.onSurface,
              ),
              children: [
                const TextSpan(text: "Why "),
                TextSpan(
                  text: "Hire me?",
                  style: TextStyle(color: colorScheme.primary),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 20 : 30),

          Text(
            "I specialize in building and maintaining large-scale, high-performance applications like inspra.ai. I focus on writing clean, scalable code, seamless API integrations, and intuitive user experiences. From solving complex technical challenges to optimizing app performance, I turn bold ideas into stable, production-ready products.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              // Slightly smaller font on mobile
              fontSize: isMobile ? 16 : 18,
              height: 1.6,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: isMobile ? 30 : 50),

          // Stats Row
          Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              _buildStat("10+", "Project Completed", colorScheme, isMobile: isMobile),
              // Add more stats here later if you want!
            ],
          ),

          SizedBox(height: isMobile ? 30 : 50),

          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => const HireMeDialog(),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              side: BorderSide(color: colorScheme.onSurface, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              "Hire me",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- STAT HELPER ---
  Widget _buildStat(String number, String label, ColorScheme colorScheme, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: isMobile ? 30 : 36,
            fontWeight: FontWeight.w900,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}