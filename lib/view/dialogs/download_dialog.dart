import 'package:bible_faq/constants/app_colors.dart';
import 'package:bible_faq/view_model/api_controller/all_question_provider.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

// class DownloadDialog {
//   static void show() {
//     final DownloadController controller = Get.put(DownloadController());
//     controller.startDownload();
//     final ThemeController themeController = Get.find<ThemeController>();
//     Get.dialog(
//       Obx(() {
//         bool isDarkMode = themeController.isDarkMode.value;
//         return AlertDialog(
//           backgroundColor:
//               isDarkMode ? AppColors.black.withOpacity(.9) : AppColors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Center(
//             child: Text(
//               "Downloading New Questions",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           content: Obx(() {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 20),

//                 // SpinKit Fading Circle Indicator
//                 const Center(
//                   child: SpinKitFadingCircle(
//                     color: Colors.teal,
//                     size: 70,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Progress bar with percentage text
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Downloading... ${(controller.downloadProgress.value * 100).toStringAsFixed(0)}%",
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const Gap(5),
//                     LinearProgressIndicator(
//                       value: controller.downloadProgress.value,
//                       color: Colors.teal,
//                       backgroundColor: Colors.grey[300],
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ],
//             );
//           }),
//           actions: [
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   controller.resetDownload(); // Reset progress
//                   Get.back(); // Close the dialog
//                 },
//                 child: const Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.teal),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),

//       barrierDismissible: false, // Prevent closing dialog by tapping outside
//     );
//   }
// }

// class DownloadDialog {
//   static void show() {
//     final questionController = Get.put(QuestionProviderAPI());
//     final ThemeController themeController = Get.find<ThemeController>();
//     questionController.fetchAndUpdateDataDynamically();
//     Get.dialog(
//       Obx(() {
//         bool isDarkMode = themeController.isDarkMode.value;

//          if (questionController.isLoading.value == false) {
//           Get.back();
//           Get.snackbar("Message", "No New Question Found");
//         }
//         return AlertDialog(
//           backgroundColor:
//               isDarkMode ? AppColors.black.withOpacity(.9) : AppColors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Center(
//             child: Text(
//               "Downloading New Questions",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           content: Obx(() {
//               if (questionController.isLoading.value == false) {
//           Get.back();
//           Get.snackbar("Message", "No New Question Found");
//         }
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 20),

//                 // SpinKit Fading Circle Indicator
//                 const Center(
//                   child: SpinKitFadingCircle(
//                     color: Colors.teal,
//                     size: 70,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Progress bar with percentage text
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Downloading... ${(questionController.downloadProgress.value).toStringAsFixed(0)}%",
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const Gap(5),
//                     LinearProgressIndicator(
//                       value: questionController.downloadProgress.value / 100,
//                       color: Colors.teal,
//                       backgroundColor: Colors.grey[300],
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ],
//             );
//           }),
//           actions: [
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   // Stop loading
//                   Get.back(); // Close the dialog
//                 },
//                 child: const Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.teal),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//       barrierDismissible: false, // Prevent closing dialog by tapping outside
//     );
//   }
// }
class DownloadDialog {
  static void show() {
    final questionController = Get.put(QuestionProviderAPI());
    final ThemeController themeController = Get.find<ThemeController>();

    // Start the download process
    questionController.fetchAndUpdateDataDynamically();

    // Show the dialog
    Get.dialog(
      Obx(() {
        bool isDarkMode = themeController.isDarkMode.value;

        // Automatically close the dialog and show a snackbar if loading is complete
        if (questionController.isLoading.value == false &&
            Get.isDialogOpen == true) {
          Get.back(); // Close the dialog safely
           Get.snackbar(
              "Message",
              "No New Question Found",
              snackPosition: SnackPosition.TOP,
            );
        
        }

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
          content: Column(
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
                  Obx(() {
                    return Text(
                      "Downloading... ${(questionController.downloadProgress.value).toStringAsFixed(0)}%",
                      style: const TextStyle(fontSize: 14),
                    );
                  }),
                  const Gap(5),
                  Obx(() {
                    return LinearProgressIndicator(
                      value: questionController.downloadProgress.value / 100,
                      color: Colors.teal,
                      backgroundColor: Colors.grey[300],
                    );
                  }),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  // Stop loading
                  questionController.isLoading.value = false; // Reset the state
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
