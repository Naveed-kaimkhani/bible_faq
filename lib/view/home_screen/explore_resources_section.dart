import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ExploreResourcesSection extends StatelessWidget {
  const ExploreResourcesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(text: "Explore Resources"),
        const Gap(10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: AppImages.resourceImages.map((image) {
              return ResourceComponent(
                title: "Free Bible Guide by Mail",
                subTitle:
                    "Receive a free Bible study guide delivered directly to your mailbox.",
                image: image,
                ontap: () {
                  Get.toNamed(AppRouts.freeBilbeGuideScreen);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
