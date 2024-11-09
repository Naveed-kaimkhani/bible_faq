import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DownloadController extends GetxController {
  var downloadProgress = 0.0.obs;

  void startDownload() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (downloadProgress.value >= 1.0) {
        timer.cancel();
      } else {
        downloadProgress.value += 0.01; // Increment progress
      }
    });
  }

  void resetDownload() {
    downloadProgress.value = 0.0;
  }
}

class DownloadDialog {
  static void show() {
    final DownloadController controller = Get.put(DownloadController());
    controller.startDownload();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
      ),
      barrierDismissible: false, // Prevent closing dialog by tapping outside
    );
  }
}
