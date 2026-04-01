import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFooter extends StatelessWidget {
  final Function(String) onTabSelected;

  const CustomFooter({
    super.key,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Detect screen size
    final isMobile = MediaQuery.of(context).size.width < 800;

    // Helper text styles
    final linkStyle = TextStyle(
      color: colorScheme.onSecondary.withValues(alpha: 0.8),
      fontSize: 14,
      height: 2.0,
    );

    final headerStyle = TextStyle(
      color: colorScheme.primary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Container(
      width: double.infinity,
      // 2. Reduce massive horizontal padding on mobile
      padding: EdgeInsets.symmetric(
          vertical: 60,
          horizontal: isMobile ? 30 : 80
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 1),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMobile ? 30 : 50),
            topRight: Radius.circular(isMobile ? 30 : 50),
            bottomRight: Radius.circular(isMobile ? 30 : 50),
            bottomLeft: Radius.circular(isMobile ? 30 : 50)
        ),
      ),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          // --- TOP SECTION ---
          // 3. Stack vertically on mobile, row on desktop
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Lets Connect there",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 32, // Smaller font for mobile
                  ),
                ),
                const SizedBox(height: 24),
                _buildHireMeButton(colorScheme),
              ],
            )
          else
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
                _buildHireMeButton(colorScheme),
              ],
            ),

          SizedBox(height: isMobile ? 30 : 40),
          Divider(color: colorScheme.onSecondary.withValues(alpha: 0.5), thickness: 1),
          SizedBox(height: isMobile ? 30 : 50),

          // --- MIDDLE SECTION ---
          // 4. Switch between Column and Row based on screen size
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrandColumn(colorScheme),
                const SizedBox(height: 40),
                _buildNavigationColumn(headerStyle, linkStyle),
                const SizedBox(height: 40),
                _buildContactColumn(headerStyle, linkStyle),
                const SizedBox(height: 40),
                _buildNewsletterColumn(colorScheme, headerStyle),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildBrandColumn(colorScheme)),
                Expanded(flex: 1, child: _buildNavigationColumn(headerStyle, linkStyle)),
                Expanded(flex: 2, child: _buildContactColumn(headerStyle, linkStyle)),
                Expanded(flex: 2, child: _buildNewsletterColumn(colorScheme, headerStyle)),
              ],
            ),

          SizedBox(height: isMobile ? 30 : 50),
          Divider(color: colorScheme.onSecondary.withValues(alpha: 0.5), thickness: 1),
          const SizedBox(height: 30),

          // --- BOTTOM SECTION ---
          Align(
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: Text(
              "Copyright© 2023 Sufian. All Rights Reserved.",
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                color: colorScheme.onSecondary.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPONENT HELPERS ---

  Widget _buildHireMeButton(ColorScheme colorScheme) {
    return ElevatedButton(
      onPressed: () => onTabSelected("Hire me"),
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
    );
  }

  Widget _buildBrandColumn(ColorScheme colorScheme) {
    return Column(
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
          padding: const EdgeInsets.only(right: 20), // Reduced right padding for mobile friendliness
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
              "https://www.linkedin.com/in/sufiankhan-jadoon-a54811290",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigationColumn(TextStyle headerStyle, TextStyle linkStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Navigation", style: headerStyle),
        const SizedBox(height: 20),
        _buildFooterLink("Home", linkStyle),
        _buildFooterLink("Experience", linkStyle),
        _buildFooterLink("Service", linkStyle),
        _buildFooterLink("Project", linkStyle),
      ],
    );
  }

  Widget _buildContactColumn(TextStyle headerStyle, TextStyle linkStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contact", style: headerStyle),
        const SizedBox(height: 20),
        Text("+92 3038039292", style: linkStyle),
        Text("jadoonsufyan3@gmail.com", style: linkStyle),
      ],
    );
  }

  Widget _buildNewsletterColumn(ColorScheme colorScheme, TextStyle headerStyle) {
    return Column(
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
    );
  }

  // --- LINK HELPERS ---

  Widget _buildFooterLink(String title, TextStyle style) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTabSelected(title),
        child: Text(title, style: style),
      ),
    );
  }

  Widget _buildLinkedInIcon(ColorScheme colorScheme, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            debugPrint('Could not launch $url');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "in",
            style: TextStyle(
              color: colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'sans-serif',
            ),
          ),
        ),
      ),
    );
  }
}