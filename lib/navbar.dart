import 'dart:ui';
import 'package:flutter/material.dart';

class NavHeader extends StatelessWidget {
  final bool isScrolled;
  final String activeTab;
  final Function(String) onTabSelected; // <-- ADD THIS CALLBACK

  const NavHeader({
    super.key,
    required this.isScrolled,
    this.activeTab = "Home",
    required this.onTabSelected, // <-- Require it here
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: isScrolled ? 520 : screenWidth * 0.9,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
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
          mainAxisSize: isScrolled ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildItem(context, "Home", Icons.home, isActive: activeTab == "Home")),
            Expanded(child: _buildItem(context, "Service", Icons.miscellaneous_services, isActive: activeTab == "Service")),
            Expanded(child: _buildItem(context, "Experience", Icons.person, isActive: activeTab == "Experience")),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: isScrolled ? 15 : 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: colorScheme.secondary,
                    child: Image.asset('assets/images/lo.png'),
                  ),
                  if (!isScrolled) ...[
                    const SizedBox(width: 8),
                    const Text(
                      "Sufian",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]
                ],
              ),
            ),

            Expanded(child: _buildItem(context, "Hire me", Icons.work_outline, isActive: activeTab == "Hire me")),
            Expanded(child: _buildItem(context, "Project", Icons.rocket_launch_outlined, isActive: activeTab == "Project")),
            Expanded(child: _buildItem(context, "Contact", Icons.email_outlined, isActive: activeTab == "Contact")),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String label, IconData icon, {bool isActive = false}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: label,
      // 1. Add MouseRegion for Web pointer cursor
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        // 2. Add GestureDetector to trigger the scroll
        child: GestureDetector(
          onTap: () => onTabSelected(label), // Pass the clicked label back to the main page
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: ScaleTransition(scale: animation, child: child));
            },
            child: isScrolled
                ? Padding(
              key: ValueKey("icon_$label"),
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: isActive ? colorScheme.primary : Colors.white,
                size: 22,
              ),
            )
                : Container(
              key: ValueKey("text_$label"),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: isActive
                  ? BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.circular(20))
                  : null,
              child: Text(
                label,
                maxLines: 1,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}