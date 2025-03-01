import 'package:bible_app/components/componets.dart';
import 'package:bible_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StudyMethod extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const StudyMethod({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          text: "$number. $title",
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: LabelText(
            text: description,
            textColor: AppColors.lightGray,
            isChangeTextColor: false,
          ),
        ),
        const Gap(16),
      ],
    );
  }
}
