import 'dart:convert';

class Questions {
  // Properties
  String? answer;
  String? book;
  int? hits;
  int? qId;
  String? question;
  String? timestamp;
  String? verse;

  // Constructor
  Questions({
    this.answer,
    this.book,
    this.hits,
    this.qId,
    this.question,
    this.timestamp,
    this.verse,
  });

  // Factory constructor for JSON deserialization
  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      answer: json['answer'] as String?,
      book: json['book'] as String?,
      hits: json['hits'] as int?,
      qId: json['q_id'] as int?,
      question: json['question'] as String?,
      timestamp: json['timestamp'] as String?,
      verse: json['verse'] as String?,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'book': book,
      'hits': hits,
      'q_id': qId,
      'question': question,
      'timestamp': timestamp,
      'verse': verse,
    };
  }
}