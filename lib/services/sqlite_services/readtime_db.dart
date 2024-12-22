import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'questions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE read_time (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        q_id TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertQuestion(String qId, String timestamp) async {
    final db = await database;
    return await db.insert('read_time', {
      'q_id': qId,
      'timestamp': timestamp,
    });
  }

  Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final db = await database;
    return await db.query('read_time');
  }

  Future<int> deleteQuestion(int id) async {
    final db = await database;
    return await db.delete('read_time', where: 'id = ?', whereArgs: [id]);
  }
  
Future<int> updateQuestion(String qId, String timestamp) async {
  final db = await database;
  return await db.update(
    'questions', // Ensure the table name is correct
    {'timestamp': timestamp}, // Update only the timestamp
    where: 'q_id = ?', // Condition based on q_id
    whereArgs: [qId], // Pass the qId to match
  );
}

}
