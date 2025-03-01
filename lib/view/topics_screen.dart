import 'package:bible_app/components/componets.dart';
import 'package:bible_app/components/last_read_time.dart';
import 'package:bible_app/constants/app_images.dart';
import 'package:bible_app/constants/app_routs.dart';
import 'package:bible_app/model/topic.dart';
import 'package:bible_app/services/sqlite_services/db_services.dart';
import 'package:bible_app/utils/utils.dart';
import 'package:bible_app/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicsScreen extends StatelessWidget {
  final provider = Get.find<QuestionsProviderSql>();
  TopicsScreen({super.key});
  final QuestionsRepository _repository = QuestionsRepository.instance;

  @override
  Widget build(BuildContext context) {
    final Topic topic = Get.arguments;

    provider.fetchQuestionsByCategory(topic.catId ?? 0);

    return Scaffold(
      appBar: CustomAppBar(
        title: topic.title,
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
        isShowToicLength: true,
        topicLength: topic.count.toString(),
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
                title: Text(
                    cleanQuestion(question.question ?? "No Question Text")),
                subtitle:
                    LastReadTime(repository: _repository, question: question),
                onTap: () {
                  Get.toNamed(
                    AppRouts.questionDetailScreen,
                    arguments: [question, true],
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
