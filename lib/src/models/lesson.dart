class Lesson {
  String lessonId;
  String lessonName;
  String lessonImage;
  String progressStatus;
  int progressId;
  double quizMark;

  Lesson(
      {this.lessonId,
      this.lessonImage,
      this.lessonName,
      this.progressId,
      this.progressStatus,
      this.quizMark});

  Lesson.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    lessonName = json['lessonName'];
    lessonImage = json['lessonImage'];
    progressStatus = json['progressStatus'];
    progressId = json['progressId'];
    quizMark = json['quizMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonId'] = this.lessonId;
    data['lessonName'] = this.lessonName;
    data['lessonImage'] = this.lessonImage;
    data['progressId'] = this.progressId;
    data['progressStatus'] = this.progressStatus;
    data['quizMark'] = this.quizMark;
    return data;
  }
}
