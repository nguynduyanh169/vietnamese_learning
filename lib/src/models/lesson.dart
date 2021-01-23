class Lesson {
  String lessonID;
  String lessonName;
  int levelID;
  String lessonUpdate;
  Progress progress;
  String lessonImage;

  Lesson(
      {this.lessonID,
        this.lessonName,
        this.levelID,
        this.lessonUpdate,
        this.progress,
        this.lessonImage});

  Lesson.fromJson(Map<String, dynamic> json) {
    lessonID = json['lessonID'];
    lessonName = json['lessonName'];
    levelID = json['levelID'];
    lessonUpdate = json['lessonUpdate'];
    progress = json['progress'] != null
        ? new Progress.fromJson(json['progress'])
        : null;
    lessonImage = json['lessonImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonID'] = this.lessonID;
    data['lessonName'] = this.lessonName;
    data['levelID'] = this.levelID;
    data['lessonUpdate'] = this.lessonUpdate;
    if (this.progress != null) {
      data['progress'] = this.progress.toJson();
    }
    data['lessonImage'] = this.lessonImage;
    return data;
  }
}

class Progress {
  int progressID;
  int studentID;
  String lessonID;
  String progresStatus;
  double vocabPercent;
  double converPercent;
  double quizPercent;
  String updateDate;

  Progress(
      {this.progressID,
        this.studentID,
        this.lessonID,
        this.progresStatus,
        this.vocabPercent,
        this.converPercent,
        this.quizPercent,
        this.updateDate});

  Progress.fromJson(Map<String, dynamic> json) {
    progressID = json['progressID'];
    studentID = json['studentID'];
    lessonID = json['lessonID'];
    progresStatus = json['progresStatus'];
    vocabPercent = json['vocabPercent'];
    converPercent = json['converPercent'];
    quizPercent = json['quizPercent'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['progressID'] = this.progressID;
    data['studentID'] = this.studentID;
    data['lessonID'] = this.lessonID;
    data['progresStatus'] = this.progresStatus;
    data['vocabPercent'] = this.vocabPercent;
    data['converPercent'] = this.converPercent;
    data['quizPercent'] = this.quizPercent;
    data['updateDate'] = this.updateDate;
    return data;
  }
}

