import 'package:bible_app/components/label_text.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:bible_app/view_model/controllers/controllers.dart';
import 'package:bible_app/view_model/controllers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  String? question;
  String? answer;
  final bool isShowSettingTrailing;
  final bool isShowStarTrailing;
  final bool isShowShareTrailing;
  final bool isShowInternetTrailing;
  final bool isShowFavButton;
  final bool isShowToicLength;
  final String topicLength;
  int? qid;
  int? websiteId;
  CustomAppBar({
    super.key,
    required this.title,
    this.qid,
    this.question,
    this.answer,
    this.websiteId,
    this.isShowSettingTrailing = false,
    this.isShowFavButton = false,
    this.isShowStarTrailing = false,
    this.isShowShareTrailing = false,
    this.isShowInternetTrailing = false,
    this.isShowToicLength = false,
    this.topicLength = '',
  });

  @override
  Widget build(BuildContext context) {
    // Get the ThemeController instance
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;

      return PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? [
                        const Color(0xFF2A2D32), // Dark gradient color 1
                        const Color(0xFF1B1E25), // Dark gradient color 2
                      ]
                    : [
                        AppColors.aquaBlue, // Light gradient color 1
                        AppColors.tealBlue, // Light gradient color 2
                      ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          leading: appBarButton(
            Icon(
              Icons.arrow_back_ios,
              color: isDarkMode ? Colors.white : AppColors.tealBlue,
            ),
            () {
              Get.back();
            },
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.xmedium,
              color: AppColors.white,
            ),
          ),
          actions: [
            if (isShowToicLength)
              TitleText(
                text: topicLength,
                textColor: AppColors.white,
              ),
            if (isShowShareTrailing)
              ShareButton(
                  websiteId: websiteId, question: question, answer: answer),
            if (isShowStarTrailing) const Gap(15),
            if (isShowInternetTrailing) const Gap(50),
            if (isShowFavButton)
              GestureDetector(
                onTap: () {
                  final favProvider = Get.put(FavoritesProvider());
                  favProvider.toggleFavorite(qid.toString());
                },
                child: Obx(() {
                  final favProvider = Get.put(FavoritesProvider());
                  bool isFav = favProvider.isFavorite(qid.toString());

                  return Icon(
                    isFav ? Icons.star : Icons.star_border,
                    color: isDarkMode ? Colors.white : Colors.white,
                  );
                }),
              ),
            const Gap(15),
            if (isShowSettingTrailing)
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRouts.settingScreen);
                },
                child:
                    const Icon(Icons.settings_outlined, color: AppColors.white),
              ),
            if (isShowSettingTrailing) const Gap(15),
          ],
          backgroundColor: AppColors.transparent,
          elevation: 0,
        ),
      );
    });
  }

  Widget appBarButton(Icon icon, VoidCallback onTap) {
    final themeController =
        Get.find<ThemeController>(); // Retrieve ThemeController

    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value; // Use observable

      return Transform.scale(
        scaleX: 0.7,
        scaleY: 0.7,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.transparent : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: isDarkMode
                  ? Border.all(
                      color: AppColors.white,
                    )
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: Transform.scale(
                  alignment: Alignment.centerLeft,
                  scaleX: 1.5,
                  scaleY: 1.5,
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.websiteId,
    required this.question,
    required this.answer,
  });

  final int? websiteId;
  final String? question;
  final String? answer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.ios_share_outlined, color: AppColors.white),
      onTap: () async {
        final String websiteLink =
            'https://bibleresources.info/?page_id=$websiteId'; // Replace with your actual website link

        await Share.share(
            "Question: $question\nAnswer: ${answer!.replaceAll(RegExp(r'<[^>]*>'), '')} \nSent from Bible FAQ App: $websiteLink",
            subject: '$question $answer');
      },
    );
  }
}
