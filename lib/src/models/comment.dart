class Comment {
  Comment({
    this.date,
    this.studentName,
    this.text,
  });

  DateTime date;
  String studentName;
  String text;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    date: DateTime.parse(json["date"]),
    studentName: json["studentName"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "studentName": studentName,
    "text": text,
  };
}

class CommentSave {
  CommentSave({
    this.date,
    this.postId,
    this.text,
  });

  DateTime date;
  int postId;
  String text;

  factory CommentSave.fromJson(Map<String, dynamic> json) => CommentSave(
    date: DateTime.parse(json["date"]),
    postId: json["postID"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "postID": postId,
    "text": text,
  };
}