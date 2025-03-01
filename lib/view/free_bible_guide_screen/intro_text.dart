import 'package:bible_app/constants/constants.dart';
import 'package:flutter/material.dart';

class IntroText extends StatelessWidget {
  const IntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text:
                "Discover peace and comfort through the Bible. We are offering a ",
            style: TextStyle(
              fontSize: AppFontSize.small,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGray,
            ),
          ),
          TextSpan(
            text: "FREE Bible study guide by mail",
            style: TextStyle(
              fontSize: AppFontSize.small,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
