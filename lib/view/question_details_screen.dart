import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/controllers/theme_controller.dart';
import 'package:bible_faq/view_model/font_size_provider.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QuestionDetailScreen extends StatelessWidget {
  QuestionDetailScreen({super.key});

  final themeController = Get.find<ThemeController>();

  final fontSizeController = Get.find<FontSizeController>();

  final QuestionsRepository _repository = QuestionsRepository.instance;

  final questionController = Get.find<QuestionsProviderSql>();

  @override
  Widget build(BuildContext context) {
    QuestionData question = Get.arguments;
    _repository.updateTimestamp(question.qId ?? 0);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Question Details",
        isShowSettingTrailing: true,
        isShowFavButton: true,
        isShowStarTrailing: true,
        isShowShareTrailing: true,
        qid: question.qId,
      ),
      body: BodyContainerComponent(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 302,
                        decoration: BoxDecoration(
                          color: AppColors.aquaBlue.withOpacity(.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: FutureBuilder<String?>(
                          future: questionController
                              .fetchCategoryNameByQid(question.qId ?? 0),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LabelText(
                                text:
                                    "Bible and Bible Characters", // Your dynamic data here
                                textColor: AppColors.tealBlue,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w700,
                                fontSize: AppFontSize.medium,
                                isChangeTextColor: false,
                              );
                              ;
                            } else if (snapshot.hasError) {
                              return const Text("Error fetching category");
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return const Text("Category not found");
                            } else {
                              return LabelText(
                                text:
                                    "${snapshot.data}", // Your dynamic data here
                                textColor: AppColors.tealBlue,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w700,
                                fontSize: AppFontSize.medium,
                                isChangeTextColor: false,
                              );
                            }
                          },
                        ),
                      ),
                      const Gap(16),
                      Obx(() {
                        return TitleText(
                          text: question.question ?? 'No Question Text',
                          fontSize: fontSizeController.fontSize.value,
                        );
                      }),
                      const Gap(16),

                      ///Naveed add correct associated image from the database
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Image.asset(
                          "${AppImages.initialPath}${question.image}",
                          width: double.infinity,
                          height: Get.height * 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // const Gap(10),
                      Obx(() {
                        return Html(
                          data: question.answer ?? "<p>No Answer Available</p>",
                          style: {
                            "body": Style(
                              fontSize:
                                  FontSize(fontSizeController.fontSize.value),
                              fontWeight: FontWeight.w400,
                              color: themeController.isDarkMode.value
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          },
                        );
                      }),
                      const Gap(16),
                      FutureBuilder<List<QuestionData>>(
                        future: questionController
                            .fetchRandomQuestionsFromSameCategory(
                                question.qId ?? 0),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text("Error fetching questions");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No random questions available");
                          } else {
                            return SizedBox(
                              height: Get.height * 0.3,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  final question = snapshot.data![index];
                                  return GestureDetector(
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: Image.asset(
                                                "assets/images/${question.image}"),
                                            title: TitleText(
                                              text: question.question ??
                                                  'No text available',
                                              fontSize: AppFontSize.xsmall,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                QuestionDetailScreen(),
                                            settings: RouteSettings(
                                                arguments:
                                                    question), // Pass the new question
                                          ),
                                        );
                                      });
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
