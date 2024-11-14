import 'package:bible_faq/components/componets.dart'; // Assuming CustomGradientButton is here
import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FontSizeController extends GetxController {
  var selectedFont = "Arial".obs;
  var fontSize = 16.0.obs;

  void setFont(String font) {
    selectedFont.value = font;
  }

  void setFontSize(double size) {
    fontSize.value = size;
  }
}

class FontSizeDialog {
  static void show() {
    final FontSizeController controller = Get.put(FontSizeController());
    final ThemeController themeController =
        Get.find<ThemeController>(); // Assume ThemeController manages dark mode

    Get.dialog(
      Obx(() {
        bool isDarkMode = themeController.isDarkMode.value;
        return AlertDialog(
          backgroundColor: isDarkMode
              ? Colors.grey[900] // Dark background for dark mode
              : Colors.white, // Light background for light mode
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
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "The Lord is my shepherd; I shall not want. — Psalm 23:1",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Font selection options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _fontOptionButton(controller, "Arial", isDarkMode),
                    _fontOptionButton(controller, "Gentium", isDarkMode),
                    _fontOptionButton(controller, "Georgia", isDarkMode),
                  ],
                ),

                const SizedBox(height: 16),

                Slider.adaptive(
                  value: controller.fontSize.value,
                  min: 12,
                  max: 32,
                  activeColor: AppColors.tealBlue,
                  onChanged: (value) {
                    controller.setFontSize(value);
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
                  // Apply the font changes
                  Get.back(); // Close the dialog
                },
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog without saving
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

// Helper method to create font option button
  static Widget _fontOptionButton(
      FontSizeController controller, String font, bool isDarkMode) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.setFont(font);
        },
        child: Column(
          children: [
            LabelText(
              text: font,
              fontWeight: controller.selectedFont.value == font
                  ? FontWeight.bold
                  : FontWeight.normal,
              textColor: controller.selectedFont.value == font
                  ? AppColors
                      .tealBlue // Teal blue for selected font in both themes
                  : (isDarkMode
                      ? Colors.white
                      : Colors
                          .black), // White in dark mode, black in light mode for unselected fonts
            ),
            const Gap(4),
            TitleText(
              text: "A",
              textColor: controller.selectedFont.value == font
                  ? AppColors
                      .tealBlue // Teal blue for selected font in both themes
                  : (isDarkMode
                      ? Colors.white
                      : Colors
                          .black), // White in dark mode, black in light mode for unselected fonts
            ),
          ],
        ),
      );
    });
  }
}
