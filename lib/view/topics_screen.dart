import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/components/last_read_time.dart';
import 'package:bible_faq/constants/app_images.dart';
import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/data/model/question_category.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicsScreen extends StatelessWidget {
  final provider = Get.find<QuestionsProviderSql>(); // added this
  TopicsScreen({super.key});
  final QuestionsRepository _repository = QuestionsRepository.instance;

  @override
  Widget build(BuildContext context) {
    final int catId = Get.arguments;

    // Fetch questions based on category ID
    provider.fetchQuestionsByCategory(catId);

    // Define the title variable
    RxString title = ''.obs;

    // Set the title based on the category and question count
    title.value = "Questions"; // default title

    // Update title when category is fetched
    if (provider.filteredQuestions.isNotEmpty) {
      final category = provider.categories.firstWhere(
          (category) => category.catId == catId,
          orElse: () => QuestionCategory(catId: catId));
      final questionCount = provider.filteredQuestions.length;
      title.value = "${category.name} ($questionCount)";
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(title.value)),  // Display reactive title
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (provider.isAllQuestionsLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

      

        final questions = provider.filteredQuestions;

        if (questions.isEmpty) {
          return const Center(
            child: Text(
              "No Topics available for this category.",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Card(
              child: ListTile(
                leading: Image.asset(
                  "${AppImages.initialPath}${question.image}",
                ),
                title: Text(question.question ?? 'No Question Text'),
                subtitle:
                    LastReadTime(repository: _repository, question: question),
                onTap: () {
                  // Navigate to QuestionDetailScreen with the selected question
                  Get.toNamed(
                    AppRouts.questionDetailScreen,
                    arguments: question,
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
