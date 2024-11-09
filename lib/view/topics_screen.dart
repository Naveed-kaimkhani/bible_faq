import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/data/data.dart';
import 'package:bible_faq/model/model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TopicsScreen extends StatelessWidget {
  TopicsScreen({super.key});

  final List<Question> questions = QuestionRepository.fetchLatestQuestions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Topics",
        isShowSettingTrailing: true,
      ),
      body: BodyContainerComponent(
        child: Column(
          children: [
            const CustomTextField(),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleText(text: "Angels, Spirit Being"),
                Container(
                  width: 52,
                  decoration: BoxDecoration(
                    color: AppColors.aquaBlue.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: LabelText(
                      text: "45",
                      textColor: AppColors.tealBlue,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.medium,
                      isChangeTextColor: false,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(5),
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
                        onTap: () {
                          Get.toNamed(AppRouts.topicDeatailsScreen);
                        },
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
