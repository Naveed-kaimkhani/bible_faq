import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicsScreen extends StatelessWidget {
  final QuestionsProviderSql provider = Get.put(QuestionsProviderSql());

  TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int catId = Get.arguments;

    provider.fetchQuestionsByCategory(catId);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Questions",
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
      ),
      body: Obx(() {
        if (provider.isAllQuestionsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.isAllQuestionsError.value) {
          return Center(
            child: Text(
              "Failed to load questions.",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }

        final questions = provider.filteredQuestions;

        if (questions.isEmpty) {
          return const Center(
            child: Text(
              "No questions available for this category.",
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
                  'assets/images/questionImage1.png',
                ),
                title: Text(question.question ?? 'No Question Text'),
                subtitle: Text("Book: ${question.book ?? 'No Book Info'}"),
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
