class PostSave {
  PostSave({
    this.postDate,
    this.text,
    this.title,
  });

  String postDate;
  String text;
  String title;

  factory PostSave.fromJson(Map<String, dynamic> json) => PostSave(
    postDate: json["postDate"],
    text: json["text"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "postDate": postDate,
    "text": text,
    "title": title,
  };
}
