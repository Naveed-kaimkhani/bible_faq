class QuestionData {
  int? qId;
  int? hits;

  String? book;
  String? verse;
  String? websiteId;

  String? timestamp;
  String? image;
  String? answer;
  String? question;
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
    // book = json['book'];
    // verse = json['verse'];
    answer = json['answer'];
    // hits = json['hits'];
    timestamp = json['timestamp'];
    image = json['image'];
    websiteId = json['website_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q_id'] = qId;
    data['question'] = question;
    // data['book'] = this.book;
    // data['verse'] = this.verse;
    data['answer'] = answer;
    // data['hits'] = hits;
    data['timestamp'] = timestamp;
    data['image'] = image;
    data['website_id'] = websiteId;
    return data;
  }
}
