import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIManager {
  static final APIManager shared = APIManager();

  // Base URLs
  static const String baseUrl =
      "https://m.bibleresources.info/webservices/faq/";
  static const String endpoint =
      "database_category.php?category_catid=156&questions_qid=2222&category_questions_count=4500";

  static const String staticBaseUrl =
      "https://m.bibleresources.info/webservices/cr/";

  // Headers
  Map<String, String> get headers => {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept-Encoding": "gzip, deflate",
      };

  Future<Map<String, dynamic>?> requestGetMethodForAllQuestion(
      {required int latestCatId,
      required int latestQId,
      required int totalCount}) async {
    final endpoint =
        "database_category.php?category_catid=$latestCatId&questions_qid=$latestQId&category_questions_count=$totalCount";
    final url = Uri.parse(baseUrl + endpoint);

    try {
      // Make the HTTP GET request
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData; // Return raw JSON
      } else {
        Get.snackbar(
            "Error", "HTTP ${response.statusCode}: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", "Request failed: $e");
      return null;
    }
  }

  // GET Static Web URL
  Future<void> getStaticWebURL({
    required String endpoint,
    required BuildContext context,
    required Function(String) onSuccess,
  }) async {
    if (!await isNetworkConnected()) {
      _showAlertDialog(context, "No Internet Connection");
      return;
    }

    _showProgressDialog(context);

    final url = Uri.parse(staticBaseUrl + endpoint);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        onSuccess(jsonData['link']);
      } else {
        Get.snackbar("Error", 'HTTP ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar("Error", 'Request failed: $e');
    } finally {
      Navigator.pop(context); // Hide loader
    }
  }

  // General Request Method
  Future<void> requestService({
    required String endpoint,
    required String method,
    required Map<String, dynamic> params,
    required BuildContext context,
    bool isInfoNull = false,
    required Function(Map<String, dynamic>) onSuccess,
  }) async {
    _showProgressDialog(context);

    final url = Uri.parse(staticBaseUrl + endpoint);

    try {
      late http.Response response;

      if (method == "POST") {
        response = await http.post(url, body: params);
      } else {
        response = await http.get(
          url,
        );
      }

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        onSuccess(jsonData);
      } else {
        Get.snackbar("Error", 'HTTP ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar("Error", 'Request failed: $e');
    } finally {
      Navigator.pop(context); // Hide loader
    }
  }

  // Helper: Check network connectivity
  Future<bool> isNetworkConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Helper: Show Alert Dialog
  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper: Show Progress Dialog
  void _showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
