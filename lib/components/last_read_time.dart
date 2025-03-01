import 'package:bible_app/data/model/question.dart';
import 'package:bible_app/services/sqlite_services/db_services.dart';
import 'package:flutter/material.dart';

class LastReadTime extends StatelessWidget {
  const LastReadTime({
    super.key,
    required QuestionsRepository repository,
    required this.question,
  }) : _repository = repository;

  final QuestionsRepository _repository;
  final QuestionData question;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _repository.getTimestamp(question.qId ?? 0),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading...',
            style: TextStyle(fontSize: 14),
          );
        } else if (snapshot.hasError) {
          return const Text(
            'Error fetching timestamp',
            style: TextStyle(fontSize: 14),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data?.isEmpty ?? true) {
            return const SizedBox.shrink(); // Transparent widget
          }
          return Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Read on: ',
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: '${snapshot.data}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        } else {
          return const Text(
            'No timestamp found',
            style: TextStyle(fontSize: 14),
          );
        }
      },
    );
  }
}
