import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = (Get.isDarkMode).obs;

  void toggleTheme() {
    if (isDarkMode.value) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
    isDarkMode.value = !isDarkMode.value;
  }

  // Monitor the system theme changes
  void updateThemeBasedOnSystem() {
    final Brightness brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
  }

  @override
  void onInit() {
    super.onInit();
    updateThemeBasedOnSystem();
    // Listen for system theme changes in real-time
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      updateThemeBasedOnSystem();
    };
  }
}
