import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/api_controller/all_question_provider.dart';
import 'package:get/get.dart';
import 'package:bible_faq/data/model/category_question.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:get/get.dart';
import 'package:bible_faq/data/model/category_question.dart';
import 'package:bible_faq/data/model/question.dart';

class AppInitializationController extends GetxController {
  final QuestionsRepository _repository = QuestionsRepository.instance;
  final QuestionProviderAPI _apiProvider = Get.find<QuestionProviderAPI>();

  Future<void> initializeApp() async {
    // Check if the database is empty
    final isDbEmpty = await _repository.isDatabaseEmpty();

    if (isDbEmpty) {
      Get.snackbar("Fetching Data", "Fetching data from API (First Call)");
      print("Database is empty. Fetching data from API...");
      await _fetchAndStoreData();
    } else {
      Get.snackbar("Fetching Data", "Loading data from SQLite");
      print("Database already has data. Loading from SQLite...");
    }
  }

  Future<void> _fetchAndStoreData() async {
    try {
      // Fetch data from API
      await _apiProvider.requestGet();

      // Use the parsed response data
      final questions = _apiProvider.questions;
      final categoryQuestions = _apiProvider.categoryQuestions;

      // Store questions in the database
      for (var question in questions) {
        await _repository.insertQuestion(question);
      }

      // Store category questions in the database
      for (var categoryQuestion in categoryQuestions) {
        await _repository.insertCategoryQuestion(categoryQuestion);
      }

      print("Data stored successfully.");
    } catch (e) {
      print("Error while fetching or storing data: $e");
    }
  }
}
