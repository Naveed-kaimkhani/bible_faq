import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final String url;

  const LinkButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: IntrinsicWidth(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.link, color: AppColors.tealBlue),
                const SizedBox(width: 8),
                LabelText(
                  text: url,
                  textColor: AppColors.tealBlue,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.tealBlue,
                  isChangeTextColor: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
