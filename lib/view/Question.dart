import 'package:bible_faq/view_model/api_controller/all_question_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPage extends StatelessWidget {
  final QuestionProviderAPI questionProvider = Get.put(QuestionProviderAPI());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
      ),
      body: Obx(() {
        if (questionProvider.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (questionProvider.isNetworkError.value) {
          return Center(child: Text("Failed to load data. Please check your connection."));
        }

        if (questionProvider.questions.isNotEmpty) {
          return ListView.builder(
            itemCount: questionProvider.questions.length,
            itemBuilder: (context, index) {
              final question = questionProvider.questions[index];
              return ListTile(
                trailing: Text(questionProvider.questions.length as String),
                title: Text(question.verse.toString()), // Adjust based on your model
                subtitle: Text(question.answer.toString()), // Adjust based on your model
              );
            },
          );
        }

        return Center(child: Text("No data available."));
      }),
    );
  }
}
