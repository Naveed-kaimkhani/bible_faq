import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestQuestionSection extends StatelessWidget {
  const LatestQuestionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Get.find<
        QuestionsProviderSql>(); //this way we can get the instance of QuestionsProviderSql

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
          SizedBox(
            height: 134,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 5,
              itemBuilder: (context, index) {
                final question = questions[index];
                return GestureDetector(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(AppImages.getRandomImage()),
                          title: TitleText(
                            text: question.question ?? 'No text available',
                            fontSize: AppFontSize.xsmall,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(
                        AppRouts.questionDetailScreen,
                        arguments: question,
                      );
                    });
              },
            ),
          ),
        ],
      );
    });
  }
}
