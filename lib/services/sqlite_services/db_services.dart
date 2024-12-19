import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

Future<Database> loadDatabase() async {
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
void fetchQuestions() async {
  final db = await loadDatabase();

  // Example query
  final List<Map<String, dynamic>> questions = await db.query('Questions');

  // Print results
  for (var question in questions) {
    print(question);
  }
}
