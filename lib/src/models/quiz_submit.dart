class QuizSubmit {
  List<int> optionIDs;
  int processId;
  int quizId;
  double quizMark;
  String startDate;

  QuizSubmit({
    this.optionIDs,
    this.processId,
    this.quizId,
    this.quizMark,
    this.startDate,
  });

  factory QuizSubmit.fromJson(Map<String, dynamic> json) => QuizSubmit(
        optionIDs: List<int>.from(json["optionIDs"].map((i) => i)),
        processId: json["processID"],
        quizId: json["quizID"],
        quizMark: json["quizMark"],
        startDate: json["startDate"],
      );

  Map<String, dynamic> toJson() => {
        "optionIDs": List<dynamic>.from(optionIDs.map((x) => x)),
        "processID": processId,
        "quizID": quizId,
        "quizMark": quizMark,
        "startDate": startDate,
      };
}
