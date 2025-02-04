import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view/home_screen/home_screen.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;
      return Scaffold(
        backgroundColor: isDarkMode ? AppColors.black : AppColors.whiteBlue,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(25),
                SizedBox(
                  height: Get.height * 0.10,
                  child: SearchAndSettingsRow(isDarkMode: isDarkMode),
                ),
                // const Gap(16),
                AllBilbeQuestionAndAnswerCard(),
                const Gap(8),
                const ExploreResourcesSection(),
                const Gap(5),
                const LatestQuestionSection(),
                const Gap(10),
                BibleTopicsSection(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
