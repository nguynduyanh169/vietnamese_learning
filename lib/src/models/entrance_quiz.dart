class EntranceQuiz {
  EntranceQuiz({
    this.options,
    this.question,
    this.questionId,
    this.quizId,
    this.quizType,
    this.status,
  });

  List<Option> options;
  String question;
  int questionId;
  int quizId;
  int quizType;
  bool status;

  factory EntranceQuiz.fromJson(Map<String, dynamic> json) => EntranceQuiz(
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        question: json["question"],
        questionId: json["questionID"],
        quizId: json["quizID"],
        quizType: json["quizType"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "question": question,
        "questionID": questionId,
        "quizID": quizId,
        "quizType": quizType,
        "status": status,
      };
}

class Option {
  Option({
    this.checkCorrect,
    this.optionId,
    this.optionName,
    this.status,
  });

  bool checkCorrect;
  int optionId;
  String optionName;
  bool status;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        checkCorrect: json["checkCorrect"],
        optionId: json["optionID"],
        optionName: json["optionName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "checkCorrect": checkCorrect,
        "optionID": optionId,
        "optionName": optionName,
        "status": status,
      };
}
