

class ExpertiseCard {
  final String title;
  final String subtitle;
  final String description;
   String? imageUrl;  // Now this will be a network URL

  ExpertiseCard({
    required this.title,
    required this.subtitle,
    required this.description,
     this.imageUrl,
  });
}