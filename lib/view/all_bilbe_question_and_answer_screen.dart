import 'package:bible_faq/components/appbar_filter.dart';
import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/components/last_read_time.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/utils/utils.dart';
import 'package:bible_faq/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBilbeQuestionAndAnswerScreen extends StatelessWidget {
  AllBilbeQuestionAndAnswerScreen({super.key});

  final dbController = Get.find<QuestionsProviderSql>();
  final QuestionsRepository _repository = QuestionsRepository.instance;

  static final RxBool showLatestQuestions = false.obs; // Filter state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarForFilter(
          title: "All Bible Questions \nand Answers",
          isShowSettingTrailing: true,
          isShowInternetTrailing: true,
          sortOrder: dbController.sortOrder,
          onSortChanged: (String? newOrder) {
            if (newOrder != null) {
              dbController.sortQuestions(newOrder); // Update sorting
            }
          },
          onFilterTap: () {
            showSortOptions(
              context,
              dbController.sortOrder,
              (value) => showLatestQuestions.toggle(),
            );
          },
        ),
        body: BodyContainerComponent(child: Obx(() {
          if (dbController.isAllQuestionsLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (dbController.isAllQuestionsError.value) {
            return const Center(
              child: Text(
                "Failed to fetch questions. Please try again.",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }

          // Use directly sorted list from dbController
          var questions = dbController.allQuestions;

          if (questions.isEmpty) {
            return const Center(
              child: Text(
                "No questions available.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            children: [
              const CustomTextField(hintText: "Search"),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  // Wrap the ListView.builder with Obx
                  return ListView.builder(
                    key: ValueKey(dbController.sortOrder.value),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "${AppImages.initialPath}${question.image}",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(cleanQuestion(question.question!),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                          subtitle: LastReadTime(
                              repository: _repository, question: question),
                          onTap: () {
                            Get.toNamed(
                              AppRouts.questionDetailScreen,
                              arguments: [question, false],
                            );
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          );
        })));
  }

  void showSortOptions(BuildContext context, RxString sortOrder,
      ValueChanged<String?> onSortChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Newest First"),
                onTap: () {
                  sortOrder.value = "Newest First";
                  onSortChanged("Newest First");
                  Get.find<QuestionsProviderSql>()
                      .sortQuestions("Newest First");
                  Get.back();
                },
              ),
              ListTile(
                title: const Text("Oldest First"),
                onTap: () {
                  sortOrder.value = "Oldest First";
                  onSortChanged("Oldest First");
                  Get.find<QuestionsProviderSql>()
                      .sortQuestions("Oldest First");
                  Get.back();
                },
              ),
              ListTile(
                title: const Text("Alphabetical (A-Z)"),
                onTap: () {
                  sortOrder.value = "Alphabetical (A-Z)";
                  onSortChanged("Alphabetical (A-Z)");
                  Get.find<QuestionsProviderSql>()
                      .sortQuestions("Alphabetical (A-Z)");
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
