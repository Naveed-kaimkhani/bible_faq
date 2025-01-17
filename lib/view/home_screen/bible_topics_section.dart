import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_images.dart';
import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/model/topic.dart';
import 'package:bible_faq/view_model/api_controller/all_question_provider.dart';
import 'package:bible_faq/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BibleTopicsSection extends StatelessWidget {
  BibleTopicsSection({super.key});

  // final QuestionsProviderSql provider = Get.put(QuestionsProviderSql());  //// we used put only 1 time in main.dart, so we use Get.find() to get the instance of QuestionsProviderSql

  final provider = Get.find<QuestionsProviderSql>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (provider.isCategoriesLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (provider.isCategoriesError.value) {
        return const Center(
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
          // const Gap(10),
          SizedBox(
            height: 160,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return FutureBuilder<int>(
                  future: QuestionProviderAPI()
                      .getQuestionCountByCatId(topic.catId ?? 0),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show a loader while fetching
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final questionCount = snapshot.data ?? 0;

                      return TopicTileComponent(
                        topic: Topic(
                          catId: topic.catId,
                          title: topic.name ?? 'Unnamed Topic',
                          count:
                              questionCount, // Replace with actual count if available
                          imageUrl:
                              "${AppImages.initialPath}${topic.image}", // Replace with actual URL if available
                        ),
                      );
                    } else {
                      return const Text("No data available.");
                    }
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
