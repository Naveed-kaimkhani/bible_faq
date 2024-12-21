// import 'package:bible_faq/data/model/question.dart';
// import 'package:bible_faq/data/model/response_model.dart';
// import 'package:bible_faq/services/sqlite_services/db_services.dart';
// import 'package:get/get.dart';

// class QuestionsProviderSql extends GetxController {
//   final QuestionsRepository _repository = QuestionsRepository.instance;

//   // Observable states
//   var isLoading = false.obs;
//   var isError = false.obs;

//   // Data lists for questions and answers
//   var questions = <QuestionData>[].obs;
//   // var answers = <Map<String, dynamic>>[].obs;

//   // Fetch all questions
//   Future<void> fetchAllQuestions() async {
//     try {
//       isLoading.value = true;
//       isError.value = false;

//       // Fetch questions from the repository
//       final data = await _repository.fetchQuestions();
//       questions.value = data;
//     } catch (e) {
//       isError.value = false;
//       Get.snackbar(
//         "Error",
//         "Failed to fetch questions: $e",
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllQuestions();
//   }
// }

import 'package:bible_faq/data/model/category_question.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/data/model/question_category.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:get/get.dart';

class QuestionsProviderSql extends GetxController {
  final QuestionsRepository _repository = QuestionsRepository.instance;

  // Observable states
  var isLoading = false.obs;
  var isError = false.obs;

  // Data lists
  var categories = <QuestionCategory>[].obs; // For categories
  var filteredQuestions =
      <QuestionData>[].obs; // Questions filtered by category
  var latestQuestions =
      <QuestionData>[].obs; // Latest questions (timestamp-based)

  // 1. Fetch Categories (Top N or All)
  Future<void> fetchCategories({int limit = 5}) async {
    try {
      isLoading.value = true;
      isError.value = false;

      final db = await _repository.database;
      final result = await db.query(
        'category',
        limit: limit > 0 ? limit : null, // Apply limit if greater than 0
      );

      categories.value =
          result.map((json) => QuestionCategory.fromJson(json)).toList();
    } catch (e) {
      isError.value = true;
      Get.snackbar("Error", "Failed to fetch categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 2. Fetch All Categories for Bible Topics Screen
  Future<void> fetchAllCategories() async {
    await fetchCategories(limit: 0); // Fetch all without limit
  }

  // 3. Fetch Questions by `cat_id`
  Future<void> fetchQuestionsByCategory(String catId) async {
    try {
      isLoading.value = true;
      isError.value = false;

      final db = await _repository.database;

      // Step 1: Get `q_id`s linked to the `cat_id` from `category_questions`
      final categoryQuestionsResult = await db.query(
        'category_questions',
        where: 'cat_id = ?',
        whereArgs: [catId],
      );

      // Step 2: Extract the list of `q_id`s
      final qIds =
          categoryQuestionsResult.map((e) => e['q_id'].toString()).toList();

      // Step 3: Fetch all questions with these `q_id`s from the `questions` table
      if (qIds.isNotEmpty) {
        final questionResults = await db.query(
          'questions',
          where: 'q_id IN (${List.filled(qIds.length, '?').join(', ')})',
          whereArgs: qIds,
        );

        filteredQuestions.value =
            questionResults.map((json) => QuestionData.fromJson(json)).toList();
      } else {
        filteredQuestions.clear(); // No questions found for this category
      }
    } catch (e) {
      isError.value = true;
      Get.snackbar("Error", "Failed to fetch questions: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 4. Fetch Latest Questions (Sorted by Timestamp)
  Future<void> fetchLatestQuestions() async {
    try {
      isLoading.value = true;
      isError.value = false;

      final db = await _repository.database;
      final result = await db.query(
        'questions',
        orderBy: 'timestamp DESC', // Sort by latest timestamp
        limit: 3, // Limit to top 3
      );

      latestQuestions.value =
          result.map((json) => QuestionData.fromJson(json)).toList();
    } catch (e) {
      isError.value = true;
      Get.snackbar("Error", "Failed to fetch latest questions: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 5. Fetch Specific Question by `q_id`
  Future<QuestionData?> fetchQuestionById(String qId) async {
    try {
      final db = await _repository.database;
      final result = await db.query(
        'questions',
        where: 'q_id = ?',
        whereArgs: [qId],
      );

      if (result.isNotEmpty) {
        return QuestionData.fromJson(result.first);
      }
    } catch (e) {
      isError.value = true;
      Get.snackbar("Error", "Failed to fetch question: $e");
    }
    return null;
  }

  var allQuestions =
      <QuestionData>[].obs; // Declare allQuestions as an observable

  // Method to fetch all questions
  Future<void> fetchAllQuestions() async {
    try {
      isLoading.value = true;
      isError.value = false;

      final db = await _repository.database;
      final result = await db.query('questions'); // Fetch all rows from the 'questions' table
      print("Fetched Questions: $result"); // Debugging: Log query results

      allQuestions.value = result.map((json) => QuestionData.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching questions: $e"); // Debugging: Log any errors
      isError.value = true;
      Get.snackbar("Error", "Failed to fetch questions: $e");
    } finally {
      isLoading.value = false;
    }
  }
  // Initialization logic
  @override
  void onInit() {
    super.onInit();
    fetchLatestQuestions(); // Automatically fetch the latest questions
    fetchAllQuestions();

    fetchCategories(); // Automatically fetch top categories
  }
}
