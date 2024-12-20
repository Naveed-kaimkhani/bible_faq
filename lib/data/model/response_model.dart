import 'package:bible_faq/data/model/category_question.dart';
import 'package:bible_faq/data/model/question.dart';

class ApiResponse {
  Response? response;

  ApiResponse({this.response});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  List<Null>? categoryData;
  List<CategoryQuestionData>? categoryQuestionData;
  List<QuestionData>? questionData;

  Response({this.categoryData, this.categoryQuestionData, this.questionData});

  Response.fromJson(Map<String, dynamic> json) {
    // if (json['category_data'] != null) {
    //   categoryData = <Null>[];
    //   json['category_data'].forEach((v) {
    //     categoryData!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['category_question_data'] != null) {
      categoryQuestionData = <CategoryQuestionData>[];
      json['category_question_data'].forEach((v) {
        categoryQuestionData!.add(CategoryQuestionData.fromJson(v));
      });
    }
    if (json['question_data'] != null) {
      questionData = <QuestionData>[];
      json['question_data'].forEach((v) {
        questionData!.add(new QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.categoryData != null) {
    //   data['category_data'] =
    //       this.categoryData!.map((v) => v.toJson()).toList();
    // }
    if (this.categoryQuestionData != null) {
      data['category_question_data'] =
          this.categoryQuestionData!.map((v) => v.toJson()).toList();
    }
    if (this.questionData != null) {
      data['question_data'] =
          this.questionData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

