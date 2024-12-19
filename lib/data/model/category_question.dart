class CategoryQuestion {
  // Properties
  int? catId;
  int? qId;

  // Constructor
  CategoryQuestion({this.catId, this.qId});

  // Factory constructor for JSON deserialization
  factory CategoryQuestion.fromJson(Map<String, dynamic> json) {
    return CategoryQuestion(
      catId: json['cat_id'] as int?,
      qId: json['q_id'] as int?,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'q_id': qId,
    };
  }
}