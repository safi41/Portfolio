import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class CustomFooter extends StatelessWidget {
  final Function(String) onTabSelected; // <-- ADDED THIS CALLBACK

  const CustomFooter({
    super.key,
    required this.onTabSelected, // <-- Require it in constructor
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Helper text style for the navigation and contact links
    final linkStyle = TextStyle(
      color: colorScheme.onSecondary.withValues(alpha: 0.8),
      fontSize: 14,
      height: 2.0, // Creates the vertical spacing between list items
    );

    // Helper text style for column headers
    final headerStyle = TextStyle(
      color: colorScheme.primary, // The accent color (Orange in design)
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 80),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 1), // Dark background
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TOP SECTION ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lets Connect there",
                style: theme.textTheme.displaySmall?.copyWith(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () => onTabSelected("Hire me"), // <-- HOOKED UP BUTTON
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Hire me", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.north_east, size: 18),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),
          Divider(color: colorScheme.onSecondary.withValues(alpha: 0.5), thickness: 1),
          const SizedBox(height: 50),

          // --- MIDDLE SECTION (4 COLUMNS) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1: Brand & Info
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorScheme.primary,
                          radius: 18,
                          child: Text(
                            "Su",
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Sufian Khan",
                          style: TextStyle(
                            color: colorScheme.onSecondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(
                        "I build fast, reliable, and beautiful apps using Flutter. With over 3 years of hands-on experience, I specialize in turning complex ideas into scalable digital products that users love and businesses trust. Let's build something exceptional.",
                        style: TextStyle(
                          color: colorScheme.onSecondary.withValues(alpha: 0.7),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        _buildLinkedInIcon(
                          colorScheme,
                          "https://www.linkedin.com/in/sufiankhan-jadoon-a54811290", // <-- Must include https://
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Column 2: Navigation
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Navigation", style: headerStyle),
                    const SizedBox(height: 20),
                    // <-- REPLACED STATIC TEXT WITH CLICKABLE LINKS
                    _buildFooterLink("Home", linkStyle),
                    _buildFooterLink("Experience", linkStyle), // Mapped "Resume" to "Experience" to match your navbar
                    _buildFooterLink("Service", linkStyle),
                    _buildFooterLink("Project", linkStyle),
                  ],
                ),
              ),

              // Column 3: Contact
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact", style: headerStyle),
                    const SizedBox(height: 20),
                    Text("+92 3038039292", style: linkStyle),
                    Text("jadoonsufyan3@gmail.com", style: linkStyle),
                  ],
                ),
              ),

              // Column 4: Newsletter
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Get the latest information", style: headerStyle),
                    const SizedBox(height: 20),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(8),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.send,
                                  color: colorScheme.onPrimary,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),
          Divider(color: colorScheme.onSecondary.withValues(alpha: 0.5), thickness: 1),
          const SizedBox(height: 30),

          // --- BOTTOM SECTION ---
          Text(
            "Copyright© 2023 Sufian. All Rights Reserved.",
            style: TextStyle(
              color: colorScheme.onSecondary.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // --- NEW HELPER METHOD FOR CLICKABLE LINKS ---
  Widget _buildFooterLink(String title, TextStyle style) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTabSelected(title), // Triggers scroll when clicked
        child: Text(title, style: style),
      ),
    );
  }

  // Helper method for social icons
  // Widget _buildSocialIcon(IconData icon, ColorScheme colorScheme) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 15),
  //     child: Icon(
  //       icon,
  //       color: colorScheme.onSecondary,
  //       size: 20,
  //     ),
  //   );
  // }

  Widget _buildLinkedInIcon(ColorScheme colorScheme, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Shows the pointer finger on web
      child: GestureDetector(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          // LaunchMode.externalApplication forces it to open in a new tab/browser
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            debugPrint('Could not launch $url');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blueAccent, // Matches your theme
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "in",
            style: TextStyle(
              color: colorScheme.onSecondary, // Inverted color for the text
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'sans-serif', // Gives it that clean LinkedIn look
            ),
          ),
        ),
      ),
    );
  }
}