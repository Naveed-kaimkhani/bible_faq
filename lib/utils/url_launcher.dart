import 'dart:io';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'https://$url';
  }
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
  Future<void> launchEmail(String emailAddress, {String subject = ''}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: emailAddress,
    query: subject.isNotEmpty ? 'Subject=${Uri.encodeComponent(subject)}' : null,
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    Get.snackbar("Error", "Could not open email client.");
  }
}
Future<void> launchWebsite(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    Get.snackbar("Error", "Could not launch $url");
  }
}
 void shareBibleApp() {
                  const String appLink =
                      "http://bibleresources.info/christian-resources/"; // Replace with your app's URL
                  Share.share(
                    "Check out this amazing app: $appLink",
                    subject: "Share Our Application",
                  );
                }
Future<void> launchBibleApplications() async {
  String url = '';

  // Check the platform and assign the correct URL
  if (Platform.isIOS) {
    url =
        "https://apps.apple.com/pk/app/bible-questions-answers-faq/id910797800?platform=iphone&see-all=developer-other-apps";
  } else if (Platform.isAndroid) {
    url =
        "https://play.google.com/store/apps/collection/cluster?gsr=SkxqGGZCQTB4MXQwSU1RaGprMURlZkduOXc9PbICLwoSCg5jb20uYm9vay5iaWJsZRAHEhcIARITNjg4MjA5OTEyMDgxNDAwNDYyMxgA:S:ANO1ljJNwuQ";
  }

  final Uri launchUri = Uri.parse(url);

  // Launch the URL
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    Get.snackbar("Error", "Could not launch $url");
  }
}
Future<void> launchAppStoreLink() async {
  // Define the default URLs for iOS and Android
  String url;

  if (Platform.isIOS) {
    url = "https://apps.apple.com/pk/app/bible-questions-answers-faq/id910797800"; // iOS App link
  } else if (Platform.isAndroid) {
    url = "https://play.google.com/store/apps/details?id=com.ChristianResources"; // Android App link
  } else {
    Get.snackbar("Unsupported Platform", "This platform is not supported.");
    return;
  }

  final Uri launchUri = Uri.parse(url);

  // Attempt to launch the URL
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    Get.snackbar("Error", "Could not launch $url");
  }
}