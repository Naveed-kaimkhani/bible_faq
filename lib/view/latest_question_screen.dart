import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/components/last_read_time.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/utils/utils.dart';
import 'package:bible_faq/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LatestQuestionScreen extends StatelessWidget {
  LatestQuestionScreen({super.key});

  final QuestionsProviderSql provider = Get.put(QuestionsProviderSql());

  final QuestionsRepository _repository = QuestionsRepository.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Latest Questions",
        isShowSettingTrailing: true,
      ),
      body: Obx(() {
        if (provider.isLatestQuestionsLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (provider.isLatestQuestionsError.value) {
          return const Center(
            child: Text(
              "Failed to load latest questions",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }

        final questions = provider.latestQuestions;

        return BodyContainerComponent(
          child: Column(
            children: [
              const CustomTextField(),
              const Gap(10),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: Image.asset(
                            "${AppImages.initialPath}${question.image}",
                          ), // Replace with question.imagePath if applicable
                          title: TitleText(
                            text: cleanQuestion(
                                question.question ?? 'No text available'),
                            fontSize: AppFontSize.xsmall,
                          ),
                          subtitle: LastReadTime(
                              repository: _repository, question: question),
                          onTap: () {
                            // Navigate to QuestionDetailScreen with the selected question as an argument
                            Get.toNamed(
                              AppRouts.questionDetailScreen,
                              arguments: [question, false],
                            );
                          },
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
