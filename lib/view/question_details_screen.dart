import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QuestionDetailScreen extends StatelessWidget {
  QuestionDetailScreen({super.key});

  final themeController = Get.find<ThemeController>();
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
              TitleText(
                text: question.question ?? 'No Question Text',
                fontSize: 20,
              ),
              const Gap(16),

              // Display the answer section
              const Text(
                "Answer:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(8),
              Html(
                data: question.answer ?? "<p>No Answer Available</p>",
                style: {
                  "body": Style(
                    fontSize: FontSize(14),
                    fontWeight: FontWeight.w400,
                    color:themeController.isDarkMode.value?Colors.white: Colors.black,
                  ),
                },
              ),
              const Gap(16),

              // Book Info Section
              const Text(
                "Book:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                question.book.toString() ?? 'No Book Info',
                style: const TextStyle(fontSize: 14),
              ),
              const Gap(16),

              // Hits Section
              const Text(
                "Hits:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "${question.hits ?? 0}",
                style: const TextStyle(fontSize: 14),
              ),
              const Gap(16),

              // Verse Section
              const Text(
                "Verse:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                question.verse.toString() ?? 'No Verse Info',
                style: const TextStyle(fontSize: 14),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
