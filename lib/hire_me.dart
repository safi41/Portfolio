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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          // --- Left Side: Image & Shape with Zoom Logic ---
          Expanded(
            flex: 4,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              cursor: SystemMouseCursors.click,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // 1. The Orange Shape - Subtle scale & color shift on hover
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    width: _isHovering ? 340 : 320,
                    height: _isHovering ? 420 : 400,
                    decoration: BoxDecoration(
                      color: _isHovering
                          ? colorScheme.primary.withValues(alpha: 0.85)
                          : colorScheme.primary.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),

                  // 2. The Person Image with Zoom and Cross-Fade
                  Positioned(
                    bottom: -20,
                    child: AnimatedScale(
                      // Zoom in by 8% when hovering
                      scale: _isHovering ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutBack,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        // Force a clean cross-fade transition
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          _isHovering ? 'assets/dod.png' : 'assets/dummy.png',
                          key: ValueKey<String>(_isHovering ? 'dod' : 'dummy'),
                          height: 450,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Right Side: Content remains the same ---
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 60, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 52,
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
                  const SizedBox(height: 30),
                  Text(
                    "I specialize in building and maintaining large-scale, high-performance applications like inspra.ai. I focus on writing clean, scalable code, seamless API integrations, and intuitive user experiences. From solving complex technical challenges to optimizing app performance, I turn bold ideas into stable, production-ready products.",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      _buildStat("10+", "Project Completed", colorScheme),
                      const SizedBox(width: 80),
                    ],
                  ),
                  const SizedBox(height: 50),
                  OutlinedButton(
                    onPressed: () {
                      // THIS is how you call the dialog
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String number, String label, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}