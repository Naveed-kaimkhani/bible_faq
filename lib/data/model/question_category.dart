class QuestionCategory {
  int? catId;
  String? image;
  String? name;

  QuestionCategory({this.catId, this.image, this.name});

  factory QuestionCategory.fromJson(Map<String, dynamic> json) {
    return QuestionCategory(
      catId: json['cat_id'] is int
          ? json['cat_id']
          : int.tryParse(json['cat_id'].toString()) ?? 0, // Safely parse cat_id
      image: json['image'] as String?,
      name: json['name'] ?? json['Name'], // Support both `name` and `Name`
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'image': image,
      'name': name,
    };
  }
}
