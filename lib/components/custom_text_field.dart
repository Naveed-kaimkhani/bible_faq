import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/constants/app_routs.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:bible_faq/view_model/question_provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText = "Search",
    this.prefixIcon = const Icon(Icons.search),
    this.maxLines = 1,
    this.height = 50,
  });
  final String hintText;
  final Widget prefixIcon;
  final int maxLines;
  final double height;
  @override
  Widget build(BuildContext context) {
    
  final  dbController = Get.find<QuestionsProviderSql>();
    final ThemeController themeController = Get.find();
    dbController.allQuestions;
    return Obx(
      () {
        bool isDarkMode = themeController.isDarkMode.value;

        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.lightBlack : AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              isDarkMode
                  ? const BoxShadow()
                  : BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(-2, 2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
            ],
          ),
          child: SizedBox(
            height: height,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.transparent,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                hintText: hintText,
                prefixIcon: prefixIcon,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              maxLines: maxLines,
              onChanged: (value) {
                
              },
            ),
          ),
        );
      },
    );
  }
}
