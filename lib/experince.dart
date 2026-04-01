import 'package:flutter/material.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Timeline Data
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
      padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 70),
      color: colorScheme.surface,
      child: Column(
        children: [
          // 1. Section Header
          RichText(
            text: TextSpan(
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                color: colorScheme.onSurface, // Dark color for "My"
              ),
              children: [
                const TextSpan(text: "My "),
                TextSpan(
                  text: "Work Experience",
                  style: TextStyle(color: colorScheme.primary), // Orange
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),

          // 2. Timeline List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final exp = experiences[index];
              final isLast = index == experiences.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Left Side (Company & Date) ---
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30, bottom: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align to left edge like the Figma mockup
                          children: [
                            Text(
                              exp["company"],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              exp["date"],
                              style: TextStyle(
                                fontSize: 16,
                                color: colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- Center Timeline Indicator ---
                    SizedBox(
                      width: 30,
                      child: Column(
                        children: [
                          // The Circular Node
                          Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(4), // Creates the white gap
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
                                color: exp["isHighlighted"]
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
                    ),

                    // --- Right Side (Role & Description) ---
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp["role"],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              exp["desc"],
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Custom Painter to draw the perfectly spaced vertical dashed line
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