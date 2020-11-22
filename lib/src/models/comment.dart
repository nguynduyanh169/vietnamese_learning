class Comment {
  Comment({
    this.text,
    this.voiceLink,
    this.date,
    this.studentName,
    this.nation,
  });

  String text;
  dynamic voiceLink;
  DateTime date;
  String studentName;
  String nation;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    text: json["text"],
    voiceLink: json["voiceLink"],
    date: DateTime.parse(json["date"]),
    studentName: json["studentName"],
    nation: json["nation"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "voiceLink": voiceLink,
    "date": date.toIso8601String(),
    "studentName": studentName,
    "nation": nation,
  };
}

class CommentSave {
  CommentSave({
    this.date,
    this.postId,
    this.text,
    this.voiceLink
  });

  DateTime date;
  int postId;
  String text;
  String voiceLink;

  factory CommentSave.fromJson(Map<String, dynamic> json) => CommentSave(
    date: DateTime.parse(json["date"]),
    postId: json["postID"],
    text: json["text"],
    voiceLink: json["voiceLink"]
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "postID": postId,
    "text": text,
    "voiceLink": voiceLink
  };
}