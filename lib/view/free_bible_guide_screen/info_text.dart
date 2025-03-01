import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  const InfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return const LabelText(
      text:
          "Get your FREE Bible guide shipped to over 100 countries! Fill out the form to receive your guide by mail.",
      textColor: AppColors.lightGray,
      isChangeTextColor: false,
    );
  }
}
