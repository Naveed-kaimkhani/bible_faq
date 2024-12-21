import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view_model/api_controller/all_question_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchAndSettingsRow extends StatelessWidget {
  const SearchAndSettingsRow({super.key, required this.isDarkMode});
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const Gap(3),
          const Expanded(child: CustomTextField()),
          const Gap(10),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.lightBlack : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isDarkMode ? [] : _boxShadow(),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Get.toNamed(AppRouts.settingScreen);
                  
  final controller = Get.find<QuestionProviderAPI>();
  // controller.requestGet();
                },
                child: const Icon(Icons.settings_outlined),
              ),
            ),
          ),
          const Gap(3),
        ],
      ),
    );
  }

  List<BoxShadow> _boxShadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        offset: const Offset(-2, 2),
        blurRadius: 4,
        spreadRadius: 1,
      ),
    ];
  }
}
