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

class CategoryQuestionData {
  String? qId;
  String? catId;

  CategoryQuestionData({this.qId, this.catId});

  CategoryQuestionData.fromJson(Map<String, dynamic> json) {
    qId = json['q_id'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q_id'] = this.qId;
    data['cat_id'] = this.catId;
    return data;
  }
}

class QuestionData {
  String? qId;
  String? question;
  String? book;
  String? verse;
  String? answer;
  String? hits;
  String? timestamp;
  String? image;
  String? websiteId;

  QuestionData(
      {this.qId,
      this.question,
      this.book,
      this.verse,
      this.answer,
      this.hits,
      this.timestamp,
      this.image,
      this.websiteId});

  QuestionData.fromJson(Map<String, dynamic> json) {
    qId = json['q_id'];
    question = json['question'];
    book = json['book'];
    verse = json['verse'];
    answer = json['answer'];
    hits = json['hits'];
    timestamp = json['timestamp'];
    image = json['image'];
    websiteId = json['website_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q_id'] = this.qId;
    data['question'] = this.question;
    data['book'] = this.book;
    data['verse'] = this.verse;
    data['answer'] = this.answer;
    data['hits'] = this.hits;
    data['timestamp'] = this.timestamp;
    data['image'] = this.image;
    data['website_id'] = this.websiteId;
    return data;
  }
}