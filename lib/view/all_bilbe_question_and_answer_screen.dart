import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/components/last_read_time.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBilbeQuestionAndAnswerScreen extends StatelessWidget {
  AllBilbeQuestionAndAnswerScreen({super.key});

  final dbController = Get.find<QuestionsProviderSql>();

  final QuestionsRepository _repository = QuestionsRepository.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "All Bible Questions and Answers",
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
      ),
      body: Obx(() {
        // Handle the loading state
        if (dbController.isAllQuestionsLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        // Handle the error state
        if (dbController.isAllQuestionsError.value) {
          return const Center(
            child: Text(
              "Failed to fetch questions. Please try again.",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        // Retrieve all questions
        final questions = dbController.allQuestions;

        // Handle the empty state
        if (questions.isEmpty) {
          return const Center(
            child: Text(
              "No questions available.",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              const CustomTextField(
                hintText: "Search",
              ),
              const SizedBox(height: 16),
              // List of Questions
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "${AppImages.initialPath}${question.image}", // Placeholder image
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                                question.question ?? 'No Question Text',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                )),
                        subtitle: LastReadTime(
                            repository: _repository, question: question),
                        onTap: () {
                          Get.toNamed(
                            AppRouts.questionDetailScreen,
                            arguments: question,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
