import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/data/model/response_model.dart';
import 'package:bible_faq/model/model.dart';
import 'package:bible_faq/services/api_services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionProviderAPI extends GetxController {
  // Observable loading state
  var isLoading = false.obs;

  // Observable for network error
  var isNetworkError = false.obs;

  var apiResponse = ApiResponse().obs;
  // Method to call GET request
  Future<void> requestGet() async {
    try {
      isLoading.value = true; // Start loading
      var response = await APIManager.shared.requestGetMethodForAllQuestion();
      print("resposne: $response");
      if (response != null) {
        apiResponse.value = response; // Update the Rx variable
      }
      isLoading.value = false; // Start loading
    } catch (e) {
      print("Error: $e");
      isNetworkError.value = false;
      Get.snackbar("Error", "Failed to fetch data: $e");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch staff data when the controller is initialized
    requestGet();
  }
}
