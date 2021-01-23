import 'package:vietnamese_learning/src/models/option.dart';

class Question {
  Question({
    this.lessonId,
    this.options,
    this.question,
    this.questionId,
    this.quizType,
  });

  String lessonId;
  List<Option> options;
  String question;
  int questionId;
  int quizType;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    lessonId: json["lessonID"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    question: json["question"],
    questionId: json["questionID"],
    quizType: json["quizType"],
  );

  Map<String, dynamic> toJson() => {
    "lessonID": lessonId,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "question": question,
    "questionID": questionId,
    "quizType": quizType,
  };
}

class Option {
  Option({
    this.checkCorrect,
    this.optionId,
    this.optionName,
  });

  bool checkCorrect;
  int optionId;
  String optionName;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    checkCorrect: json["checkCorrect"],
    optionId: json["optionID"],
    optionName: json["optionName"],
  );

  Map<String, dynamic> toJson() => {
    "checkCorrect": checkCorrect,
    "optionID": optionId,
    "optionName": optionName,
  };
}