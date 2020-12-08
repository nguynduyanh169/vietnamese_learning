class Lesson {
  Lesson({
    this.lessonId,
    this.lessonName,
    this.levelId,
    this.progressId,
    this.progresStatus,
    this.lessonImage,
  });

  String lessonId;
  String lessonName;
  int levelId;
  int progressId;
  String progresStatus;
  String lessonImage;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    lessonId: json["lessonID"],
    lessonName: json["lessonName"],
    levelId: json["levelID"],
    progressId: json["progressID"],
    progresStatus: json["progresStatus"],
    lessonImage: json["lessonImage"],
  );

  Map<String, dynamic> toJson() => {
    "lessonID": lessonId,
    "lessonName": lessonName,
    "levelID": levelId,
    "progressID": progressId,
    "progresStatus": progresStatus,
    "lessonImage": lessonImage,
  };
}
