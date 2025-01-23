class CategoryQuestionData {
  int? qId;
  int? catId;

  CategoryQuestionData({this.qId, this.catId});

  CategoryQuestionData.fromJson(Map<String, dynamic> json) {
    qId = json['q_id'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q_id'] = qId;
    data['cat_id'] = catId;
    return data;
  }
}