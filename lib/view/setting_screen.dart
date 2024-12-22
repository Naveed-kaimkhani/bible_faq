import 'package:bible_faq/components/componets.dart';
import 'package:bible_faq/constants/constants.dart';
import 'package:bible_faq/view/dialogs/dialos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Resources",
      ),
      body: BodyContainerComponent(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: 'Application'),
              _buildMenuItemCard(children: [
                menuItem(
                  icon: AppSvgIcons.home,
                  label: 'Home',
                  ontap: () {
                    Get.toNamed(AppRouts.homeScreen);
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.userQuestion,
                  label: 'All Questions',
                  ontap: () {
                    Get.toNamed(AppRouts.allBibleQuestionAnswerScreen);
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.file,
                  label: 'Bible Topics',
                  ontap: () {
                    Get.toNamed(AppRouts.bibleTopicsScreen);
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.stackStar,
                  label: 'My Favourite Questions',
                  ontap: () {
                    Get.toNamed(AppRouts.myFavouritQuestionScreen);
                  },
                ),
                // menuItem(
                //   icon: AppSvgIcons.userStar,
                //   label: 'My Browsing History',
                //   isShowDivider: false,
                //   ontap: () {
                //     Get.toNamed(AppRouts.browsingHistryScreen);
                //   },
                // ),
              ]),
              const Gap(15),
              const TitleText(text: 'Settings'),
              _buildMenuItemCard(children: [
                menuItem(
                    icon: AppSvgIcons.bookDownload,
                    label: 'Download New Questions',
                    ontap: () {
                      DownloadDialog.show();
                    }),
                menuItem(
                    icon: AppSvgIcons.moon,
                    label: 'Dark Mode',
                    ontap: () {
                      DarkModeDialog.show();
                    }),
                menuItem(
                  icon: AppSvgIcons.textFont,
                  label: 'Font Size',
                  isShowDivider: false,
                  ontap: () {
                    FontSizeDialog.show();
                  },
                ),
              ]),
              const Gap(15),
              const TitleText(text: 'Resources'),
              _buildMenuItemCard(children: [
                menuItem(
                  icon: AppSvgIcons.userGroup,
                  label: 'About Us',
                  ontap: () {
                    Get.toNamed(AppRouts.aboutUsScreen);
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.link,
                  label: 'News And Resources',
                  ontap: () {
                    Get.toNamed(AppRouts.newsAndResourcesScreen);
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.browser,
                  label: 'View Our Website',
                  ontap: () async {
                    final Uri url = Uri.parse("https://bibleresources.info/");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      Get.snackbar("Error", "Could not launch $url");
                    }
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.book,
                  label: 'Free Bible Guide',
                  ontap: () {
                    Get.toNamed(AppRouts.freeBilbeGuideScreen);
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.arrowShuffle,
                  label: 'More Bible Applications',
                  ontap: () {
                    Get.toNamed(AppRouts.latestQuestionScreen);
                  },
                ),
                menuItem(
                  icon: AppSvgIcons.mailAtSign,
                  label: 'Contact Us',
                  isShowDivider: false,
                  ontap: () {
                    Get.toNamed(AppRouts.askQuestionScreen);
                  },
                ),
              ]),
              const Gap(15),
              const TitleText(text: 'Mobile App'),
              _buildMenuItemCard(children: [
                // menuItem(icon: AppSvgIcons.share, label: 'Share Application'),
                menuItem(
                  icon: AppSvgIcons.share,
                  label: 'Share Application',
                  ontap: () {
                    const String appLink =
                        "https://example.com/yourapp"; // Replace with your app's URL
                    Share.share(
                      "Check out this amazing app: $appLink",
                      subject: "Share Our Application",
                    );
                  },
                ),
                menuItem(icon: AppSvgIcons.star, label: 'Rate Application'),
                menuItem(icon: AppSvgIcons.book, label: 'Update Application'),
                menuItem(
                    icon: AppSvgIcons.bug, label: 'Report a Bug or Suggestion'),
                menuItem(
                  icon: AppSvgIcons.mailAtSign,
                  label: 'App Version 4.0.1',
                  isShowDivider: false,
                  hideLadingAndTrailing: true,
                ),
              ]),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemCard({required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget menuItem({
    required String icon,
    required String label,
    bool isShowDivider = true,
    bool hideLadingAndTrailing = false,
    VoidCallback? ontap,
  }) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 45,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          leading: hideLadingAndTrailing
              ? const SizedBox.shrink()
              : SvgPicture.asset(icon),
          title: LabelText(text: label),
          trailing: hideLadingAndTrailing
              ? const SizedBox.shrink()
              : const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: ontap,
        ),
        isShowDivider
            ? const Divider(
                height: 0,
                endIndent: 16,
                indent: 16,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
