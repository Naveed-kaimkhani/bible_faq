import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/data/model/response_model.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:get/get.dart';

class QuestionsProviderSql extends GetxController {
  final QuestionsRepository _repository = QuestionsRepository.instance;

  // Observable states
  var isLoading = false.obs;
  var isError = false.obs;

  // Data lists for questions and answers
  var questions = <QuestionData>[].obs;
  // var answers = <Map<String, dynamic>>[].obs;

  // Fetch all questions
  Future<void> fetchAllQuestions() async {
    try {
      isLoading.value = true;
      isError.value = false;

      // Fetch questions from the repository
      final data = await _repository.fetchQuestions();
      questions.value = data;
    } catch (e) {
      isError.value = false;
      Get.snackbar(
        "Error",
        "Failed to fetch questions: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    fetchAllQuestions();
  }
}
