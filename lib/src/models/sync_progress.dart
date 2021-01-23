class SyncProgress {
  SyncProgress({
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

  factory SyncProgress.fromJson(Map<String, dynamic> json) => SyncProgress(
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