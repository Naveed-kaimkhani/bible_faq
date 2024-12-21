class QuestionData {
  int? qId;
  String? question;
  String? book;
  String? verse;
  String? answer;
  int? hits;
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
