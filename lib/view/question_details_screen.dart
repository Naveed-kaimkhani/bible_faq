import 'dart:developer';

import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:bible_app/data/model/question.dart';
import 'package:bible_app/services/sqlite_services/db_services.dart';
import 'package:bible_app/utils/string_utils.dart'; // Import the utility function
import 'package:bible_app/utils/utils.dart';
import 'package:bible_app/view_model/controllers/theme_controller.dart';
import 'package:bible_app/view_model/font_size_provider.dart';
import 'package:bible_app/view_model/question_provider/question_provider_sql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; // Import the new package
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class QuestionDetailScreen extends StatelessWidget {
  QuestionDetailScreen({super.key});

  bool isTopic = false;
  final themeController = Get.find<ThemeController>();

  final fontSizeController = Get.find<FontSizeController>();

  final QuestionsRepository _repository = QuestionsRepository.instance;

  final questionController = Get.find<QuestionsProviderSql>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as List;
    QuestionData question = arguments.first;
    // log("message: ${question.question}");
    isTopic = arguments.last;
    _repository.updateTimestamp(question.qId ?? 0);
    // log("istopic: $isTopic");
    log("question.answer: ${question.answer}");
    final cleanedQuestion =
        cleanQuestion(question.question ?? 'No Question Text');

    return Scaffold(
      appBar: CustomAppBar(
        title: "Question",
        isShowSettingTrailing: true,
        isShowFavButton: true,
        isShowStarTrailing: true,
        isShowShareTrailing: true,
        question: cleanedQuestion,
        answer: question.answer,
        qid: question.qId,
        websiteId: question.websiteId,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isTopic) ...[
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xffe1f3f6),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FutureBuilder<String?>(
                            future: questionController
                                .fetchCategoryNameByQid(question.qId ?? 0),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              } else if (snapshot.hasError) {
                                return const Text("Error fetching category");
                              } else if (!snapshot.hasData ||
                                  snapshot.data == null) {
                                return const Text("Category not found");
                              } else {
                                return LabelText(
                                  text: "${snapshot.data}",
                                  textColor: const Color(0xff18a2b8),
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppFontSize.medium,
                                  isChangeTextColor: false,
                                );
                              }
                            },
                          ),
                        ),
                      ],

                      Obx(() {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: TitleText(
                            text: cleanedQuestion,
                            fontSize: fontSizeController.fontSize.value,
                          ),
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
                      const Gap(10),
                      Obx(() {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: HtmlWidget(
                            question.answer ?? "<p>No Answer Available</p>",
                            onTapUrl: (url) {
                              log("url: $url");
                              return launchHtmlURL(url);
                            },
                            textStyle: TextStyle(
                              fontSize: fontSizeController.fontSize.value,
                              fontWeight: FontWeight.w400,
                              color: themeController.isDarkMode.value
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      }),
                      const Gap(20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: TitleText(
                          text: "Related Questions",
                          fontSize: AppFontSize.xmedium,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const Gap(20),

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
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 5,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
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
                                            text: cleanQuestion(
                                                question.question ??
                                                    'No text available'),
                                            fontSize: AppFontSize.xsmall,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Get.offAndToNamed(
                                        AppRouts.questionDetailScreen,
                                        arguments: [question, false],
                                      );
                                    });
                              },
                            );
                          }
                        },
                      ),
                      const Gap(10),
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

  Future<bool> launchHtmlURL(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return true;
    } else {
      log('Could not launch launchHtmlURL $url');
      return false;
    }
  }
}
