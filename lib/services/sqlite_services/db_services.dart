import 'package:bible_faq/data/model/category_question.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/data/model/question_category.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class QuestionsRepository {
  static Database? _database;

  // Singleton pattern to ensure a single instance of the database
  static final QuestionsRepository instance = QuestionsRepository._internal();

  QuestionsRepository._internal();

  Future<Database> _initDatabase() async {
    // Get the directory for storing the database
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = join(directory.path, "QuestionsAnswers.DB");

    // Check if the database file exists
    if (!await File(dbPath).exists()) {
      // Copy the database from assets
      final data = await rootBundle.load("assets/QuestionsAnswers.DB");
      final bytes = data.buffer.asUint8List();
      await File(dbPath).writeAsBytes(bytes);
    }

    // Open the database
    return openDatabase(dbPath);
  }

  Future<void> insertCategory(QuestionCategory category) async {
    final db = await database;
    Map<String, dynamic> categoryMap = category.toJson();
    await db.insert('category', categoryMap);
  }

  Future<void> insertCategoryQuestion(
      CategoryQuestionData categoryQuestion) async {
    final db = await database;
    Map<String, dynamic> categoryQuestionMap = categoryQuestion.toJson();
    await db.insert('category_questions', categoryQuestionMap);
  }

  Future<void> updateTimestamp(int questionId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the current timestamp
    final currentTimestamp = DateTime.now().toIso8601String();

    // Store the timestamp with the questionId as the key
    await prefs.setString('timestamp_$questionId', currentTimestamp);
  }

  Future<String> getTimestamp(int questionId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String timestamp = prefs.getString('timestamp_$questionId') ?? "";
    if (timestamp.isEmpty) return "";
    DateTime parsedTimestamp = DateTime.parse(timestamp);
    String formattedTimestamp =
        DateFormat('yyyy-MM-dd hh:mm a').format(parsedTimestamp);
    return formattedTimestamp;
  }

  Future<void> insertQuestion(QuestionData question) async {
    final db = await database;
    Map<String, dynamic> questionMap = question.toJson();
    await db.insert('questions', questionMap);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<List<QuestionData>> fetchQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> queryResult = await db.query('Questions');

    // Map the query results into a list of QuestionData
    return queryResult.map((json) => QuestionData.fromJson(json)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchAnswersByQuestionId(
      int questionId) async {
    final db = await database;
    return db.query(
      'Answers',
      where: 'question_id = ?',
      whereArgs: [questionId],
    );
  }
}
