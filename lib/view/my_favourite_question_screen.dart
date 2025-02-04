import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/components/last_read_time.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/controllers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MyFavouriteQuestionScreen extends StatelessWidget {
  MyFavouriteQuestionScreen({super.key});

  final FavoritesProvider favoritesProvider = Get.put(FavoritesProvider());

  final QuestionsRepository _repository = QuestionsRepository.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Favourite Questions",
      ),
      body: BodyContainerComponent(
        child: Column(
          children: [
            const CustomTextField(
              isFavQuestionSearchBar: true,
            ),
            const Gap(10),
            Expanded(
              child: Obx(() {
                // Use reactive favoriteQuestions list
                final questions = favoritesProvider.favoriteQuestions;

                if (favoritesProvider.isFavoritesLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                if (questions.isEmpty) {
                  return const Center(
                    child: Text(
                      "No favorite questions yet.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: Image.asset(
                                "${AppImages.initialPath}${question.image}"),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleText(
                                  text: question.question ?? "No Title",
                                  fontSize: AppFontSize.xsmall,
                                ),
                                const Gap(8),
                              ],
                            ),
                            subtitle: LastReadTime(
                                repository: _repository, question: question),
                            trailing: GestureDetector(
                              onTap: () {
                                favoritesProvider
                                    .toggleFavorite(question.qId.toString());
                              },
                              child: Icon(
                                favoritesProvider
                                        .isFavorite(question.qId.toString())
                                    ? Icons.star
                                    : Icons.star_border,
                                color: favoritesProvider
                                        .isFavorite(question.qId.toString())
                                    ? Colors.yellow
                                    : Colors.grey,
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(
                                AppRouts.questionDetailScreen,
                                arguments: [question, false],
                              );
                            }),
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
