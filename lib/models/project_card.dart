// project_card.dart
class ProjectCard {
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> details;

  ProjectCard({
    required this.title,
    required this.description,
    this.imageUrl,
    this.details = const [],
  });
}