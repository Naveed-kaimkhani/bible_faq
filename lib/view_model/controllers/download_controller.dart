import 'dart:async';

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
