import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const LabelText(
      text:
          "Discover peace and comfort through the Bible. We are offering a FREE Bible study guide by mail that explains five essential methods for studying the Bible:",
      textColor: AppColors.lightGray,
      isChangeTextColor: false,
    );
  }
}
