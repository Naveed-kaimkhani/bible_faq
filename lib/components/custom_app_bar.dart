// import 'dart:developer';

// import 'package:bible_faq/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   final String title;
//   final bool isShowSettingTrailing;
//   final bool isShowStarTrailing;
//   final bool isShowShareTrailing;
//   final bool isShowInternetTrailing;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.isShowSettingTrailing = false,
//     this.isShowStarTrailing = false,
//     this.isShowShareTrailing = false,
//     this.isShowInternetTrailing = false,
//   });

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(65);
// }

// class _CustomAppBarState extends State<CustomAppBar> {
//   bool isDarkMode = Get.theme.brightness == Brightness.dark;

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(65),
//       child: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: isDarkMode
//                   ? [
//                       const Color(0xFF2A2D32), // Dark gradient color 1
//                       const Color(0xFF1B1E25), // Dark gradient color 2
//                     ]
//                   : [
//                       AppColors.aquaBlue, // Light gradient color 1
//                       AppColors.tealBlue, // Light gradient color 2
//                     ],
//             ),
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         leading: appBarButton(
//           Icon(
//             Icons.arrow_back_ios,
//             color: isDarkMode ? Colors.white : AppColors.tealBlue,
//           ),
//           () {
//             Get.back();
//           },
//         ),
//         title: Text(
//           widget.title,
//           style: const TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: AppFontSize.xmedium,
//             color: AppColors.white,
//           ),
//         ),
//         actions: [
//           if (widget.isShowShareTrailing)
//             const Icon(Icons.ios_share_outlined, color: AppColors.white),
//           if (widget.isShowShareTrailing) const Gap(10),
//           if (widget.isShowStarTrailing)
//             const Icon(Icons.star_border_rounded, color: AppColors.white),
//           if (widget.isShowStarTrailing) const Gap(10),
//           if (widget.isShowInternetTrailing)
//             const Icon(Icons.swap_vert_outlined, color: AppColors.white),
//           if (widget.isShowInternetTrailing) const Gap(10),
//           if (widget.isShowSettingTrailing)
//             GestureDetector(
//                 onTap: () {
//                   log("on tap");
//                   Get.toNamed(AppRouts.settingScreen);
//                 },
//                 child: const Icon(Icons.settings_outlined,
//                     color: AppColors.white)),
//           if (widget.isShowSettingTrailing) const Gap(9),
//         ],
//         backgroundColor: AppColors.transparent,
//         elevation: 0,
//       ),
//     );
//   }

//   Widget appBarButton(Icon icon, VoidCallback onTap) {
//     return Transform.scale(
//       scaleX: 0.7,
//       scaleY: 0.7,
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 39,
//           width: 39,
//           decoration: BoxDecoration(
//             color: isDarkMode ? AppColors.transparent : AppColors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: isDarkMode
//                 ? Border.all(
//                     color: AppColors.white,
//                   )
//                 : null,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: Center(
//               child: Transform.scale(
//                 alignment: Alignment.centerLeft,
//                 scaleX: 1.5,
//                 scaleY: 1.5,
//                 child: icon,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowSettingTrailing;
  final bool isShowStarTrailing;
  final bool isShowShareTrailing;
  final bool isShowInternetTrailing;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isShowSettingTrailing = false,
    this.isShowStarTrailing = false,
    this.isShowShareTrailing = false,
    this.isShowInternetTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get the ThemeController instance
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;

      return PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? [
                        const Color(0xFF2A2D32), // Dark gradient color 1
                        const Color(0xFF1B1E25), // Dark gradient color 2
                      ]
                    : [
                        AppColors.aquaBlue, // Light gradient color 1
                        AppColors.tealBlue, // Light gradient color 2
                      ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          leading: appBarButton(
            Icon(
              Icons.arrow_back_ios,
              color: isDarkMode ? Colors.white : AppColors.tealBlue,
            ),
            () {
              Get.back();
            },
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.xmedium,
              color: AppColors.white,
            ),
          ),
          actions: [
            if (isShowShareTrailing)
              const Icon(Icons.ios_share_outlined, color: AppColors.white),
            if (isShowShareTrailing) const Gap(10),
            if (isShowStarTrailing)
              const Icon(Icons.star_border_rounded, color: AppColors.white),
            if (isShowStarTrailing) const Gap(10),
            if (isShowInternetTrailing)
              const Icon(Icons.swap_vert_outlined, color: AppColors.white),
            if (isShowInternetTrailing) const Gap(10),
            if (isShowSettingTrailing)
              GestureDetector(
                onTap: () {
                  log("on tap");
                  Get.toNamed(AppRouts.settingScreen);
                },
                child:
                    const Icon(Icons.settings_outlined, color: AppColors.white),
              ),
            if (isShowSettingTrailing) const Gap(9),
          ],
          backgroundColor: AppColors.transparent,
          elevation: 0,
        ),
      );
    });
  }

  Widget appBarButton(Icon icon, VoidCallback onTap) {
    final themeController =
        Get.find<ThemeController>(); // Retrieve ThemeController

    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value; // Use observable

      return Transform.scale(
        scaleX: 0.7,
        scaleY: 0.7,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.transparent : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: isDarkMode
                  ? Border.all(
                      color: AppColors.white,
                    )
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: Transform.scale(
                  alignment: Alignment.centerLeft,
                  scaleX: 1.5,
                  scaleY: 1.5,
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
