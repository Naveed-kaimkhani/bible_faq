import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIManager {
  static final APIManager shared = APIManager();

  // Base URLs
  static const String baseUrl = "https://m.bibleresources.info/webservices/faq/";
  static const String staticBaseUrl = "https://m.bibleresources.info/webservices/cr/";

  // Headers
  Map<String, String> get headers => {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept-Encoding": "gzip, deflate",
      };

  // GET Request
  Future<void> requestGetMethod({
    required String endpoint,
    required BuildContext context,
    bool showLoader = true,
    required Function(Map<String, dynamic>) onSuccess,
  }) async {
    if (!await isNetworkConnected()) {
      _showAlertDialog(context, "No Internet Connection");
      return;
    }

    if (showLoader) _showProgressDialog(context);

    final url = Uri.parse(baseUrl + endpoint);

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        onSuccess(jsonData);
        print( jsonDecode(response.body));
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Request failed: $e");
    } finally {
      if (showLoader) Navigator.pop(context); // Hide loader
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
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        onSuccess(jsonData['link']);
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Request failed: $e");
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
    if (!await isNetworkConnected()) {
      _showAlertDialog(context, "No Internet Connection");
      return;
    }

    _showProgressDialog(context);

    final url = Uri.parse(staticBaseUrl + endpoint);

    try {
      late http.Response response;

      if (method == "POST") {
        response = await http.post(url, headers: headers, body: params);
      } else {
        response = await http.get(url, headers: headers);
      }

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        onSuccess(jsonData);
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Request failed: $e");
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
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
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
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
