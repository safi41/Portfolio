import 'package:flutter/material.dart';
import 'package:porfolio/project_timeline.dart';

import 'all_projetcs.dart';
import 'models/modelclass.dart';



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/modelclass.dart'; // Adjust import as needed

// A simple Provider is perfect here since the portfolio data is static
final projectsProvider = Provider<List<Project>>((ref) {
  return [
    Project(
      title: "Inspra.ai",
      subtitle: "Enterprise Voice AI & Call Automation",
      description: "A sophisticated B2B SaaS platform delivering 24/7 AI-powered voice agents for global enterprises. I have led the Flutter development and maintenance for 1.5 years, scaling the platform to handle high-volume sales flows and complex CRM integrations.",
      coverImagePath: 'assets/images/inspra/cover.png',
      categories: ["Conversational AI", "B2B SaaS", "Automation", "Flutter Web"],
      timeline: [
        TimelineStep(
            title: "Architecture & Scalability",
            description: "Maintained a robust Flutter architecture designed for enterprise reliability. Optimized the codebase to handle thousands of concurrent AI-driven interactions while ensuring seamless state management across complex user flows.",
            imagePath: 'assets/images/inspra/step1.webp'
        ),
        TimelineStep(
            title: "Voice Agent Configuration",
            description: "Engineered intuitive dashboards that allow businesses to define 'AI Personas' and custom sales logic. Built dynamic forms that translate high-level business goals into precise AI conversation parameters.",
            imagePath: 'assets/images/inspra/step2.webp'
        ),
        TimelineStep(
            title: "Real-Time Call Analytics",
            description: "Developed live monitoring systems that provide instant visibility into ongoing AI calls. Integrated data visualization tools to display lead qualification metrics and sentiment analysis in real-time.",
            imagePath: 'assets/images/inspra/step3.webp'
        ),
        TimelineStep(
            title: "CRM & Workflow Bridging",
            description: "Architected the front-end logic for deep API integrations with major CRM platforms. Automated the transfer of call summaries, meeting data, and lead status to ensure a zero-friction sales pipeline.",
            imagePath: 'assets/images/inspra/step4.webp'
        ),
        TimelineStep(
            title: "Automated Lead Management",
            description: "Built the interface for intelligent appointment scheduling and lead re-engagement. The system handles instant meeting bookings and rescheduling, removing manual effort from the sales cycle.",
            imagePath: 'assets/images/inspra/step5.webp'
        ),
        TimelineStep(
            title: "Global UI/UX Optimization",
            description: "Refined the user interface for a global audience, focusing on high-speed rendering and accessibility. Ensured the platform delivers a professional, polished experience across mobile and web platforms.",
            imagePath: 'assets/images/inspra/step2.webp'
        ),
        TimelineStep(
            title: "1.5 Years of Innovation",
            description: "Provided long-term technical leadership through continuous feature releases, security audits, and performance tuning. Successfully transitioned the platform through multiple generations of AI model updates.",
            imagePath: 'assets/images/inspra/step1.webp'
        ),
      ],
    ),
    Project(
      title: "My.Zikr",
      subtitle: "Build faith. Connect minds. Grow together.",
      description: "A full-stack, community-driven Islamic companion app built for a client. It features a real-time social feed, an AI-powered conversational bot for personalized prayer recommendations, and a premium subscription model.",
      coverImagePath: 'assets/images/dahim/cover.png', // Replace with your image path (e.g., the wall of duas image)
      categories: ["Mobile App", "AI Integration", "Firebase", "In-App Purchases"],
      timeline: [
        TimelineStep(
            title: "The Vision & Authentication",
            description: "The client needed a secure, scalable platform. I integrated Firebase Auth to handle seamless user onboarding, ensuring private and safe access to the app's core features.",
            imagePath: 'assets/images/dahim/zikr_login.webp' // Replace with Auth image
        ),
        TimelineStep(
            title: "Intuitive App Navigation",
            description: "Designed a clean, accessible navigation menu allowing users to seamlessly transition between their personal tools—like their diary and reminders—and community features.",
            imagePath: 'assets/images/dahim/zikr_menu.webp' // <-- NEW: Navigation Menu Image
        ),
        TimelineStep(
            title: "Community Social Feed",
            description: "Engineered a 'Wall of Douas' mirroring a social media feed. Users can post prayers based on location or theme, and the community supports them by tapping 'Amine'—a custom interaction system replacing traditional 'likes'.",
            imagePath: 'assets/images/dahim/zikr_feed.webp' // Replace with Wall of Douas image
        ),
        TimelineStep(
            title: "AI Conversational Bot",
            description: "Integrated an intelligent chatbot that allows users to communicate their feelings (e.g., Anxiety, Sadness). The AI instantly retrieves and recommends highly relevant, authentic Duas from Hisnul Muslim and the Quran.",
            imagePath: 'assets/images/dahim/zikr_ai.webp' // Replace with the AI Chat image
        ),
        TimelineStep(
            title: "Media Player & Features",
            description: "Built a robust audio player for listening to calming Dua recitations. Users can also utilize action menus to favorite, copy, share, and write personal notes on specific prayers.",
            imagePath: 'assets/images/dahim/zikr_player.webp' // Replace with the Media Player image
        ),
        TimelineStep(
            title: "Comprehensive User Settings",
            description: "Developed a centralized settings hub offering deep customization. Users can manage their active subscriptions, adjust audio voice preferences, change languages, and control push notifications.",
            imagePath: 'assets/images/dahim/zikr_setting.webp' // <-- NEW: Settings Image
        ),
        TimelineStep(
            title: "Monetization & Outcome",
            description: "Implemented secure In-App Purchases to unlock 'My.Zikr+', offering users premium guided themes, soothing audio, and an unlimited diary. The final product successfully bridged spiritual growth with modern, scalable tech.",
            imagePath: 'assets/images/dahim/zikr_premium.webp' // Replace with the My.Zikr+ subscription image
        ),
      ],
    ),
    Project(
      title: "Card Maker",
      subtitle: "AI-Powered Design & Seamless RSVP Ecosystem",
      description: "A professional-grade design tool that empowers users to create unique invitation cards via an intuitive editor or an AI Magic Generator. Features a unique web-hosted RSVP system for frictionless guest management.",
      coverImagePath: 'assets/images/cardmaker/cover.png', // Recommend using the main category screen
      categories: ["AI Integration", "Flutter Web", "Cloud RSVP", "In-App Purchases"],
      timeline: [
        TimelineStep(
            title: "AI Magic Generator",
            description: "Developed a prompt-based AI engine that generates high-fidelity, customized card templates. Users describe their event, and the AI instantly provides professional design starting points, solving 'blank canvas' syndrome.",
            imagePath: 'assets/images/cardmaker/ai.webp' // Use the AI prompt/result screen
        ),
        TimelineStep(
            title: "Dynamic Template Architecture",
            description: "Built a scalable category system supporting hundreds of unique themes (Wedding, Ramadan, Corporate). Engineered an efficient asset management system to ensure high-speed rendering of diverse graphic styles.",
            imagePath: 'assets/images/cardmaker/menu.webp' // Use the categories grid screen
        ),
        TimelineStep(
            title: "The High-Precision Editor",
            description: "Developed a desktop-level mobile editor featuring multi-layer management, real-time font scaling, color pickers, and sticker integration. Optimized for touch precision and creative flexibility.",
            imagePath: 'assets/images/cardmaker/editor.webp' // Use the editor UI screen
        ),
        TimelineStep(
            title: "RSVP Ecosystem",
            description: "Created a robust guest management system where hosts generate unique invite links. Hosts can track real-time attendance, total guest counts, and specific guest responses directly within the app.",
            imagePath: 'assets/images/cardmaker/rsvp.webp' // Use the RSVP dashboard/form screen
        ),
        TimelineStep(
            title: "Web-Hosted Response Portal",
            description: "Engineered a hybrid bridge where RSVP links open in a web browser. This allows guests to respond instantly without installing the app, significantly increasing response rates through a frictionless UX.",
            imagePath: 'assets/images/cardmaker/webr.webp' // Use a mockup of the web RSVP view
        ),
        TimelineStep(
            title: "Monetization & Pro Features",
            description: "Implemented a tiered subscription model and AI Credit system. 'Card Maker Pro' unlocks 1000+ templates, unlimited high-res downloads, and removes watermarks via secure In-App Purchases.",
            imagePath: 'assets/images/cardmaker/premium.webp' // Use the paywall/subscription screen
        ),
        TimelineStep(
            title: "Production & Play Store Launch",
            description: "Optimized the full-stack codebase for cross-device compatibility and high-performance asset handling. The app is currently live on the Google Play Store, serving as a complete event-management hub.",
            imagePath: 'assets/images/cardmaker/play.webp' // Use the settings or a final product mockup
        ),
      ],
    ),
    Project(
      title: "Menu Grocery Planner",
      subtitle: "Streamlined Meal Planning & Smart Shopping",
      description: "A live mobile application built to simplify weekly meal organization and grocery management. It features an intuitive planner to reduce food waste, dynamic list synchronization, and a premium subscription model for advanced features.",
      coverImagePath: 'assets/images/grocery/cover.png', // Recommend a screenshot of the main planner or list view
      categories: ["Productivity", "Flutter", "UX Design", "In-App Purchases"],
      timeline: [
        TimelineStep(
            title: "The Problem & Concept",
            description: "Users often struggle with disorganized shopping and mid-week food waste. The goal was to build a 'central hub' that bridges the gap between deciding what to eat and knowing what to buy.",
            imagePath: 'assets/images/grocery/M1.webp' // Use the onboarding or splash screen
        ),
        TimelineStep(
            title: "Intuitive Weekly Planner",
            description: "Designed a high-usability calendar interface where users can drag and drop meals for the entire week. This allows for a birds-eye view of nutritional planning and time management.",
            imagePath: 'assets/images/grocery/M2.webp' // Use the Weekly Planner screen
        ),
        TimelineStep(
            title: "Smart Grocery List Management",
            description: "Developed a dynamic list system that allows users to organize items by category. This ensures a faster in-store experience by grouping similar ingredients together automatically.",
            imagePath: 'assets/images/grocery/M3.webp' // Use the Grocery List screen
        ),
        TimelineStep(
            title: "Ingredient Tracking Logic",
            description: "Implemented custom logic to track required ingredients for planned meals. If a meal is added to the planner, the app helps identify which ingredients are missing and need to be purchased.",
            imagePath: 'assets/images/grocery/M4.webp' // Use a screen showing ingredients/details
        ),
        TimelineStep(
            title: "UI/UX for Efficiency",
            description: "Focused on a clean, 'distraction-free' interface. Using a soft color palette and clear typography, I ensured that users could manage their household needs quickly, even while on the go.",
            imagePath: 'assets/images/grocery/M5.webp' // Use a clean UI-focused screen
        ),
        TimelineStep(
            title: "Premium Subscription Integration",
            description: "Integrated Flutter In-App Purchases to offer a 'Pro' version. This unlocks ad-free planning, cloud sync, and advanced meal templates, creating a sustainable revenue stream for the app.",
            imagePath: 'assets/images/grocery/M6.webp' // Use the subscription/premium screen
        ),
        TimelineStep(
            title: "Live Production & Support",
            description: "Successfully launched on the Play Store with a focus on stability and performance. The app provides a practical, real-world solution for users looking for better control over their kitchen organization.",
            imagePath: 'assets/images/grocery/M7.webp' // Use the Settings or Profile screen
        ),
      ],
    ),
  ];
});

