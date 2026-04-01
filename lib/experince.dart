import 'package:flutter/material.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Detect if the screen is mobile
    final isMobile = MediaQuery.of(context).size.width < 800;

    // Timeline Data
    final List<Map<String, dynamic>> experiences = [
      {
        "company": "Codematics (Urran)",
        "date": "Nov 2023 - Jan 2024",
        "role": "Flutter Intern",
        "desc": "Gained foundational hands-on experience in cross-platform mobile development using Flutter. Built responsive UIs and learned modern state management techniques.",
        "isHighlighted": false,
      },
      {
        "company": "DECODE",
        "date": "Jan 2024 - Mar 2024",
        "role": "Flutter Intern",
        "desc": "Further honed my Flutter skills by collaborating on real-world projects. Focused on debugging, API integrations, and improving overall application performance.",
        "isHighlighted": false,
      },
      {
        "company": "Codematics, Abbottabad",
        "date": "Aug 2024 - Present",
        "role": "Junior Flutter Developer",
        "desc": "Developing and maintaining scalable mobile and web applications. Collaborating closely with design and backend teams to implement robust features and deliver high-quality digital solutions.",
        "isHighlighted": true,
      },
    ];

    return Container(
      width: double.infinity,
      // 2. Reduce horizontal padding on mobile so it doesn't squish the content
      padding: EdgeInsets.symmetric(
          vertical: isMobile ? 50 : 80,
          horizontal: isMobile ? 20 : 70
      ),
      color: colorScheme.surface,
      child: Column(
        children: [
          // Section Header
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                // 3. Scale down the header text on mobile
                fontSize: isMobile ? 36 : 48,
                color: colorScheme.onSurface,
              ),
              children: [
                const TextSpan(text: "My\n"), // Added line break for mobile safety
                TextSpan(
                  text: "Work Experience",
                  style: TextStyle(color: colorScheme.primary),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 50 : 80),

          // Timeline List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final exp = experiences[index];
              final isLast = index == experiences.length - 1;

              // 4. Render the appropriate layout based on screen size
              if (isMobile) {
                return _buildMobileRow(exp, isLast, colorScheme);
              } else {
                return _buildDesktopRow(exp, isLast, colorScheme);
              }
            },
          ),
        ],
      ),
    );
  }

  // --- DESKTOP LAYOUT (Original 3-Column Split) ---
  Widget _buildDesktopRow(Map<String, dynamic> exp, bool isLast, ColorScheme colorScheme) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side (Company & Date)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Align to right near the timeline
                children: [
                  Text(
                    exp["company"],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exp["date"],
                    style: TextStyle(fontSize: 16, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                  ),
                ],
              ),
            ),
          ),

          // Center Timeline Indicator
          _buildTimelineNode(exp["isHighlighted"], isLast, colorScheme),

          // Right Side (Role & Description)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp["role"],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    exp["desc"],
                    style: TextStyle(fontSize: 15, height: 1.5, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- MOBILE LAYOUT (2-Column Stacked) ---
  Widget _buildMobileRow(Map<String, dynamic> exp, bool isLast, ColorScheme colorScheme) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures the dashed line reaches the bottom
        children: [
          // Left Timeline Indicator
          _buildTimelineNode(exp["isHighlighted"], isLast, colorScheme),

          // Right Side Stacked Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company & Date
                  Text(
                    exp["company"],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exp["date"],
                    style: TextStyle(fontSize: 14, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                  ),
                  const SizedBox(height: 16),

                  // Role & Description
                  Text(
                    exp["role"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: colorScheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exp["desc"],
                    style: TextStyle(fontSize: 14, height: 1.5, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- SHARED TIMELINE NODE ---
  Widget _buildTimelineNode(bool isHighlighted, bool isLast, ColorScheme colorScheme) {
    return SizedBox(
      width: 30,
      child: Column(
        children: [
          // The Circular Node
          Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.onSurface.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHighlighted
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
          // The Dashed Line
          if (!isLast)
            Expanded(
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: DashedLinePainter(
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Custom Painter (remains unchanged)
class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 4, startY = 5;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}