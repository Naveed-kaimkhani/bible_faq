import 'package:bible_faq/components/componets.dart'; // Assuming CustomGradientButton is here
import 'package:bible_faq/constants/app_colors.dart';
import 'package:flutter/material.dart';
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

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Center(
          child: Text(
            "Adjust Font Size",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "The Lord is my shepherd; I shall not want. — Psalm 23:1",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),

              // Font selection options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _fontOptionButton(controller, "Arial"),
                  _fontOptionButton(controller, "Gentium"),
                  _fontOptionButton(controller, "Georgia"),
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
                style: TextStyle(color: AppColors.tealBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create font option button
  static Widget _fontOptionButton(FontSizeController controller, String font) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.setFont(font);
        },
        child: Column(
          children: [
            Text(font,
                style: TextStyle(
                    fontWeight: controller.selectedFont.value == font
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: controller.selectedFont.value == font
                        ? AppColors.tealBlue
                        : Colors.black)),
            const SizedBox(height: 4),
            Text(
              "A",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: controller.selectedFont.value == font
                    ? AppColors.tealBlue
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
