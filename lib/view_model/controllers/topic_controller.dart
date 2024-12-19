import 'package:bible_faq/data/topic_repositry.dart';
import 'package:bible_faq/model/model.dart';
import 'package:get/get.dart';

class TopicController extends GetxController {
  var topics = <Topic>[].obs;
  final TopicRepository _repository = TopicRepository();
  
  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  void fetchTopics() {
    topics.assignAll(_repository.fetchTopics());
  }
}
