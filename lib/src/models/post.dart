class PostSave {
  PostSave({
    this.link,
    this.postDate,
    this.text,
    this.title,
  });

  String link;
  String postDate;
  String text;
  String title;

  factory PostSave.fromJson(Map<String, dynamic> json) => PostSave(
    link: json["link"],
    postDate: json["postDate"],
    text: json["text"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "postDate": postDate,
    "text": text,
    "title": title,
  };
}
