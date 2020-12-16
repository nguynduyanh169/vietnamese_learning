class Comment {
  Comment({
    this.avatar,
    this.commentId,
    this.date,
    this.nation,
    this.studentName,
    this.text,
    this.voiceLink,
  });

  String avatar;
  int commentId;
  DateTime date;
  String nation;
  String studentName;
  String text;
  String voiceLink;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    avatar: json["avatar"],
    commentId: json["commentID"],
    date: DateTime.parse(json["date"]),
    nation: json["nation"],
    studentName: json["studentName"],
    text: json["text"],
    voiceLink: json["voiceLink"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "commentID": commentId,
    "date": date.toIso8601String(),
    "nation": nation,
    "studentName": studentName,
    "text": text,
    "voiceLink": voiceLink,
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