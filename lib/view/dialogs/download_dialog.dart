import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DownloadDialog {
  static void show() {
    final DownloadController controller = Get.put(DownloadController());
    controller.startDownload();
    final ThemeController themeController = Get.find<ThemeController>();
    Get.dialog(
      Obx(() {
        bool isDarkMode = themeController.isDarkMode.value;
        return AlertDialog(
          backgroundColor:
              isDarkMode ? AppColors.black.withOpacity(.9) : AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Center(
            child: Text(
              "Downloading New Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          content: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),

                // SpinKit Fading Circle Indicator
                const Center(
                  child: SpinKitFadingCircle(
                    color: Colors.teal,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 20),

                // Progress bar with percentage text
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Downloading... ${(controller.downloadProgress.value * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Gap(5),
                    LinearProgressIndicator(
                      value: controller.downloadProgress.value,
                      color: Colors.teal,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            );
          }),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  controller.resetDownload(); // Reset progress
                  Get.back(); // Close the dialog
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ),
          ],
        );
      }),

      barrierDismissible: false, // Prevent closing dialog by tapping outside
    );
  }
}
