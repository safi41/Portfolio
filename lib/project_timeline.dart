import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models/modelclass.dart';

class ProjectDetailTimeline extends StatefulWidget {
  final Project project;

  const ProjectDetailTimeline({super.key, required this.project});

  @override
  State<ProjectDetailTimeline> createState() => _ProjectDetailTimelineState();
}

class _ProjectDetailTimelineState extends State<ProjectDetailTimeline> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _rotationNotifier = ValueNotifier(0.0);

  late AnimationController _snapController;
  late Animation<double> _snapAnimation;

  @override
  void initState() {
    super.initState();
    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _snapController.addListener(() {
      _rotationNotifier.value = _snapAnimation.value;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _snapController.dispose();
    _rotationNotifier.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification && notification.scrollDelta != null) {
      if (_snapController.isAnimating) {
        _snapController.stop();
      }
      _rotationNotifier.value += notification.scrollDelta! * 0.015;
    } else if (notification is ScrollEndNotification) {
      double currentRotation = _rotationNotifier.value;
      double targetRotation = (currentRotation / (2 * math.pi)).round() * (2 * math.pi);

      _snapAnimation = Tween<double>(begin: currentRotation, end: targetRotation).animate(
          CurvedAnimation(parent: _snapController, curve: Curves.easeOutBack)
      );
      _snapController.forward(from: 0.0);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final timeline = widget.project.timeline;

    // 1. Determine if the device is mobile-sized
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: SingleChildScrollView(
              controller: _scrollController,
              // 2. Adjust outer padding based on screen size
              padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 80 : 60,
                  horizontal: isMobile ? 20 : 100
              ),
              child: Column(
                children: [
                  Text(
                    widget.project.title,
                    textAlign: TextAlign.center,
                    // 3. Scale down the title text on mobile
                    style: (isMobile ? theme.textTheme.headlineMedium : theme.textTheme.displayMedium)
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: isMobile ? 40 : 100),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: timeline.length,
                    itemBuilder: (context, index) {
                      bool isEven = index % 2 == 0;
                      bool isLast = index == timeline.length - 1;
                      final step = timeline[index];

                      // 4. Mobile Layout vs Desktop Layout
                      if (isMobile) {
                        return IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildLeftTimeline(isLast, colorScheme),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildDescriptionCard(step, colorScheme, isMobile: true),
                                      _buildImageCard(step.imagePath, colorScheme, index, isMobile: true),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: isEven
                                    ? _buildDescriptionCard(step, colorScheme, isMobile: false)
                                    : _buildImageCard(step.imagePath, colorScheme, index, isMobile: false),
                              ),
                              _buildCenterTimeline(isLast, colorScheme),
                              Expanded(
                                child: isEven
                                    ? _buildImageCard(step.imagePath, colorScheme, index, isMobile: false)
                                    : _buildDescriptionCard(step, colorScheme, isMobile: false),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
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

  Widget _buildDescriptionCard(TimelineStep step, ColorScheme colors, {required bool isMobile}) {
    return Container(
      // 5. Reduce padding significantly for mobile
      padding: EdgeInsets.all(isMobile ? 0 : 30),
      margin: EdgeInsets.only(bottom: isMobile ? 16 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            step.title,
            style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 15),
          Text(
            step.description,
            style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                height: 1.6,
                color: colors.onSurface.withValues(alpha: 0.6)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath, ColorScheme colors, int index, {required bool isMobile}) {
    final double spinDirection = index % 2 == 0 ? 1.0 : -1.0;

    return ValueListenableBuilder<double>(
      valueListenable: _rotationNotifier,
      builder: (context, rotation, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(rotation * spinDirection),
          child: child,
        );
      },
      child: Container(
        // 6. Reduce margin and height on mobile so it doesn't take up the whole screen
        margin: EdgeInsets.all(isMobile ? 0 : 20),
        height: isMobile ? 250 : 450,
        alignment: isMobile ? Alignment.centerLeft : Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: colors.onSurface.withValues(alpha: 0.15),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                color: colors.onSurface.withValues(alpha: 0.1),
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Desktop center timeline
  Widget _buildCenterTimeline(bool isLast, ColorScheme colors) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
          ),
          if (!isLast)
            Expanded(
              child: VerticalDivider(
                color: colors.onSurface.withValues(alpha: 0.2),
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
            ),
        ],
      ),
    );
  }

  // 7. New Left-aligned timeline specifically for mobile
  Widget _buildLeftTimeline(bool isLast, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
        width: 20,
        child: Column(
          children: [
            Container(
              width: 20,
              height: 20,
              // Added a slight top margin to align the dot with the title text
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
            ),
            if (!isLast)
              Expanded(
                child: VerticalDivider(
                  color: colors.onSurface.withValues(alpha: 0.2),
                  thickness: 2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}