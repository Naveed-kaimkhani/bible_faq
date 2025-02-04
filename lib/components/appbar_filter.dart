import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view_model/controllers/controllers.dart';
import 'package:bible_faq/view_model/controllers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomAppBarForFilter extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool isShowSettingTrailing;
  final bool isShowStarTrailing;
  final bool isShowShareTrailing;
  final bool isShowInternetTrailing;
  final bool isShowFavButton;
  final int? qid;
  final VoidCallback? onFilterTap;
  final RxString sortOrder;
  final ValueChanged<String?> onSortChanged;

  CustomAppBarForFilter({
    super.key,
    required this.title,
    this.qid,
    this.isShowSettingTrailing = false,
    this.isShowFavButton = false,
    this.isShowStarTrailing = false,
    this.isShowShareTrailing = false,
    this.onFilterTap,
    this.isShowInternetTrailing = false,
    required this.sortOrder,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;

      return AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [Color(0xFF2A2D32), Color(0xFF1B1E25)]
                  : [AppColors.aquaBlue, AppColors.tealBlue],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: appBarButton(
          Icon(Icons.arrow_back_ios,
              color: isDarkMode ? Colors.white : AppColors.tealBlue),
          () => Get.back(),
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
            Icon(Icons.ios_share_outlined, color: AppColors.white),
          if (isShowStarTrailing) Gap(10),
          // if (isShowInternetTrailing) GestureDetector(
          //   child: Icon(Icons.filter_alt_outlined),
          //   onTap: onFilterTap,
          // ),
          Obx(() => DropdownButton<String>(
                value: sortOrder.value,
                dropdownColor: isDarkMode ? Colors.black : Colors.white,
                icon: Icon(Icons.sort, color: AppColors.white),
                onChanged: onSortChanged,
                items: ['Newest First', 'Oldest First', 'Alphabetical (A-Z)']
                    .map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    // child: SizedBox(),
                    child: Text(option,
                        style: TextStyle(
                            color:
                                isDarkMode ? Colors.white : AppColors.black)),
                  );
                }).toList(),
              )),
          if (isShowFavButton)
            GestureDetector(
              onTap: () {
                final favProvider = Get.put(FavoritesProvider());
                favProvider.toggleFavorite(qid.toString());
              },
              child: Obx(() {
                final favProvider = Get.put(FavoritesProvider());
                bool isFav = favProvider.isFavorite(qid.toString());
                return Icon(
                  isFav ? Icons.star : Icons.star_border,
                  color: Colors.white,
                );
              }),
            ),
          SizedBox(
            width: 10,
          ),
          if (isShowSettingTrailing)
            GestureDetector(
              onTap: () => Get.toNamed(AppRouts.settingScreen),
              child: Icon(Icons.settings_outlined, color: AppColors.white),
            ),
          if (isShowSettingTrailing) Gap(9),
        ],
        backgroundColor: AppColors.transparent,
        elevation: 0,
      );
    });
  }

  Widget appBarButton(Icon icon, VoidCallback onTap) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 39,
          width: 39,
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.transparent : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: isDarkMode ? Border.all(color: AppColors.white) : null,
          ),
          child: Center(child: icon),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
