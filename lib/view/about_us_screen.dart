import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/constants/app_fonts.dart';
import 'package:bible_faq/view/about_us_screen/about_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "About Us"),
      body: const BodyContainerComponent(child: AboutPage()),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          const TitleText(
            text: 'About Christian Resources',
          ),
          const Gap(8),
          const LabelText(
            text:
                '2 Cor. 9:15 - "Thanks be unto God for his unspeakable gift."',
            fontSize: AppFontSize.small,
            fontStyle: FontStyle.italic,
          ),
          const Gap(24),

          // Information Cards
          InfoCard(
            title: 'Who We Are?',
            description:
                'We aim to help you develop a personal relationship with God through prayer and Bible study.We aim to help you develop a personal relationship with God through prayer and Bible study',
          ),
          InfoCard(
            title: 'Our Beliefs',
            description:
                'We accept Christ as our Savior and follow the Bible\'s teachings.We accept Christ as our Savior and follow the Bible\'s teachings.We accept Christ as our Savior and follow the Bible\'s teachings',
          ),
          InfoCard(
            title: 'Free Bible Resources',
            description:
                'Access Bible study materials and teachings.We accept Christ as our Savior and follow the Bible\'s teachings.We accept Christ as our Savior and follow the Bible\'s teachings.',
          ),
          const Gap(24),

          // Contact Text
          const LabelText(
            text:
                'If you have any questions or suggestions, feel free to contact us. More information regarding us and all those that contribute to this app can be found here:',
            fontSize: AppFontSize.small,
            textColor: AppColors.darkGray,
          ),
          const Gap(16),

          // Links
          const LinkButton(url: 'www.chicagobible.org'),
          const LinkButton(url: 'www.bibletoday.com'),
          const LinkButton(url: 'www.christianquestions.com'),
          const Gap(20),
        ],
      ),
    );
  }
}
