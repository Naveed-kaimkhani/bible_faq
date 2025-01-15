import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/components/last_read_time.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchQuestionsScreen extends StatefulWidget {
  const SearchQuestionsScreen({super.key});

  @override
  SearchQuestionsScreenState createState() => SearchQuestionsScreenState();
}

class SearchQuestionsScreenState extends State<SearchQuestionsScreen> {
  final dbController = Get.find<QuestionsProviderSql>();
  late List<QuestionData> questions;
  late List<QuestionData> filteredQuestions;
  final TextEditingController _searchController = TextEditingController();

  final QuestionsRepository _repository = QuestionsRepository.instance;
  @override
  void initState() {
    super.initState();
    questions = dbController.allQuestions; // Get all questions
    filteredQuestions =
        questions; // Initialize filtered list with all questions

    _searchController.addListener(() {
      _filterQuestions(_searchController.text);
    });
  }

  void _filterQuestions(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredQuestions = questions;
      });
    } else {
      setState(() {
        filteredQuestions = questions
            .where((question) =>
                question.question
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
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
        title: "Search Questions",
        isShowSettingTrailing: true,
      ),
      body: BodyContainerComponent(
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search questions...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const Gap(10),
            // Questions List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: filteredQuestions.length,
                itemBuilder: (context, index) {
                  final question = filteredQuestions[index];
                  return GestureDetector(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: Image.asset(AppImages.getRandomImage()),
                          title: TitleText(
                            text: question.question ?? 'Unnamed Question',
                            fontSize: AppFontSize.xsmall,
                          ),
                          subtitle: LastReadTime(
                              repository: _repository, question: question),
                          onTap: () {
                            Get.toNamed(
                              AppRouts.questionDetailScreen,
                              arguments: question,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
