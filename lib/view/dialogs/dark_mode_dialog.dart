import 'dart:developer';

import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeController extends GetxController {
  var selectedOption = 1.obs; // Default selection: OFF

  void setOption(int value) {
    selectedOption.value = value;
  }
}

class DarkModeDialog {
  static void show() {
    log("show method call");
    final DarkModeController controller = Get.put(DarkModeController());
    final ThemeController themeController = Get.find<ThemeController>();
    Get.dialog(Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;
      return AlertDialog(
        backgroundColor:
            isDarkMode ? AppColors.black.withOpacity(.9) : AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Center(
          child: TitleText(
            text: "Dark Mode",
          ),
        ),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRadioOption(
                text: "Match Device Setting",
                value: 0,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  if (value != null) controller.setOption(value);
                },
              ),
              CustomRadioOption(
                text: "OFF",
                value: 1,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  if (value != null) controller.setOption(value);
                },
              ),
              CustomRadioOption(
                text: "ON",
                value: 2,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  if (value != null) controller.setOption(value);
                },
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomGradientButton(
              text: "Apply",
              onTap: () {
                Get.back();
              },
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColors.tealBlue),
              ),
            ),
          ),
        ],
      );
    }));
  }
}

class CustomRadioOption extends StatelessWidget {
  final String text;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  const CustomRadioOption({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LabelText(text: text),
          Radio<int>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppColors.tealBlue,
          ),
        ],
      ),
    );
  }
}