// 1. Change StatefulWidget to ConsumerStatefulWidget
class PortfolioSection extends ConsumerStatefulWidget {
  const PortfolioSection({super.key});

  @override
  // 2. Change State to ConsumerState
  ConsumerState<PortfolioSection> createState() => _PortfolioSectionState();
}

// 3. Change State to ConsumerState
class _PortfolioSectionState extends ConsumerState<PortfolioSection> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  // ⚠️ REMOVED THE ENTIRE HARDCODED `final List<Project> projects = [...]` FROM HERE!

  @override
  Widget build(BuildContext context) {
    // 4. NEW: Read the projects dynamically from your Riverpod provider!
    final projects = ref.watch(projectsProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Safety check just in case the list is ever empty
    if (projects.isEmpty) return const SizedBox.shrink();

    final currentProject = projects[_currentPage];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 42, color: colorScheme.onSurface),
                  children: [
                    const TextSpan(text: "Lets have a look at\nmy "),
                    TextSpan(text: "Portfolio", style: TextStyle(color: colorScheme.primary)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Uses the dynamically loaded projects list
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
              ),
            ],
          ),
          const SizedBox(height: 50),

          SizedBox(
            height: 400,
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
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: colorScheme.surfaceContainerHighest,
                      image: DecorationImage(
                        image: AssetImage(project.coverImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 40,
                          left: 40,
                          child: Text(
                            project.title,
                            style: theme.textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 50),

          Wrap(
            spacing: 15,
            children: currentProject.categories.map((cat) => Chip(
              label: Text(cat),
              backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            )).toList(),
          ),
          const SizedBox(height: 60),

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${currentProject.title} - ${currentProject.subtitle}",
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProjectDetailTimeline(project: currentProject))
                    ),
                    child: CircleAvatar(
                      backgroundColor: colorScheme.primary,
                      radius: 20,
                      child: const Icon(Icons.north_east, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 600,
                child: Text(
                  currentProject.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 16, height: 1.6),
                ),
              ),
              const SizedBox(height: 20),
              Container(width: 400, height: 1, color: colorScheme.onSurface.withValues(alpha: 0.1)),
            ],
          )
        ],
      ),
    );
  }
}