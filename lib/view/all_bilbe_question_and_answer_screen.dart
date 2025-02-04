// import 'package:bible_faq/components/appbar_filter.dart';
// import 'package:bible_faq/components/componets.dart';
// import 'package:bible_faq/components/last_read_time.dart';
// import 'package:bible_faq/constants/constants.dart';
// import 'package:bible_faq/services/sqlite_services/db_services.dart';
// import 'package:bible_faq/view_model/question_provider/question_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AllBilbeQuestionAndAnswerScreen extends StatelessWidget {
//   AllBilbeQuestionAndAnswerScreen({super.key});

//   final dbController = Get.find<QuestionsProviderSql>();
//   final QuestionsRepository _repository = QuestionsRepository.instance;

//   final RxString sortOrder = 'Newest First'.obs;
//   final RxBool showLatestOnly =
//       false.obs; // Track if we should show latest questions
//   final RxBool showLatestQuestions = false.obs; // Track filter state

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBarForFilter(
//         title: "All Bible Questions and Answers",
//         isShowSettingTrailing: true,
//         isShowInternetTrailing: true,
//         sortOrder: sortOrder, // Pass the observable sortOrder
//         onSortChanged: (String? newOrder) {
//           // Accept nullable String
//           if (newOrder != null) {
//             sortOrder.value = newOrder;
//           }
//         },
//         onFilterTap: () {
//           showLatestQuestions.toggle(); // Toggle filter state
//         },
//       ),
//       body: Obx(() {
//         if (dbController.isAllQuestionsLoading.value) {
//           return const Center(child: CircularProgressIndicator.adaptive());
//         }

//         if (dbController.isAllQuestionsError.value) {
//           return const Center(
//             child: Text(
//               "Failed to fetch questions. Please try again.",
//               style: TextStyle(fontSize: 16, color: Colors.red),
//             ),
//           );
//         }

//         // var questions = (sortOrder.value == 'Newest First')
//         //     ? dbController.latestQuestions
//         //     : dbController.allQuestions;
//         var questions = List.of(dbController
//             .allQuestions); // Clone list to avoid modifying the original

// // Apply sorting based on timestamp
//         questions.sort((a, b) {
//           DateTime dateA = DateTime.tryParse(a.timestamp ?? '') ?? DateTime(0);
//           DateTime dateB = DateTime.tryParse(b.timestamp ?? '') ?? DateTime(0);

//           return (sortOrder.value == 'Newest First')
//               ? dateB.compareTo(dateA) // Newest first (descending order)
//               : dateA.compareTo(dateB); // Oldest first (ascending order)
//         });

//         if (questions.isEmpty) {
//           return const Center(
//             child: Text(
//               "No questions available.",
//               style: TextStyle(fontSize: 16),
//             ),
//           );
//         }

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       hintText: "Search",
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: questions.length,
//                   itemBuilder: (context, index) {
//                     final question = questions[index];
//                     return Card(
//                       elevation: 3,
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 16,
//                         ),
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.asset(
//                             AppImages.getRandomImage(), // Placeholder image
//                             height: 50,
//                             width: 50,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         title: Text(
//                           question.question ?? 'No Question Text',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: LastReadTime(
//                             repository: _repository, question: question),
//                         onTap: () {
//                           Get.toNamed(
//                             AppRouts.questionDetailScreen,
//                             arguments: question,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

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

  final RxString sortOrder = 'Newest First'.obs; // Sorting state
  final RxBool showLatestQuestions = false.obs; // Filter state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForFilter(
        title: "All Bible Questions and Answers",
        isShowSettingTrailing: true,
        isShowInternetTrailing: true,
        sortOrder: sortOrder, // Sorting
        onSortChanged: (String? newOrder) {
          if (newOrder != null) {
            sortOrder.value = newOrder;
          }
        },
        onFilterTap: () {
          showLatestQuestions.toggle(); // Toggle latest questions filter
        },
      ),
      body: Obx(() {
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

        var questions = List.of(dbController.allQuestions);

        // ✅ Apply filtering (if enabled)
        if (showLatestQuestions.value) {
          // var questions = (sortOrder.value == 'Newest First')
          //     ? dbController.latestQuestions
          //     : dbController.allQuestions;s
          var questions = List.of(dbController
              .allQuestions); // Clone list to avoid modifying the original

// Apply sorting based on timestamp
          questions.sort((a, b) {
            DateTime dateA =
                DateTime.tryParse(a.timestamp ?? '') ?? DateTime(0);
            DateTime dateB =
                DateTime.tryParse(b.timestamp ?? '') ?? DateTime(0);

            return (sortOrder.value == 'Newest First')
                ? dateB.compareTo(dateA) // Newest first (descending order)
                : dateA.compareTo(dateB); // Oldest first (ascending order)
          });
        }

        // ✅ Apply sorting logic
        questions.sort((a, b) {
          if (sortOrder.value == 'Newest First' ||
              sortOrder.value == 'Oldest First') {
            DateTime dateA =
                DateTime.tryParse(a.timestamp ?? '') ?? DateTime(0);
            DateTime dateB =
                DateTime.tryParse(b.timestamp ?? '') ?? DateTime(0);

            return (sortOrder.value == 'Newest First')
                ? dateB.compareTo(dateA) // Newest first
                : dateA.compareTo(dateB); // Oldest first
          } else if (sortOrder.value == 'Alphabetical (A-Z)') {
            return (a.question ?? '')
                .toLowerCase()
                .compareTo((b.question ?? '').toLowerCase());
          }
          return 0; // Default case
        });

        if (questions.isEmpty) {
          return const Center(
            child: Text(
              "No questions available.",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Search",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: sortOrder.value == 'Newest First'
                      ? dbController.latestQuestions.length
                      : questions.length,
                  itemBuilder: (context, index) {
                    final question = sortOrder.value == 'Newest First'
                        ? dbController.latestQuestions[index]
                        : questions[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
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
                            AppImages.initialPath,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(cleanQuestion(question.question!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
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
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
