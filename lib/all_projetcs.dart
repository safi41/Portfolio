import 'package:flutter/material.dart';
import 'package:porfolio/project_timeline.dart';
import 'models/modelclass.dart'; // Make sure this path matches your structure

class AllProjectsScreen extends StatelessWidget {
  final List<Project> projects;

  const AllProjectsScreen({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Determine if the screen is mobile sized (adjust the 800 breakpoint as needed)
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ListView.separated(
                // Added top padding so the list doesn't overlap the back button
                padding: const EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 24),
                itemCount: projects.length,
                separatorBuilder: (context, index) => const SizedBox(height: 32),
                itemBuilder: (context, index) {
                  final project = projects[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailTimeline(project: project),
                        ),
                      );
                    },
                    child: Container(
                      // 2. Remove fixed height on mobile so the column can expand naturally
                      height: isMobile ? null : 280,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: colorScheme.onSurface.withValues(alpha: 0.05),
                        ),
                      ),
                      // 3. Switch between Column (Mobile) and Row (Desktop)
                      child: isMobile
                          ? _buildMobileLayout(project, theme, colorScheme)
                          : _buildDesktopLayout(project, theme, colorScheme),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 20, // Adjusted slightly to look better
            left: 20,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_outlined),
            ),
          ),
        ],
      ),
    );
  }

  // --- RESPONSIVE LAYOUTS ---

  Widget _buildDesktopLayout(Project project, ThemeData theme, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT SIDE: Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 300,
            height: double.infinity,
            child: Image.asset(
              project.coverImagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        // RIGHT SIDE: Details (Wrapped in Expanded for Row)
        Expanded(
          child: _buildProjectDetails(project, theme, colorScheme, isMobile: false),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(Project project, ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Hugs the content tightly
      children: [
        // TOP SIDE: Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: double.infinity,
            height: 200, // Fixed height for image on mobile
            child: Image.asset(
              project.coverImagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // BOTTOM SIDE: Details (No Expanded needed in a flexible Column)
        _buildProjectDetails(project, theme, colorScheme, isMobile: true),
      ],
    );
  }

  // --- SHARED DETAILS WIDGET ---

  Widget _buildProjectDetails(Project project, ThemeData theme, ColorScheme colorScheme, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Use min size so it doesn't try to stretch infinitely on mobile
      mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Text(
          project.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project.subtitle,
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          project.description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.5,
          ),
        ),
        // Use a fixed spacing for mobile, but a Spacer for desktop to push chips to the bottom
        if (isMobile) const SizedBox(height: 16) else const Spacer(),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: project.categories
              .map((cat) => Chip(
            label: Text(
              cat,
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: colorScheme.surface,
            side: BorderSide(
              color: colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ))
              .toList(),
        ),
      ],
    );
  }
}