import 'package:bible_faq/services/api_services/api_manager.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sql.dart';

class QuestionProviderAPI extends GetxController {
  final QuestionsRepository _repository = QuestionsRepository.instance;

  // Observable states
  var isLoading = true.obs;
  var isNetworkError = false.obs;
  var apiResponse = {}.obs; // Holds the raw API response for requestGet
  var hasNewData = false.obs;
  var downloadProgress = 0.0.obs; // Track download progress
  //  int processedItems = 0;
  Future<void> fetchAndUpdateDataDynamically() async {
    try {
      downloadProgress.value = 0.0;
      // Step 1: Fetch the latest values from SQLite database
      final latestValues = await _fetchLatestDatabaseValues();
      final latestCatId = latestValues['latestCatId'] ?? 0;
      final latestQId = latestValues['latestQId'] ?? 0;
      final totalCount = latestValues['totalCount'] ?? 0;

      debugPrint(
          "Latest Cat ID: $latestCatId, Latest QID: $latestQId, Total Count: $totalCount");

      final response = await _fetchNewDataFromApi(
        latestCatId: latestCatId,
        latestQId: latestQId,
        totalCount: totalCount,
      );
      debugPrint(response.toString());
      if (response == null || response.isEmpty) {
        Get.back();
        _showSnackbar("Info", "Your app is already updated. Lord bless you!");
        return;
      } else {
        await _processApiResponse(response);
      }
    } catch (e) {
      isLoading = false.obs;
      Get.back();
      _showSnackbar("Error", "An error occurred: $e");
    }
  }

  /// Fetch the latest values from the database
  Future<Map<String, dynamic>> _fetchLatestDatabaseValues() async {
    final db = await _repository.database;

    final latestCatResult =
        await db.rawQuery('SELECT MAX(cat_id) as maxCatId FROM category');
    final latestQIdResult =
        await db.rawQuery('SELECT MAX(q_id) as maxQId FROM questions');
    final totalCountResult =
        await db.rawQuery('SELECT COUNT(*) as totalCount FROM questions');

    return {
      'latestCatId': latestCatResult.first['maxCatId'],
      'latestQId': latestQIdResult.first['maxQId'],
      'totalCount': totalCountResult.first['totalCount'],
    };
  }

  /// Make an API call to fetch new data
  Future<Map<String, dynamic>?> _fetchNewDataFromApi({
    required int latestCatId,
    required int latestQId,
    required int totalCount,
  }) async {
    return await APIManager.shared.requestGetMethodForAllQuestion(
      latestCatId: latestCatId,
      latestQId: latestQId,
      totalCount: totalCount,
    );
  }

  /// Process and update the database with API response
  Future<void> _processApiResponse(Map<String, dynamic> response) async {
    // Extract data from response
    final data = response['response'] ?? {};
    final questions = data['question_data'] ?? [];
    debugPrint("question length: ${questions.length}");
    if (questions.length == 0) {
      Get.back();
      _showSnackbar("Info", "Your app is already updated. Lord bless you!");
      return;
    } else {
      await updateDatabaseWithResponse(response);
    }
  }

  /// Show a Snackbar
  void _showSnackbar(String title, String message) {
    Get.snackbar(title, message);
  }

  /// Update database with API response
  Future<void> updateDatabaseWithResponse(Map<String, dynamic> response) async {
    final db = await _repository.database;
    final data = response['response'] ?? {};
    final categories = data['category_data'] ?? [];
    final questions = data['question_data'] ?? [];
    final categoryQuestions = data['category_question_data'] ?? [];

    hasNewData = true.obs;

    // Insert or update categories
    for (var category in categories) {
      await db.insert(
        'category',
        {
          'cat_id': category['cat_id'],
          'Name': category['Name'],
          'image': category['image'],
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    downloadProgress.value = 10.0;
    // Insert or update category_questions
    for (var catQuestion in categoryQuestions) {
      int result = await db.insert(
        'category_questions',
        {
          'q_id': catQuestion['q_id'],
          'cat_id': catQuestion['cat_id'],
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      debugPrint("category_questions result: $result");
      if (result != 0) {
        hasNewData = true.obs;
      }
    }

    downloadProgress.value = 50.0;
    for (var question in questions) {
      await db.insert(
        'questions',
        {
          'q_id': question['q_id'],
          'question': question['question'],
          'book': question['book'],
          'verse': question['verse'],
          'answer': question['answer'],
          'hits': question['hits'],
          'timestamp': question['timestamp'],
          'website_id': question['website_id'],
          'image': question['image'],
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      debugPrint("question result: ");
    }
    debugPrint("db updated");
    downloadProgress.value = 100.0;

    Get.put(QuestionsProviderSql());
    Get.back();

    if (hasNewData.value) {
      Get.snackbar(
        "Update Successful",
        "New Question Added.",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "No Updates",
        "No new data found.",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

// Method to get the number of questions in a specific category by catId
  Future<int> getQuestionCountByCatId(int catId) async {
    final db = await _repository.database;

    // Query to fetch unique q_ids associated with the cat_id
    final result = await db.rawQuery(
      '''
    SELECT q_id 
    FROM category_questions 
    WHERE cat_id = ? 
      AND q_id NOT IN (
        SELECT q_id 
        FROM category_questions 
        GROUP BY q_id 
        HAVING COUNT(cat_id) > 1
      )
    ''',
      [catId],
    );

    // Return the count of unique q_ids for this category
    return result.length;
  }

  @override
  void onInit() {
    super.onInit();
    // Automatically fetch and update data when the controller is initialized
    fetchAndUpdateDataDynamically();
  }
}
