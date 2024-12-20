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