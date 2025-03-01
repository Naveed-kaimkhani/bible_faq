import 'package:bible_app/components/componets.dart';
import 'package:bible_app/view_model/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AskAQuestionScreen extends StatefulWidget {
  const AskAQuestionScreen({super.key});

  @override
  FreeBibleGuideScreenState createState() => FreeBibleGuideScreenState();
}

class FreeBibleGuideScreenState extends State<AskAQuestionScreen> {
  late final WebViewController _controller;
  bool _isLoading = true; // State to track loading status
  final ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    bool isDarkMode = themeController.isDarkMode.value;
    final String mode = isDarkMode ? "dark" : "light";
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true; // Show loading indicator
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false; // Hide loading indicator
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false; // Hide loading indicator
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://m.bibleresources.info/includes/faq/ask_question.php?mode=$mode'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Ask a question"),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        ],
      ),
    );
  }
}
