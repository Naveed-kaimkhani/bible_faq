import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/model/topic.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BibleTopicsSection extends StatelessWidget {
  BibleTopicsSection({super.key});

  final QuestionsProviderSql provider = Get.put(QuestionsProviderSql());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (provider.isCategoriesLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (provider.isCategoriesError.value) {
        return Center(
          child: Text(
            "Failed to load topics",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        );
      }

      final topics = provider.categories;

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
              itemCount: topics.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return TopicTileComponent(
                  topic: Topic(
                    catId: topic.catId,
                    title: topic.name ?? 'Unnamed Topic',
                    count: 45, // Replace with actual count if available
                    imageUrl:
                        "assets/images/questionImage1.png", // Replace with actual URL if available
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
