import 'package:bible_app/constants/constants.dart';
import 'package:bible_app/utils/local_storage_util.dart';
import 'package:bible_app/view/dialogs/download_dialog.dart';
import 'package:bible_app/view/home_screen/home_screen.dart';
import 'package:bible_app/view_model/controllers/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkAndShowDownloadDialog();
  }

  Future<void> _checkAndShowDownloadDialog() async {
    bool hasPromptDate = await LocalStorageUtil.hasLastPromptDate();
    DateTime? lastPromptDate = await LocalStorageUtil.getLastPromptDate();
    DateTime currentDate = DateTime.now();

    if (!hasPromptDate ||
        currentDate.difference(lastPromptDate!).inDays >= 10) {
      _showDownloadDialog();
      await LocalStorageUtil.saveLastPromptDate(currentDate);
    }
  }

  void _showDownloadDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Download New Questions'),
          content: const Text('Would you like to download new questions?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.of(context).pop();
                DownloadDialog.show();
                await LocalStorageUtil.saveLastPromptDate(DateTime.now());
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;
      return Scaffold(
        backgroundColor: isDarkMode ? AppColors.black : AppColors.whiteBlue,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(25),
                SizedBox(
                  height: Get.height * 0.10,
                  child: SearchAndSettingsRow(isDarkMode: isDarkMode),
                ),
                const Gap(12),
                AllBilbeQuestionAndAnswerCard(),
                const Gap(12),
                const ExploreResourcesSection(),
                const Gap(12),
                const LatestQuestionSection(),
                const Gap(15),
                BibleTopicsSection(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
