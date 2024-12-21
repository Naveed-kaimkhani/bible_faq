import 'dart:convert';
import 'dart:io';

import 'package:bible_faq/services/api_services/api_manager.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sql.dart';

class QuestionProviderAPI extends GetxController {
  final QuestionsRepository _repository = QuestionsRepository.instance;

  // Observable states
  var isLoading = false.obs;
  var isNetworkError = false.obs;
  var apiResponse = {}.obs; // Holds the raw API response for requestGet

  /// Method to fetch latest category ID, question ID, and count from database, then call API
  Future<void> fetchAndUpdateDataDynamically() async {
    try {
      isLoading.value = true;

      // Step 1: Fetch the latest values from SQLite database
      final db = await _repository.database;

      // Get the latest `cat_id`, `q_id`, and total count from the database
      final latestCatResult =
          await db.rawQuery('SELECT MAX(cat_id) as maxCatId FROM category');
      final latestQIdResult =
          await db.rawQuery('SELECT MAX(q_id) as maxQId FROM questions');
      final totalCountResult =
          await db.rawQuery('SELECT COUNT(*) as totalCount FROM questions');

      final latestCatId = latestCatResult.first['maxCatId'] ?? 0;
      final latestQId = latestQIdResult.first['maxQId'] ?? 0;
      final totalCount = totalCountResult.first['totalCount'] ?? 0;

      print(
          "Latest Cat ID: $latestCatId, Latest QID: $latestQId, Total Count: $totalCount");

      // Step 2: Pass the latest values to the API call
      final response = await APIManager.shared.requestGetMethodForAllQuestion(
        latestCatId: latestCatId as int,
        latestQId: latestQId as int,
        totalCount: totalCount as int,
      );

      if (response == null) {
        Get.snackbar("Error", "Failed to fetch data from the server.");
        return;
      }

      // Step 3: Update database with the new data
      await updateDatabaseWithResponse(
          response['response'] as Map<String, dynamic>);
    } catch (e) {
      print("Error in fetchAndUpdateDataDynamically: $e");
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Method to call API without database update (requestGet)
  // Future<void> requestGet() async {
  //   try {
  //     isLoading.value = true;

  //     // Fetch data from API
  //     final response = await APIManager.shared.requestGetMethodForAllQuestion();
  //     if (response != null) {
  //       apiResponse.value = response; // Store response for UI or testing
  //       print("Fetched Response: $response");
  //     } else {
  //       Get.snackbar("Error", "Failed to fetch data from the server.");
  //     }
  //   } catch (e) {
  //     print("Error in requestGet: $e");
  //     isNetworkError.value = true;
  //     Get.snackbar("Error", "Failed to fetch data: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // /// Method to fetch API data and update the database (fetchAndUpdateData)
  // Future<void> fetchAndUpdateData() async {
  //   try {
  //     isLoading.value = true;

  //     // Fetch data from API
  //     final response = await APIManager.shared.requestGetMethodForAllQuestion();
  //     print("Fetched Response for Update: $response");

  //     if (response == null) {
  //       Get.snackbar("Error", "Failed to fetch data from the server.");
  //       return;
  //     }

  //     // Update database with the fetched data
  //     await updateDatabaseWithResponse(
  //         response['response'] as Map<String, dynamic>);
  //   } catch (e) {
  //     print("Error in fetchAndUpdateData: $e");
  //     Get.snackbar("Error", "An error occurred: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  /// Update database with API response
  Future<void> updateDatabaseWithResponse(Map<String, dynamic> response) async {
    final db = await _repository.database;

    // Access the 'response' key first
    final data = response['response'] ?? {};
    final categories = data['category_data'] ?? [];
    final questions = data['question_data'] ?? [];
    final categoryQuestions = data['category_question_data'] ?? [];

    bool hasNewData = false;

    print("Starting database update...");
    print("Categories to process: ${categories.length}");
    print("Questions to process: ${questions.length}");
    print("Category Questions to process: ${categoryQuestions.length}");

    // Insert or update categories
    for (var category in categories) {
      int result = await db.insert(
        'category',
        {
          'cat_id': category['cat_id'],
          'Name': category['Name'],
          'image': category['image'],
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      if (result != 0) {
        hasNewData = true;
        print(
            "New category added: ${category['Name']} (ID: ${category['cat_id']})");
      }
    }

    // Insert or update questions
    for (var question in questions) {
      int result = await db.insert(
        'questions',
        {
          'q_id': question['q_id'],
          'question': question['question'],
          'book': question['book'],
          'verse': question['verse'],
          'answer': question['answer'],
          'hits': question['hits'],
          'timestamp': question['timestamp'],
          'image': question['image'], // Add if applicable
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      if (result != 0) {
        hasNewData = true;
        print(
            "New question added: ${question['question']} (ID: ${question['q_id']})");
      }
    }

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
      if (result != 0) {
        hasNewData = true;
        print(
            "New category-question relationship added: Question ID: ${catQuestion['q_id']}, Category ID: ${catQuestion['cat_id']}");
      }
    }

    // Show Snackbar based on update status
    if (hasNewData) {
      print("Database update complete. New data has been added.");
      Get.snackbar(
        "Update Successful",
        "New data has been added to the database.",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      print("Database update complete. No new data found.");
      Get.snackbar(
        "No Updates",
        "No new data found.",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Automatically fetch and update data when the controller is initialized
    fetchAndUpdateDataDynamically();
    // requestGet();

    // Keep `requestGet` method available for manual calls
  }
}
