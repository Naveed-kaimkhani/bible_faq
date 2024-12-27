import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/controllers/theme_controller.dart';
import 'package:bible_faq/view_model/font_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QuestionDetailScreen extends StatelessWidget {
  QuestionDetailScreen({super.key});

  final themeController = Get.find<ThemeController>();
  final fontSizeController = Get.find<FontSizeController>();
  final QuestionsRepository _repository = QuestionsRepository.instance;

  @override
  Widget build(BuildContext context) {
    // Retrieve the question object passed from the previous screen
    QuestionData question = Get.arguments;
    _repository.updateTimestamp(question.qId ?? 0);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Question Details",
        isShowSettingTrailing: true,
        isShowFavButton: true,
        isShowStarTrailing: true,
        qid: question.qId,
      ),
      body: BodyContainerComponent(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              Obx(() {
                return TitleText(
                  text: question.question ?? 'No Question Text',
                  fontSize: fontSizeController.fontSize.value,
                );
              }),
              const Gap(16),

              // Display the answer section
              const Text(
                "Answer:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(8),
              Obx(() {
                return Html(
                  data: question.answer ?? "<p>No Answer Available</p>",
                  style: {
                    "body": Style(
                      fontSize: FontSize(fontSizeController.fontSize.value),
                      fontWeight: FontWeight.w400,
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  },
                );
              }),
              const Gap(16),

              // Book Info Section
              const Text(
                "Book:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Obx(() {
                return Text(
                  question.book.toString() ?? 'No Book Info',
                  style: TextStyle(fontSize: fontSizeController.fontSize.value),
                );
              }),
              const Gap(16),

              // Hits Section
              const Text(
                "Hits:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Obx(() {
                return Text(
                  "${question.hits ?? 0}",
                  style: TextStyle(fontSize: fontSizeController.fontSize.value),
                );
              }),
              const Gap(16),

              // Verse Section
              const Text(
                "Verse:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Obx(() {
                return Text(
                  question.verse.toString() ?? 'No Verse Info',
                  style: TextStyle(fontSize: fontSizeController.fontSize.value),
                );
              }),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
