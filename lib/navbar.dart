import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Controller.dart';

class NavHeader extends ConsumerWidget {
  final bool isScrolled;
  final String activeTab;
  final Function(String) onTabSelected;

  const NavHeader({
    super.key,
    required this.isScrolled,
    this.activeTab = "Home",
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(isDarkModeProvider);

    final isMobile = screenWidth < 800;
    final showIconsOnly = isScrolled || isMobile;

    final double navWidth = isMobile
        ? screenWidth * 0.95
        : (isScrolled ? 520 : screenWidth * 0.9);

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: navWidth,
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 20, vertical: 10),
        decoration: BoxDecoration(
          // 1. Navbar Background uses 'Secondary'
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            if (isScrolled)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              )
          ],
        ),
        child: Row(
          mainAxisSize: showIconsOnly ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildItem(context, "Home", Icons.home, isActive: activeTab == "Home", showIconsOnly: showIconsOnly)),
            Expanded(child: _buildItem(context, "Service", Icons.miscellaneous_services, isActive: activeTab == "Service", showIconsOnly: showIconsOnly)),
            Expanded(child: _buildItem(context, "Experience", Icons.person, isActive: activeTab == "Experience", showIconsOnly: showIconsOnly)),

            // Center Logo
            Tooltip(
              message: isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode",
              child: InkWell(
                onTap: () {
                  ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: showIconsOnly ? (isMobile ? 5 : 15) : 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: isMobile ? 14 : 15,
                        backgroundColor: Colors.transparent, // Looks cleaner if the image has its own background
                        child: isDarkMode ? Image.asset('assets/images/dark.png') : Image.asset('assets/images/lo.png'),
                      ),
                      if (!showIconsOnly) ...[
                        const SizedBox(width: 8),
                        Text(
                          "Sufian",
                          // Center text uses onSecondary since it sits on the secondary background
                          style: TextStyle(color: colorScheme.onSecondary, fontWeight: FontWeight.bold),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),

            Expanded(child: _buildItem(context, "Hire me", Icons.work_outline, isActive: activeTab == "Hire me", showIconsOnly: showIconsOnly)),
            Expanded(child: _buildItem(context, "Project", Icons.rocket_launch_outlined, isActive: activeTab == "Project", showIconsOnly: showIconsOnly)),
            Expanded(child: _buildItem(context, "Contact", Icons.email_outlined, isActive: activeTab == "Contact", showIconsOnly: showIconsOnly)),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String label, IconData icon, {required bool isActive, required bool showIconsOnly}) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Tooltip(
      message: label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onTabSelected(label),
          behavior: HitTestBehavior.opaque,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: ScaleTransition(scale: animation, child: child));
            },
            child: showIconsOnly
                ? Padding(
              key: ValueKey("icon_$label"),
              padding: EdgeInsets.all(isMobile ? 6.0 : 8.0),
              child: Icon(
                icon,
                // 2. Icon Colors
                // Active: Pops with Primary color
                // Inactive: Faded onSecondary color (60% opacity)
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.onSecondary.withValues(alpha: 0.6),
                size: isMobile ? 20 : 22,
              ),
            )
                : Container(
              key: ValueKey("text_$label"),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: isActive
              // 3. Pill Background is Primary color
                  ? BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.circular(20))
                  : null,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  // 4. Text Colors
                  // Active Text: onPrimary (Dark or White depending on theme)
                  // Inactive Text: Faded onSecondary (80% opacity for text)
                  color: isActive
                      ? colorScheme.onPrimary
                      : colorScheme.onSecondary.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}