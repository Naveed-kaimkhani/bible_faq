import 'dart:convert';

class QuestionCategory {
  // Properties
  int? catId;
  String? image;
  String? name;

  // Constructor
  QuestionCategory({this.catId, this.image, this.name});

  // Factory constructor for JSON deserialization
  factory QuestionCategory.fromJson(Map<String, dynamic> json) {
    return QuestionCategory(
      catId: json['cat_id'] as int?,
      image: json['image'] as String?,
      name: json['Name'] as String?,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'image': image,
      'Name': name,
    };
  }}