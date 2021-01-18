import 'package:vietnamese_learning/src/models/lesson.dart';

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
