import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view/home_screen/home_screen.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final TopicController topicController = Get.put(TopicController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;
      return Scaffold(
        backgroundColor: isDarkMode ? AppColors.black : AppColors.whiteBlue,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(56),
                SizedBox(
                  height: Get.height * 0.10,
                  child: SearchAndSettingsRow(isDarkMode: isDarkMode),
                ),
                const Gap(16),
                SizedBox(
                  height: Get.height * 0.25,
                  child: const AllBilbeQuestionAndAnswerCard(),
                ),
                const Gap(16),
                SizedBox(
                  height: Get.height * 0.35,
                  child: const ExploreResourcesSection(),
                ),
                const Gap(16),
                SizedBox(
                  height: Get.height * 0.25,
                  child: const LatestQuestionSection(),
                ),
                SizedBox(
                  height: Get.height * 0.27,
                  child: BibleTopicsSection(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
