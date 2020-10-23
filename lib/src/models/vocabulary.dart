class Vocabulary {
  int id;
  String vocabulary;
  String image;
  String description;
  String lessonId;
  bool status;
  String voice_link;

  Vocabulary(
      {this.lessonId,
      this.id,
      this.status,
      this.description,
      this.voice_link,
      this.vocabulary,
      this.image});

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
        id: json['id'],
        vocabulary: json['vocabulary'],
        image: json['image'],
        description: json['description'],
        lessonId: json['lessonId'],
        status: json['status'],
        voice_link: json['voice_link']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonId'] = this.lessonId;
    data['id'] = this.id;
    data['image'] = this.image;
    data['vocabulary'] = this.vocabulary;
    data['description'] = this.description;
    data['status'] = this.status;
    data['voice_link'] = this.voice_link;
    return data;
  }
}
