
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
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
      builder: (BuildContext context,
          AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
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
          return Text(
            'Read on: ${snapshot.data}',
            style: const TextStyle(fontSize: 14),
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
