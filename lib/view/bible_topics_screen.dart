import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_images.dart';
import 'package:bible_faq/data/model/category_question.dart';
import 'package:bible_faq/data/model/question_category.dart';
import 'package:bible_faq/model/topic.dart';
import 'package:bible_faq/view_model/api_controller/all_question_provider.dart';
import 'package:bible_faq/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BibleTopicsScreen extends StatefulWidget {
  const BibleTopicsScreen({super.key});

  @override
  State<BibleTopicsScreen> createState() => _BibleTopicsScreenState();
}

class _BibleTopicsScreenState extends State<BibleTopicsScreen> {
  final QuestionsProviderSql provider = Get.find<QuestionsProviderSql>();
  // late List<QuestionCategory> topics;
  late List<QuestionCategory> filteredQuestions;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    filteredQuestions = provider.categories;
    _searchController.addListener(() {
      _filterQuestions(_searchController.text);
    });
  }

  int countUniqueQuestionsByCategory(
      List<CategoryQuestionData> dataList, int catId) {
    // Use a Set to collect unique qId values for the specified catId
    final uniqueQIds = dataList
        .where((data) => data.catId == catId)
        .map((data) => data.qId)
        .toSet();

    return uniqueQIds.length;
  }

  void _filterQuestions(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredQuestions = provider.categories;
      });
    } else {
      setState(() {
        filteredQuestions = provider.categories
            .where((question) =>
                question.name?.toLowerCase().contains(query.toLowerCase()) ??
                false)
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Bible Topics",
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
      ),
      // appBar: CustomAppBarTopics(title: title),
      body: BodyContainerComponent(
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search questions...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Obx(() {
                if (provider.isCategoriesLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                if (provider.isCategoriesError.value) {
                  return const Center(
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
                  itemCount: filteredQuestions.length,
                  itemBuilder: (context, index) {
                    final topic = filteredQuestions[index];
                    return TopicTileComponent(
                      topic: Topic(
                        catId: topic.catId,
                        title: topic.name ?? 'Unnamed Topic',
                        count: countUniqueQuestionsByCategory(
                            provider.categoryQuestion,
                            topic.catId ??
                                0), // Replace with actual count if available
                        imageUrl:
                            "${AppImages.initialPath}${topic.image}", // Replace with actual URL if available
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
