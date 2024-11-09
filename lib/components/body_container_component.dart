import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyContainerComponent extends StatelessWidget {
  const BodyContainerComponent({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.only(
      top: 16.0,
      left: 16,
      right: 16,
    ),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(
      () {
        bool isDarkMode = themeController.isDarkMode.value;

        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.black : AppColors.whiteBlue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
      },
    );
  }
}
