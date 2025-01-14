import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AllBilbeQuestionAndAnswerCard extends StatelessWidget {
  const AllBilbeQuestionAndAnswerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            AppColors.tealBlue,
            AppColors.aquaBlue,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LabelText(
                    text: "All Bible Questions and Answers (2200)",
                    maxLine: 2,
                    fontSize: AppFontSize.small,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.white,
                  ),
                  const Gap(6),
                  const LabelText(
                    text:
                        "Explore a variety of questions organized by over 40 topics",
                    maxLine: 2,
                    textColor: AppColors.white,
                  ),
                  const Gap(6),
                  FilledButton(
                    onPressed: () {
                      Get.toNamed(AppRouts.allBibleQuestionAnswerScreen);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: const LabelText(
                      text: "Read Now",
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.tealBlue,
                      isChangeTextColor: false,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(
                AppImages.bookImage,
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
