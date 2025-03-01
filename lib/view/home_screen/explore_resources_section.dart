import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreResourcesSection extends StatelessWidget {
  const ExploreResourcesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(text: "Explore Resources"),
        // const Gap(10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ResourceComponent(
                title: "Free Bible Guide by Mail",
                subTitle:
                    "Receive a free Bible study guide delivered directly to your mailbox.",
                image: AppImages.resourceImages.first,
                ontap: () {
                  Get.toNamed(AppRouts.freeBilbeGuideScreen);
                },
              ),
              ResourceComponent(
                title: "Favorite Questions",
                subTitle: "Check your all questions marked as favorite",
                image: AppImages.favoriteImage,
                ontap: () {
                  Get.toNamed(AppRouts.myFavouritQuestionScreen);
                },
              ),
              ResourceComponent(
                title: "Ask a Question",
                subTitle: "Have any question? Click here to reachout to us.",
                image: AppImages.askQuestion,
                ontap: () {
                  Get.toNamed(AppRouts.askAQuestion);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
