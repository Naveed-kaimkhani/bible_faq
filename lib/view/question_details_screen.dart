import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/services/sqlite_services/db_services.dart';
import 'package:bible_faq/view_model/controllers/theme_controller.dart';
import 'package:bible_faq/view_model/font_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QuestionDetailScreen extends StatelessWidget {
  QuestionDetailScreen({super.key});

  final themeController = Get.find<ThemeController>();
  final fontSizeController = Get.find<FontSizeController>();
  final QuestionsRepository _repository = QuestionsRepository.instance;

  @override
  Widget build(BuildContext context) {
    // Retrieve the question object passed from the previous screen
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
                        width: 52,
                        decoration: BoxDecoration(
                          color: AppColors.aquaBlue.withOpacity(.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: LabelText(
                            ///Naveed add correct values here asked in pdf
                            text: "${question.qId}",
                            textColor: AppColors.tealBlue,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.medium,
                            isChangeTextColor: false,
                          ),
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
                          AppImages.splashImage,
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
