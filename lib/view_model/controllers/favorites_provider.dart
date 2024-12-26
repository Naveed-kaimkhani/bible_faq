import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bible_faq/data/model/question.dart';

class FavoritesProvider extends GetxController {
  final QuestionsProviderSql _questionsProvider = Get.find();

  // Observable states
  var isFavoritesLoading = false.obs;
  var isFavoritesError = false.obs;

  // Favorite question IDs and data
  var favoriteQIDs = <String>[].obs; // List of favorite question IDs
  var favoriteQuestions = <QuestionData>[].obs; // List of favorite questions

  var filteredQuestions = <QuestionData>[].obs; // Filtered list
  @override
  void onInit() {
    super.onInit();
    loadFavorites(); // Load favorite IDs on initialization
  }

  // Load favorite question IDs from SharedPreferences
  Future<void> loadFavorites() async {
    try {
      isFavoritesLoading.value = true;
      isFavoritesError.value = false;

      final prefs = await SharedPreferences.getInstance();
      final ids = prefs.getStringList('favoriteQIDs') ?? [];
      favoriteQIDs.value = ids;

      // Update the favoriteQuestions list based on loaded IDs
      updateFavoriteQuestions();
    } catch (e) {
      isFavoritesError.value = true;
      Get.snackbar("Error", "Failed to load favorite questions: $e");
    } finally {
      isFavoritesLoading.value = false;
    }
  }
// Call this method to filter questions
  void filterFavoriteQuestions(String query) {
    if (query.isEmpty) {
      filteredQuestions.value = favoriteQuestions;
    } else {
      filteredQuestions.value = favoriteQuestions
          .where((question) =>
              (question.question ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
  // Toggle favorite status of a question
  Future<void> toggleFavorite(String qid) async {
    final prefs = await SharedPreferences.getInstance();

    if (favoriteQIDs.contains(qid)) {
      favoriteQIDs.remove(qid);
      print("Removed $qid from favorites");
    } else {
      favoriteQIDs.add(qid);
      print("Added $qid to favorites");
    }

    // Save updated list to SharedPreferences
    await prefs.setStringList('favoriteQIDs', favoriteQIDs.toList());

    // Update the favoriteQuestions list
    updateFavoriteQuestions();
  }

  /// Inserts a list of QIDs into SharedPreferences, replacing the existing list.
  Future<void> insertFavoriteQIDs(List<String> qids) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Replace the existing list with the new list of QIDs
      await prefs.setStringList('favoriteQIDs', qids);

      // Update the observable list in the provider
      favoriteQIDs.value = qids;

      // Refresh the favorite questions list
      updateFavoriteQuestions();
    } catch (e) {
      Get.snackbar("Error", "Failed to save favorite questions: $e");
    }
  }

  // Check if a question is a favorite
  bool isFavorite(String qid) => favoriteQIDs.contains(qid);

  // Update the favoriteQuestions list using the allQuestions list
  void updateFavoriteQuestions() {
    final allQuestions = _questionsProvider.allQuestions;
    favoriteQuestions.value = allQuestions
        .where((q) => favoriteQIDs.contains(q.qId.toString()))
        .toList();
  }
}
