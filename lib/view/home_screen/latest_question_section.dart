import 'dart:developer';

import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:bible_app/utils/utils.dart';
import 'package:bible_app/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestQuestionSection extends StatelessWidget {
  const LatestQuestionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Get.find<QuestionsProviderSql>();

    return Obx(() {
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

      // Debug log to trace the questions being displayed
      log("Displaying latest questions in section: ${questions.length}");

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleText(text: "Latest Questions"),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRouts.latestQuestionScreen);
                },
                child: const LabelText(text: "See all"),
              ),
            ],
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final question = questions[index];
              return GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                            "${AppImages.initialPath}${question.image}"),
                        title: TitleText(
                          text:
                              cleanQuestion(question.question ?? 'No Question'),
                          fontSize: AppFontSize.xsmall,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(
                      AppRouts.questionDetailScreen,
                      arguments: [question, false],
                    );
                  });
            },
          ),
        ],
      );
    });
  }
}
