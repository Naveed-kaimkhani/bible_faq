import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AskQuestionScreen extends StatelessWidget {
  const AskQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: "Ask a Question",
      ),
      body: BodyContainerComponent(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoSection(),
              const CustomTextField(),
              const Gap(6),
              SizedBox(
                height: Get.height * 0.6,
                child: QuestionSection(),
              ),
              const Gap(10),
              const TitleText(text: "Have a Bible Question?"),
              const LabelText(
                text:
                    "Do you have a question about the Bible or need spiritual guidance? ",
                textColor: AppColors.lightGray,
              ),
              const Gap(10),
              const LabelText(
                text:
                    "We're here to help! Submit your question, and our team will respond with insights from the Scriptures.",
                textColor: AppColors.lightGray,
              ),
              const LabelText(
                text:
                    "Our dedicated team will get back to you within a few days.",
                textColor: AppColors.lightGray,
              ),
              const Gap(10),
              CustomTextField(
                hintText: "Enter your full name...",
                prefixIcon: svgImage(AppSvgIcons.user),
              ),
              const Gap(10),
              CustomTextField(
                hintText: "Your email address...",
                prefixIcon: svgImage(AppSvgIcons.mail),
              ),
              const Gap(10),
              CustomTextField(
                hintText: "Please write your question...",
                prefixIcon: svgImage(AppSvgIcons.messageMultiple),
              ),
              const Gap(10),
              CustomGradientButton(text: "Submit", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget svgImage(String image) => SvgPicture.asset(
        image,
        height: 24,
        width: 24,
        fit: BoxFit.scaleDown,
      );
}

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            bool isDarkMode = themeController.isDarkMode.value;

            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Before asking your question, we encourage you to search our previously asked questions ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFontSize.small,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                    ),
                  ),
                  const TextSpan(
                    text:
                        "to see if someone else has already asked the same or a similar question.",
                    style: TextStyle(
                      fontSize: AppFontSize.xsmall,
                      color: AppColors.lightGray,
                    ),
                  ),
                ],
              ),
            );
          }),
          const Gap(12),
          const LabelText(
            text:
                "We have over 2,100 questions answered on various topics. You may search and filter below.",
            textColor: AppColors.lightGray,
            isChangeTextColor: false,
          ),
          const Gap(12),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "If you don’t find what you are looking for, ",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightGray,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: GestureDetector(
                    onTap: () {},
                    child: const LabelText(
                      text: "click here",
                      decoration: TextDecoration.underline,
                      textColor: AppColors.tealBlue,
                      decorationColor: AppColors.tealBlue,
                      isChangeTextColor: false,
                    ),
                  ),
                ),
                const TextSpan(
                  text: " to send us your question.",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.lightGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionSection extends StatelessWidget {
  QuestionSection({super.key});

  // final List<Question> questions = QuestionRepository.fetchLatestQuestions();
  
  final  dbController = Get.find<QuestionsProviderSql>();

  @override
  Widget build(BuildContext context) {
    
        final questions = dbController.allQuestions;
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Image.asset("${AppImages.initialPath} ${question.image}"),
              title: TitleText(
                text: question.question??"",
                fontSize: AppFontSize.xsmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
