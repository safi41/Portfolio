class TimelineStep {
  final String title;
  final String description;
  final String imagePath;

  TimelineStep({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class Project {
  final String title;
  final String subtitle;
  final String description;
  final String coverImagePath;
  final List<String> categories;
  final List<TimelineStep> timeline;

  Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.coverImagePath,
    required this.categories,
    required this.timeline,
  });
}