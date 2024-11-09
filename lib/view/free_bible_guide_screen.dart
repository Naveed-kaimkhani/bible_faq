import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/view/free_bible_guide_screen/free_bible_guide_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FreeBibleGuideScreen extends StatelessWidget {
  const FreeBibleGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Free Bible Guide",
        isShowSettingTrailing: true,
      ),
      body: BodyContainerComponent(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IntroText(),
              const MainImage(),
              const Gap(16),
              const DescriptionText(),
              const Gap(16),
              const StudyMethodsList(),
              const Gap(16),
              const InfoText(),
              const Gap(10),
              const UserInputForm(),
              const Gap(10),
              const SubscriptionCard(
                title:
                    "Subscribe to our quarterly newsletter for Bible insights. (Available by mail in the USA only)",
              ),
              const Gap(10),
              const SubscriptionCard(
                title:
                    "Receive our inspiring Daily Bible Devotions by email. (You can unsubscribe at any time)",
              ),
              const Gap(10),
              CustomGradientButton(text: "Submit", onTap: () {}),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
