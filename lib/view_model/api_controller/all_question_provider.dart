// import 'package:bible_faq/data/model/question.dart';
// import 'package:bible_faq/data/model/response_model.dart';
// import 'package:bible_faq/model/model.dart';
// import 'package:bible_faq/services/api_services/api_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class QuestionProviderAPI extends GetxController {
//   // Observable loading state
//   var isLoading = false.obs;

//   // Observable for network error
//   var isNetworkError = false.obs;

//   var apiResponse = ApiResponse().obs;
//   // Method to call GET request
//   Future<void> requestGet() async {
//     try {
//       isLoading.value = true; // Start loading
//       var response = await APIManager.shared.requestGetMethodForAllQuestion();
//       print("resposne: $response");
//       if (response != null) {
//         apiResponse.value = response; // Update the Rx variable
//       }
//       isLoading.value = false; // Start loading
//     } catch (e) {
//       print("Error: $e");
//       isNetworkError.value = false;
//       Get.snackbar("Error", "Failed to fetch data: $e");
//     } finally {
//       isLoading.value = false; // Stop loading
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     // Fetch staff data when the controller is initialized
//     requestGet();
//   }
// }

import 'package:get/get.dart';
import 'package:bible_faq/services/api_services/api_manager.dart';
import 'package:bible_faq/data/model/category_question.dart';
import 'package:bible_faq/data/model/question.dart';
import 'package:bible_faq/data/model/response_model.dart';

class QuestionProviderAPI extends GetxController {
  // Observable loading state
  var isLoading = false.obs;

  // Observable for network error
  var isNetworkError = false.obs;

  // Observable for parsed API response
  var apiResponse = ApiResponse().obs;

  // Observables for specific data
  var questions = <QuestionData>[].obs;
  var categoryQuestions = <CategoryQuestionData>[].obs;

  // Method to call GET request
  Future<void> requestGet() async {
    try {
      isLoading.value = true; // Start loading
      print("Fetching data from API...");

      var response = await APIManager.shared.requestGetMethodForAllQuestion();

      if (response != null) {
        // Parse the response into ApiResponse
        apiResponse.value = ApiResponse.fromJson(response as Map<String, dynamic>);
        print("API Response parsed successfully.");

        // Extract specific data from the parsed response
        if (apiResponse.value.response != null) {
          questions.value = apiResponse.value.response!.questionData ?? [];
          categoryQuestions.value =
              apiResponse.value.response!.categoryQuestionData ?? [];
          print(
              "Questions: ${questions.length}, Category Questions: ${categoryQuestions.length}");
        }
      } else {
        print("API response is null.");
        Get.snackbar("Error", "Failed to fetch data. API returned null.");
      }
    } catch (e) {
      print("Error during API call: $e");
      isNetworkError.value = true; // Set network error state
      Get.snackbar("Error", "Failed to fetch data: $e");
    } finally {
      isLoading.value = false; // Stop loading
      print("Loading state set to false.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Automatically fetch data when the controller is initialized
    print("Initializing QuestionProviderAPI...");
    requestGet();
  }
}
