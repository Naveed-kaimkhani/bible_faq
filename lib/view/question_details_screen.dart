import 'package:bible_faq/components/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionDetailScreen extends StatelessWidget {
  QuestionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the question object passed from the previous screen
    final question = Get.arguments;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Question Details",
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: question.question ?? 'No Question Text',
              fontSize: 20,
            ),
            const SizedBox(height: 16),
            Text(
              "Answer:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Html(
              data: question.answer ?? "<p>No Answer Available</p>",
              style: {
                "body": Style(
                  fontSize:  FontSize(14),
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              },
            ),
            const SizedBox(height: 16),
            Text(
              "Book:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              question.book ?? 'No Book Info',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              "Hits:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "${question.hits ?? 0}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              "Verse:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              question.verse ?? 'No Verse Info',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
