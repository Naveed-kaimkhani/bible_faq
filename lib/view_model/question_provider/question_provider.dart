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
    print("Raw data fetched from DB: $result");

    // Map to Dart model
    categories.value = result.map((json) {
      try {
        return QuestionCategory.fromJson(json);
      } catch (e) {
        print("Error mapping category: $json, Error: $e");
        throw e;
      }
    }).toList();

    print("Mapped categories: ${categories.map((c) => c.name).toList()}");
  } catch (e) {
    isCategoriesError.value = true;
    print("Error in fetchCategories: $e");
    Get.snackbar("Error", "Failed to fetch categories: $e");
  } finally {
    isCategoriesLoading.value = false;
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
    final qIds = categoryQuestionsResult.map((e) {
      return e['q_id'] is int
          ? e['q_id']
          : int.tryParse(e['q_id'].toString());
    }).where((id) => id != null).toList();

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
    print("Error in fetchQuestionsByCategory: $e");
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

      print("Fetched Latest Questions from DB: $result"); // Debugging log

      // Map the results to the model
      latestQuestions.value =
          result.map((json) => QuestionData.fromJson(json)).toList();

      print("Mapped Latest Questions: $latestQuestions"); // Final list log
    } catch (e) {
      isLatestQuestionsError.value = true;
      print("Error in fetchLatestQuestions: $e");
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
      print("Fetched All Questions: $allQuestions");
    } catch (e) {
      isAllQuestionsError.value = true;
      print("Error in fetchAllQuestions: $e");
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
    fetchCategories(); // Fetch categories
  }
}
