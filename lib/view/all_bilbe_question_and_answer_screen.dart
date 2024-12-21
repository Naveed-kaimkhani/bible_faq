import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBilbeQuestionAndAnswerScreen extends StatelessWidget {
  AllBilbeQuestionAndAnswerScreen({super.key});

  // Get the QuestionsProviderSql instance
  final QuestionsProviderSql DBcontroller = Get.find<QuestionsProviderSql>();

  @override
  Widget build(BuildContext context) {
    // Fetch all questions when this screen is loaded
    DBcontroller.fetchAllQuestions();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "All Bible Questions and Answers",
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
      ),
      body: Obx(() {
        if (DBcontroller.isLoading.value) {
          // Show a loading spinner while fetching data
          return const Center(child: CircularProgressIndicator());
        }

        if (DBcontroller.isError.value) {
          // Show an error message if something goes wrong
          return const Center(
              child: Text("Failed to fetch questions. Please try again."));
        }

        final questions = DBcontroller.allQuestions;

        if (questions.isEmpty) {
          // Show a message when no questions are available
          return const Center(child: Text("No questions available."));
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
                            'assets/images/questionImage1.png', // Placeholder image
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          question.question ?? 'No Question Text',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
