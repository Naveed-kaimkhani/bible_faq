import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/data/data.dart';
import 'package:bible_faq/model/model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LatestQuestionScreen extends StatelessWidget {
  LatestQuestionScreen({super.key});

  final List<Question> questions = QuestionRepository.fetchLatestQuestions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Latest Questions",
        isShowSettingTrailing: true,
      ),
      body: BodyContainerComponent(
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
                        leading: Image.asset(question.imagePath),
                        title: TitleText(
                          text: question.text,
                          fontSize: AppFontSize.xsmall,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
