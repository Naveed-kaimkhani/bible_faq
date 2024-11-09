import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final InfoCardController controller;

  InfoCard({
    super.key,
    required this.title,
    required this.description,
  }) : controller =
            InfoCardController(); // Each instance has its own controller

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(text: title),
              const Gap(8),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Obx(() {
                    bool shouldShowToggle = false;
                    String displayText = description;

                    // Determine if the text exceeds two lines
                    final TextPainter textPainter = TextPainter(
                      text: TextSpan(
                        text: description,
                        style: const TextStyle(fontSize: 14),
                      ),
                      maxLines: 2,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    // Check if text exceeds maxLines of 2 when not expanded
                    if (textPainter.didExceedMaxLines) {
                      shouldShowToggle = true;
                      // Shorten display text if not expanded
                      if (!controller.isExpanded.value) {
                        displayText = '${description.substring(0, 50)}...';
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.lightGray,
                            ),
                            children: [
                              TextSpan(text: displayText),
                              if (shouldShowToggle)
                                TextSpan(
                                  text: controller.isExpanded.value
                                      ? ' Show Less'
                                      : ' Read More',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      controller.toggleExpanded();
                                    },
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
