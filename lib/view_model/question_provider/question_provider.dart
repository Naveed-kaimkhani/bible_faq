import 'package:get/get.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/data/model/question_category.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';

class QuestionsProviderSql extends GetxController {
  final QuestionsRepository _repository = QuestionsRepository.instance;

  // Observable states for categories
  var isCategoriesLoading = false.obs;
  var isCategoriesError = false.obs;

  // Observable states for all questions
  var isAllQuestionsLoading = false.obs;
  var isAllQuestionsError = false.obs;

  // Observable states for latest questions
  var isLatestQuestionsLoading = false.obs;
  var isLatestQuestionsError = false.obs;

  // Data lists
  var categories = <QuestionCategory>[].obs; // Categories list
  var allQuestions = <QuestionData>[].obs; // All questions list
  var latestQuestions = <QuestionData>[].obs; // Latest questions list
  var filteredQuestions =
      <QuestionData>[].obs; // Questions filtered by category

  Future<void> fetchCategories() async {
    try {
      isCategoriesLoading.value = true;
      isCategoriesError.value = false;

      final db = await _repository.database;

      // Fetch raw data
      final result = await db.query('category');

      // Map to Dart model
      categories.value = result.map((json) {
        try {
          return QuestionCategory.fromJson(json);
        } catch (e) {
          Get.snackbar("Error", " Error mapping category: $json, Error: $e");
          throw e;
        }
      }).toList();
    } catch (e) {
      isCategoriesError.value = true;
      Get.snackbar("Error", "Failed to fetch categories: $e");
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<List<QuestionData>> fetchRandomQuestionsFromSameCategory(
      int qid) async {
    try {
      final db = await _repository.database;

      // Step 1: Fetch the category ID for the given question ID
      final catIdResult = await db.query(
        'category_questions',
        where: 'q_id = ?',
        whereArgs: [qid],
        columns: ['cat_id'],
      );
      print("catIdResult: $catIdResult");
      if (catIdResult.isEmpty) {
        return [];
      }

      final catId = catIdResult.first['cat_id'] as int?;
      if (catId == null) {
        return [];
      }
      print("catId: $catId");

      // Step 2: Fetch the q_ids from the category_questions table based on the cat_id
      final qIdsResult = await db.query(
        'category_questions',
        where: 'cat_id = ?',
        whereArgs: [catId],
        columns: ['q_id'],
      );
      print("qIdsResult: $qIdsResult");
      // Step 3: Ensure there are at least 5 q_ids
      if (qIdsResult.isEmpty) {
        return [];
      }
      final randomQIds = List<int>.from(
          qIdsResult.map((e) => e['q_id'] as int)) // Create a mutable list
        ..shuffle() // Shuffle the list
        ..take(5); // Take the first 5 items after shuffling
      print("randomQIds: $randomQIds");
      // Step 5: Fetch the questions corresponding to these random q_ids
      final questionsResult = await db.query(
        'questions',
        where: 'q_id IN (${List.filled(randomQIds.length, '?').join(',')})',
        whereArgs: randomQIds,
      );
      print("questionsResult: $questionsResult");
      // Step 6: Return the list of questions
      return questionsResult.map((question) {
        return QuestionData.fromJson(question);
      }).toList();
    } catch (e) {
      print("Error fetching random questions: $e");
      return [];
    }
  }

  Future<String?> fetchCategoryNameByQid(int qid) async {
    try {
      final db = await _repository.database;

      // Step 1: Retrieve cat_id based on qid from category_question table
      final catIdResult = await db.query(
        'category_questions',
        where: 'q_id = ?',
        whereArgs: [qid],
        columns: ['cat_id'],
      );
      if (catIdResult.isEmpty) {
        Get.snackbar("Not Found", "No category found for q_id: $qid");
        return null;
      }

      final catId = catIdResult.first['cat_id'] as int?;
      if (catId == null) {
        return null;
      }

      // Step 2: Retrieve category name based on cat_id from category table
      final categoryResult = await db.query(
        'category',
        where: 'cat_id = ?',
        whereArgs: [catId],
        columns: ['Name'],
      );
      if (categoryResult.isEmpty) {
        Get.snackbar("Not Found", "No category found for cat_id: $catId");
        return null;
      }

      final categoryName = categoryResult.first['Name'] as String?;
      return categoryName;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch category name: $e");
      return null;
    }
  }

  // Fetch Questions by `cat_id`
  Future<void> fetchQuestionsByCategory(int catId) async {
    try {
      isAllQuestionsLoading.value = true;
      isAllQuestionsError.value = false;

      final db = await _repository.database;

      // Fetch `q_id`s for the given `cat_id`
      final categoryQuestionsResult = await db.query(
        'category_questions',
        where: 'cat_id = ?',
        whereArgs: [catId],
      );

      // Extract `q_id`s
      final qIds = categoryQuestionsResult
          .map((e) {
            return e['q_id'] is int
                ? e['q_id']
                : int.tryParse(e['q_id'].toString());
          })
          .where((id) => id != null)
          .toList();

      // Fetch questions based on `q_id`s
      if (qIds.isNotEmpty) {
        final questionResults = await db.query(
          'questions',
          where: 'q_id IN (${List.filled(qIds.length, '?').join(', ')})',
          whereArgs: qIds,
        );

        filteredQuestions.value =
            questionResults.map((json) => QuestionData.fromJson(json)).toList();
      } else {
        filteredQuestions.clear();
      }
    } catch (e) {
      isAllQuestionsError.value = true;
    } finally {
      isAllQuestionsLoading.value = false;
    }
  }

  // Fetch Latest Questions (Fetch All)
  Future<void> fetchLatestQuestions() async {
    try {
      isLatestQuestionsLoading.value = true;
      isLatestQuestionsError.value = false;

      final db = await _repository.database;

      // Fetch all latest questions sorted by timestamp
      final result = await db.query(
        'questions',
        orderBy: 'timestamp DESC',
      );
        print("result: $result");
      // Map the results to the model
      latestQuestions.value =
          result.map((json) => QuestionData.fromJson(json)).toList();
    } catch (e) {
      isLatestQuestionsError.value = true;
      Get.snackbar("Error", "Failed to fetch latest questions: $e");
    } finally {
      isLatestQuestionsLoading.value = false;
    }
  }

  // Fetch All Questions (Fetch All)
  Future<void> fetchAllQuestions() async {
    try {
      isAllQuestionsLoading.value = true;
      isAllQuestionsError.value = false;

      final db = await _repository.database;

      // Fetch all questions
      final result = await db.query(
        'questions',
        orderBy: 'timestamp DESC',
      );

      allQuestions.value =
          result.map((json) => QuestionData.fromJson(json)).toList();
    } catch (e) {
      isAllQuestionsError.value = true;
      Get.snackbar("Error", "Failed to fetch all questions: $e");
    } finally {
      isAllQuestionsLoading.value = false;
    }
  }

  // Initialization logic
  @override
  void onInit() {
    super.onInit();

    // Preload some data
    fetchLatestQuestions(); // Fetch latest questions
    fetchAllQuestions();
    fetchCategories(); // Fetch categories
  }
}
