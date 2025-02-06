import 'dart:developer';

String cleanQuestion(String question) {
  log("question: $question");
  return question
      .replaceAll('&quot;', '"')
      .replaceAll('&#039;', "'")
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll(RegExp(r'\(.*?\)'), '');
}
