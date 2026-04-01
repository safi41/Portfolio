import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'Controller.dart';
import 'all_projetcs.dart';
import 'hire_me dialog.dart';

// Assuming your provider is still defined here or imported
final profileImageProvider = StateProvider<String>((ref) => 'assets/dummy.png');
final isHoveredProvider = StateProvider<bool>((ref) => false);

class HoverHeroButtons extends ConsumerStatefulWidget {
  const HoverHeroButtons({super.key});

  @override
  ConsumerState<HoverHeroButtons> createState() => _HoverHeroButtonsState();
}

class _HoverHeroButtonsState extends ConsumerState<HoverHeroButtons> {
  // Only track what is clicked. Hover state is now handled by the container.
  String _selectedButton = "portfolio";

  // Helper to update the Riverpod image state based on container hover
  void _updateImageState({required bool isHoveringContainer}) {
    // 1. Tell the app to zoom in or out
    ref.read(isHoveredProvider.notifier).state = isHoveringContainer;

    // 2. Change the image
    if (isHoveringContainer) {
      ref.read(profileImageProvider.notifier).state = 'assets/dummy2.png';
    } else {
      ref.read(profileImageProvider.notifier).state =
      _selectedButton == "hire" ? 'assets/dummy2.png' : 'assets/dummy.png';
    }
  }

  void _onTap(String button) {
    debugPrint("clicked: $button");

    setState(() {
      _selectedButton = button;
    });

    if (button == "portfolio") {
      // 1. Read the list of projects directly from Riverpod!
      final allProjects = ref.read(projectsProvider);

      // 2. Pass it to your screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllProjectsScreen(projects: allProjects),
        ),
      );

    } else if (button == "hire") {
      showDialog(
        context: context,
        builder: (context) => const HireMeDialog(), // Your new dialog!
      ).then((_) {
        setState(() {
          _selectedButton = "portfolio";
        });
        ref.read(profileImageProvider.notifier).state = 'assets/dummy.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 1. ONE MouseRegion wraps the entire container
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.opaque,
      onEnter: (_) => _updateImageState(isHoveringContainer: true),
      onExit: (_) => _updateImageState(isHoveringContainer: false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButton(
                  id: "portfolio",
                  label: "Portfolio",
                  icon: Icons.north_east,
                  isActive: _selectedButton == "portfolio",
                  colors: colorScheme,
                ),
                const SizedBox(width: 5),
                _buildButton(
                  id: "hire",
                  label: "Hire me",
                  icon: null,
                  isActive: _selectedButton == "hire",
                  colors: colorScheme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String id,
    required String label,
    required IconData? icon,
    required bool isActive,
    required ColorScheme colors,
  }) {
    // 1. Use GestureDetector instead of InkWell
    return GestureDetector(
      onTap: () => _onTap(id),
      // 2. Crucial fix: Forces the transparent background to catch taps
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  icon,
                  size: 18,
                  color: isActive ? Colors.white : Colors.black87,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}