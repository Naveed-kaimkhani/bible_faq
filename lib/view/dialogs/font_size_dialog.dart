import 'package:bible_faq/components/componets.dart'; // Assuming CustomGradientButton is here
import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:bible_faq/view_model/font_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FontSizeDialog {
  static void show() async {
    final FontSizeController controller = Get.put(FontSizeController());
    final ThemeController themeController = Get.find<ThemeController>();
    ValueNotifier<double> tempFontSize =
        ValueNotifier(controller.fontSize.value);

    Get.dialog(
      Obx(() {
        bool isDarkMode = themeController.isDarkMode.value;

        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Center(
            child: Text(
              "Adjust Font Size",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Preview text using temporary font size
              ValueListenableBuilder(
                valueListenable: tempFontSize,
                builder: (context, value, child) => Text(
                  "The Lord is my shepherd; I shall not want. — Psalm 23:1",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: tempFontSize.value,
                    // fontStyle: FontStyle.italic,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _fontOptionButton(controller, "Arial", isDarkMode),
                  _fontOptionButton(controller, "Gentium", isDarkMode),
                  _fontOptionButton(controller, "Georgia", isDarkMode),
                ],
              ),
              const SizedBox(height: 16),
              // Slider updates the temporary font size
              ValueListenableBuilder(
                valueListenable: tempFontSize,
                builder: (context, value, child) => Slider.adaptive(
                  value: tempFontSize.value,
                  min: 12,
                  max: 50,
                  activeColor: AppColors.tealBlue,
                  onChanged: (value) {
                    tempFontSize.value = value;
                  },
                ),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomGradientButton(
                text: "Apply",
                onTap: () async {
                  controller.setFontSize(tempFontSize.value);
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
                  style: TextStyle(
                    color: AppColors.tealBlue,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  static Widget _fontOptionButton(
      FontSizeController controller, String font, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        controller.setFont(font);
      },
      child: Obx(() {
        return Column(
          children: [
            LabelText(
              text: font,
              fontWeight: controller.selectedFont.value == font
                  ? FontWeight.bold
                  : FontWeight.normal,
              textColor: controller.selectedFont.value == font
                  ? AppColors.tealBlue
                  : (isDarkMode ? Colors.white : Colors.black),
            ),
            const Gap(4),
            TitleText(
              text: "A",
              textColor: controller.selectedFont.value == font
                  ? AppColors.tealBlue
                  : (isDarkMode ? Colors.white : Colors.black),
            ),
          ],
        );
      }),
    );
  }
}
