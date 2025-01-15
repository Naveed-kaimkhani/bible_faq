import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_images.dart';
import 'package:bible_faq/data/model/question_category.dart';
import 'package:bible_faq/model/topic.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
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
            // const CustomTextFieldTopics(),
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

                        ///naveed show exact length instead of 45. i don't which parameter has this value
                        count: 45,
                        imageUrl: AppImages.getRandomImage(),
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
