import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/model/topic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicTileComponent extends StatelessWidget {
  final Topic topic;

  const TopicTileComponent({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(topic.imageUrl, width: 40, height: 40),
          ),
          title: TitleText(
            text: topic.title,
          ),
          subtitle: SizedBox(
            height: 24,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 52,
                decoration: BoxDecoration(
                  color: AppColors.aquaBlue.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: LabelText(
                    text: "${topic.count}",
                    textColor: AppColors.tealBlue,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.medium,
                    isChangeTextColor: false,
                  ),
                ),
              ),
            ),
          ),
          trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.aquaBlue.withOpacity(.1),
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.tealBlue,
            ),
          ),
          onTap: () {
            // Navigate to TopicScreen with the selected category's ID
            Get.toNamed(
              AppRouts.topicScreen,
              arguments: topic.catId, // Pass catId as an argument
            );
          },
        ),
      ),
    );
  }
}
