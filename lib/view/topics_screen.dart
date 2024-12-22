import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_images.dart';
import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicsScreen extends StatelessWidget {
/*




  // final QuestionsProviderSql provider = Get.put(QuestionsProviderSql());  // we used put only 1 time in main.dart, so we use Get.find() to get the instance of QuestionsProviderSql





*/

  final  provider = Get.find<QuestionsProviderSql>(); // added this
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
          return const Center(
            child:  Text(
              "Failed to load Topics.",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
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
                 
                            AppImages.getRandomImage(),
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
