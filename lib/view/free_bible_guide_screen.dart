

// import 'package:bible_faq/components/componets.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// class FreeBibleGuideScreen extends StatefulWidget {
//   const FreeBibleGuideScreen({super.key});

//   @override
//   _FreeBibleGuideScreenState createState() => _FreeBibleGuideScreenState();
// }

// class _FreeBibleGuideScreenState extends State<FreeBibleGuideScreen> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('Error loading page: ${error.description}');
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(
//           'https://m.bibleresources.info/includes/htsb/htsb-form.php?source=faq-android-new&mode=dark'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Free Bible Guide"),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }


import 'package:bible_faq/components/componets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FreeBibleGuideScreen extends StatefulWidget {
  const FreeBibleGuideScreen({super.key});

  @override
  _FreeBibleGuideScreenState createState() => _FreeBibleGuideScreenState();
}

class _FreeBibleGuideScreenState extends State<FreeBibleGuideScreen> {
  late final WebViewController _controller;
  bool _isLoading = true; // State to track loading status

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            setState(() {
              _isLoading = true; // Show loading indicator
            });
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              _isLoading = false; // Hide loading indicator
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error loading page: ${error.description}');
            setState(() {
              _isLoading = false; // Hide loading indicator
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://m.bibleresources.info/includes/htsb/htsb-form.php?source=faq-android-new&mode=dark'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Free Bible Guide"),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
