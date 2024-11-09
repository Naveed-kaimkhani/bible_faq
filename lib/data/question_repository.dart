import 'package:bible_faq/model/model.dart';

import '../constants/constants.dart';

class QuestionRepository {
  static List<Question> fetchLatestQuestions() {
    return [
      Question(
        text: "Why does God allow suffering and evil in the world?",
        imagePath: AppImages.questionImages[0],
      ),
      Question(
        text:
            "What is the significance of the Ten Commandments in Christianity?",
        imagePath: AppImages.questionImages[1],
      ),
      Question(
        text: "How did David defeat Goliath with just a sling and a stone?",
        imagePath: AppImages.questionImages[2],
      ),
      Question(
        text:
            "What are the four horsemen of the Apocalypse in the Book of Revelation?",
        imagePath: AppImages.questionImages[3],
      ),
      Question(
        text: "Why did Moses part the Red Sea in the Old Testament?",
        imagePath: AppImages.questionImages[4],
      ),
      Question(
        text: "What is the story of the prodigal son in the Bible?",
        imagePath: AppImages.questionImages[5],
      ),
      Question(
        text: "How did David defeat Goliath with just a sling and a stone?",
        imagePath: AppImages.questionImages[6],
      ),
      Question(
        text: "What is the significance of the Last Supper?",
        imagePath: AppImages.questionImages[7],
      ),
      Question(
        text: "Why did Moses part the Red Sea?",
        imagePath: AppImages.questionImages[8],
      ),
    ];
  }
}
