class Topic {
  int? catId; // Add catId to the model
  final String title;
  final int count;
  final String imageUrl;

  Topic({
    required this.catId, // catId is required
    required this.title,
    required this.count,
    required this.imageUrl,
  });
}
