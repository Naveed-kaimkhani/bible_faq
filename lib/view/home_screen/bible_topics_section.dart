import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BibleTopicsSection extends StatelessWidget {
  BibleTopicsSection({super.key});

  final TopicController topicController = Get.put(TopicController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleText(text: "Bible Topics"),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRouts.bibleTopicsScreen);
              },
              child: const LabelText(text: "See all"),
            ),
          ],
        ),
        const Gap(10),
        SizedBox(
          height: 170,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: topicController.topics.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final topic = topicController.topics[index];
              return TopicTileComponent(topic: topic);
            },
          ),
        ),
      ],
    );
  }
}
