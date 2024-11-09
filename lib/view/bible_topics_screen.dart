import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BibleTopicsScreen extends StatelessWidget {
  final TopicController topicController = Get.put(TopicController());

  BibleTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Bible Topics",
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
      ),
      body: BodyContainerComponent(
        child: Column(
          children: [
            const CustomTextField(),
            const Gap(10),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: topicController.topics.length,
                  itemBuilder: (context, index) {
                    final topic = topicController.topics[index];
                    return TopicTileComponent(topic: topic);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
