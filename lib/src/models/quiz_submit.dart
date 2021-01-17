class QuizSubmit {
  QuizSubmit({
    this.lessonId,
    this.listAswers,
    this.progress,
    this.quizId,
    this.quizMark,
    this.startDate,
  });

  String lessonId;
  List<ListAswer> listAswers;
  Progress progress;
  int quizId;
  double quizMark;
  DateTime startDate;

  factory QuizSubmit.fromJson(Map<String, dynamic> json) => QuizSubmit(
    lessonId: json["lessonID"],
    listAswers: List<ListAswer>.from(json["listAswers"].map((x) => ListAswer.fromJson(x))),
    progress: Progress.fromJson(json["progress"]),
    quizId: json["quizID"],
    quizMark: json["quizMark"],
    startDate: DateTime.parse(json["startDate"]),
  );

  Map<String, dynamic> toJson() => {
    "lessonID": lessonId,
    "listAswers": List<dynamic>.from(listAswers.map((x) => x.toJson())),
    "progress": progress.toJson(),
    "quizID": quizId,
    "quizMark": quizMark,
    "startDate": startDate.toIso8601String(),
  };
}

class ListAswer {
  ListAswer({
    this.historyId,
    this.id,
    this.optionId,
    this.questionId,
  });

  int historyId;
  int id;
  int optionId;
  int questionId;

  factory ListAswer.fromJson(Map<String, dynamic> json) => ListAswer(
    historyId: json["historyID"],
    id: json["id"],
    optionId: json["optionID"],
    questionId: json["questionID"],
  );

  Map<String, dynamic> toJson() => {
    "historyID": historyId,
    "id": id,
    "optionID": optionId,
    "questionID": questionId,
  };
}

class Progress {
  Progress({
    this.converPercent,
    this.lessonId,
    this.progresStatus,
    this.progressId,
    this.quizPercent,
    this.studentId,
    this.updateDate,
    this.vocabPercent,
  });

  int converPercent;
  String lessonId;
  String progresStatus;
  int progressId;
  int quizPercent;
  int studentId;
  DateTime updateDate;
  int vocabPercent;

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
    converPercent: json["converPercent"],
    lessonId: json["lessonID"],
    progresStatus: json["progresStatus"],
    progressId: json["progressID"],
    quizPercent: json["quizPercent"],
    studentId: json["studentID"],
    updateDate: DateTime.parse(json["updateDate"]),
    vocabPercent: json["vocabPercent"],
  );

  Map<String, dynamic> toJson() => {
    "converPercent": converPercent,
    "lessonID": lessonId,
    "progresStatus": progresStatus,
    "progressID": progressId,
    "quizPercent": quizPercent,
    "studentID": studentId,
    "updateDate": updateDate.toIso8601String(),
    "vocabPercent": vocabPercent,
  };
}
