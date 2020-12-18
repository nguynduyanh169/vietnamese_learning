class UserProfile {
  UserProfile({
    this.id,
    this.username,
    this.email,
    this.fullname,
    this.studentLevel,
    this.listPost,
    this.listComment,
    this.roleId,
    this.nation,
    this.avatar,
    this.userProgress,
    this.progressFinish
  });

  int id;
  String username;
  String email;
  String fullname;
  int studentLevel;
  List<ListPost> listPost;
  List<ListComment> listComment;
  int roleId;
  String nation;
  dynamic avatar;
  double userProgress;
  int progressFinish;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    fullname: json["fullname"],
    studentLevel: json["studentLevel"],
    listPost: List<ListPost>.from(json["listPost"].map((x) => ListPost.fromJson(x))),
    listComment: List<ListComment>.from(json["listComment"].map((x) => ListComment.fromJson(x))),
    roleId: json["roleID"],
    nation: json["nation"],
    avatar: json["avatar"],
    userProgress: json["userProgress"],
    progressFinish: json["progressFinish"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "fullname": fullname,
    "studentLevel": studentLevel,
    "listPost": List<dynamic>.from(listPost.map((x) => x.toJson())),
    "listComment": List<dynamic>.from(listComment.map((x) => x.toJson())),
    "roleID": roleId,
    "nation": nation,
    "avatar": avatar,
    "userProgress": userProgress,
    "progressFinish": progressFinish
  };
}

class ListComment {
  ListComment({
    this.id,
    this.text,
    this.voiceLink,
    this.date,
    this.delete,
  });

  int id;
  String text;
  String voiceLink;
  DateTime date;
  bool delete;

  factory ListComment.fromJson(Map<String, dynamic> json) => ListComment(
    id: json["id"],
    text: json["text"],
    voiceLink: json["voiceLink"],
    date: DateTime.parse(json["date"]),
    delete: json["delete"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "voiceLink": voiceLink,
    "date": date.toIso8601String(),
    "delete": delete,
  };
}

class ListPost {
  ListPost({
    this.id,
    this.text,
    this.postDate,
    this.link,
    this.title,
    this.listComment,
    this.status,
    this.delete,
  });

  int id;
  String text;
  DateTime postDate;
  dynamic link;
  String title;
  List<ListComment> listComment;
  String status;
  bool delete;

  factory ListPost.fromJson(Map<String, dynamic> json) => ListPost(
    id: json["id"],
    text: json["text"],
    postDate: DateTime.parse(json["postDate"]),
    link: json["link"],
    title: json["title"],
    listComment: List<ListComment>.from(json["listComment"].map((x) => ListComment.fromJson(x))),
    status: json["status"],
    delete: json["delete"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "postDate": postDate.toIso8601String(),
    "link": link,
    "title": title,
    "listComment": List<dynamic>.from(listComment.map((x) => x.toJson())),
    "status": status,
    "delete": delete,
  };
}

class EditUser {
  EditUser({
    this.avatarLink,
    this.email,
    this.fullname,
    this.nationLink,
  });

  String avatarLink;
  String email;
  String fullname;
  String nationLink;

  factory EditUser.fromJson(Map<String, dynamic> json) => EditUser(
    avatarLink: json["avatarLink"],
    email: json["email"],
    fullname: json["fullname"],
    nationLink: json["nationLink"],
  );

  Map<String, dynamic> toJson() => {
    "avatarLink": avatarLink,
    "email": email,
    "fullname": fullname,
    "nationLink": nationLink,
  };
}