class Lesson {
  String lessonId;
  String lessonName;
  String lessonImage;
  String progressStatus;
  int progressId;

  Lesson(
      {this.lessonId,
      this.lessonImage,
      this.lessonName,
      this.progressId,
      this.progressStatus,});

  Lesson.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonID'];
    lessonName = json['lessonName'];
    lessonImage = json['lessonImage'];
    progressStatus = json['progresStatus'];
    progressId = json['progressID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonID'] = this.lessonId;
    data['lessonName'] = this.lessonName;
    data['lessonImage'] = this.lessonImage;
    data['progressId'] = this.progressId;
    data['progresStatus'] = this.progressStatus;
    return data;
  }
}
