import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/model/model.dart';

class TopicRepository {
  List<Topic> fetchTopics() {
    return [
      Topic(
        title: "Angels, Spirit Being",
        count: 45,
        imageUrl: AppImages.questionImages[5],
      ),
      Topic(
        title: "Baptism",
        count: 15,
        imageUrl: AppImages.questionImages[0],
      ),
      Topic(
        title: "Bible and Bible Characters",
        count: 15,
        imageUrl: AppImages.questionImages[3],
      ),
      Topic(
        title: "Angels, Spirit Being",
        count: 45,
        imageUrl: AppImages.questionImages[5],
      ),
      Topic(
        title: "Baptism",
        count: 15,
        imageUrl: AppImages.questionImages[0],
      ),
      Topic(
        title: "Bible and Bible Characters",
        count: 15,
        imageUrl: AppImages.questionImages[3],
      ),
      Topic(
        title: "Angels, Spirit Being",
        count: 45,
        imageUrl: AppImages.questionImages[5],
      ),
      Topic(
        title: "Baptism",
        count: 15,
        imageUrl: AppImages.questionImages[0],
      ),
      Topic(
        title: "Bible and Bible Characters",
        count: 15,
        imageUrl: AppImages.questionImages[3],
      ),
    ];
  }
}
