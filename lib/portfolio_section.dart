import 'package:flutter/material.dart';
import 'package:porfolio/project_timeline.dart';
import 'Controller.dart';
import 'all_projetcs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/modelclass.dart';



// 1. Keep your provider at the top of the file just like you had it!
// final projectsProvider = Provider<List<Project>>((ref) { ... });

class PortfolioSection extends ConsumerStatefulWidget {
  const PortfolioSection({super.key});

  @override
  ConsumerState<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends ConsumerState<PortfolioSection> {
  // We'll make this nullable so we can dynamically adjust the viewport fraction
  PageController? _pageController;
  int _currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check screen size
    final isMobile = MediaQuery.of(context).size.width < 800;

    // On mobile, show more of the card (90%). On desktop, 80% looks great.
    final expectedFraction = isMobile ? 0.9 : 0.8;

    if (_pageController == null || _pageController!.viewportFraction != expectedFraction) {
      int initialPage = 0;
      if (_pageController != null && _pageController!.hasClients) {
        initialPage = _pageController!.page?.round() ?? 0;
        _pageController!.dispose();
      }
      _pageController = PageController(viewportFraction: expectedFraction, initialPage: initialPage);
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(projectsProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Detect mobile screen
    final isMobile = MediaQuery.of(context).size.width < 800;

    if (projects.isEmpty) return const SizedBox.shrink();

    final currentProject = projects[_currentPage];

    return Container(
      // 1. Adjust outer padding for mobile
      padding: EdgeInsets.symmetric(
          vertical: isMobile ? 50 : 80,
          horizontal: isMobile ? 15 : 40
      ),
      child: Column(
        children: [
          // 2. Responsive Header
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeaderTitle(theme, colorScheme, isMobile: true),
                const SizedBox(height: 20),
                _buildSeeAllButton(colorScheme, projects),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderTitle(theme, colorScheme, isMobile: false),
                _buildSeeAllButton(colorScheme, projects),
              ],
            ),

          SizedBox(height: isMobile ? 30 : 50),

          // 3. Responsive Carousel Height
          SizedBox(
            height: isMobile ? 250 : 400,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) => setState(() => _currentPage = page),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectDetailTimeline(project: currentProject))
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isMobile ? 20 : 30),
                      color: colorScheme.surfaceContainerHighest,
                      image: DecorationImage(
                        image: AssetImage(project.coverImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: isMobile ? 20 : 40,
                          left: isMobile ? 20 : 40,
                          right: 20, // Prevents text from overflowing the right edge
                          child: Text(
                            project.title,
                            style: theme.textTheme.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 24 : null, // Scale font down
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Carousel Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(projects.length, (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            )),
          ),
          SizedBox(height: isMobile ? 30 : 50),

          // Categories Chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: currentProject.categories.map((cat) => Chip(
              label: Text(cat, style: TextStyle(fontSize: isMobile ? 12 : 14)),
              backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 10 : 15,
                  vertical: isMobile ? 8 : 10
              ),
            )).toList(),
          ),
          SizedBox(height: isMobile ? 40 : 60),

          // Bottom Project Details
          Column(
            children: [
              // 4. Wrap Title & Subtitle so it doesn't break on small screens
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 15,
                runSpacing: 10,
                children: [
                  Text(
                    isMobile
                        ? currentProject.title // Only show title on mobile first line
                        : "${currentProject.title} - ${currentProject.subtitle}",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      fontSize: isMobile ? 24 : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProjectDetailTimeline(project: currentProject))
                    ),
                    child: CircleAvatar(
                      backgroundColor: colorScheme.primary,
                      radius: isMobile ? 16 : 20,
                      child: Icon(Icons.north_east, color: Colors.white, size: isMobile ? 16 : 20),
                    ),
                  ),
                ],
              ),
              // Show subtitle underneath on mobile to save horizontal space
              if (isMobile) ...[
                const SizedBox(height: 10),
                Text(
                  currentProject.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary
                  ),
                ),
              ],
              const SizedBox(height: 20),

              // 5. Replace absolute width with ConstrainedBox
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  currentProject.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 6. Replace absolute width with ConstrainedBox
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Container(
                    height: 1,
                    width: double.infinity,
                    color: colorScheme.onSurface.withValues(alpha: 0.1)
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Helper for the rich text title
  Widget _buildHeaderTitle(ThemeData theme, ColorScheme colorScheme, {required bool isMobile}) {
    return RichText(
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
      text: TextSpan(
        style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 36 : 42,
            color: colorScheme.onSurface
        ),
        children: [
          const TextSpan(text: "Lets have a look at\nmy "),
          TextSpan(text: "Portfolio", style: TextStyle(color: colorScheme.primary)),
        ],
      ),
    );
  }

  // Helper for the See All Button
  Widget _buildSeeAllButton(ColorScheme colorScheme, List<Project> projects) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllProjectsScreen(projects: projects),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text("See All", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}