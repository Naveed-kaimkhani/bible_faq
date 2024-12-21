import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/model/topic.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BibleTopicsScreen extends StatelessWidget {
  final QuestionsProviderSql provider = Get.put(QuestionsProviderSql());

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
              child: Obx(() {
                if (provider.isCategoriesLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.isCategoriesError.value) {
                  return Center(
                    child: Text(
                      "Failed to load categories",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }

                final topics = provider.categories;

                if (topics.isEmpty) {
                  return const Center(
                    child: Text(
                      "No categories available.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    return TopicTileComponent(
                      topic: Topic(
                        catId: topic.catId,
                        title: topic.name ?? 'Unnamed Topic',
                        count: 45, // Replace with actual count if available
                        imageUrl: "assets/images/questionImage1.png",
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
