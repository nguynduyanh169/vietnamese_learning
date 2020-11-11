import 'package:vietnamese_learning/src/models/option.dart';

class Question{
  int questionID;
  String question;
  int quizId;
  int quizType;
  List<Option> options;

  Question.fromJson(Map<String, dynamic> json){
    questionID = json['questionID'];
    question = json['question'];
    quizId = json['quizId'];
    quizType = json['quizType'];
    options = List<Option>.from(json["options"].map((i) => Option.fromJson(i)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionID'] = this.questionID;
    data['question'] = this.question;
    data['quizId'] = this.quizId;
    data['quizType'] = this.quizType;
    data['options'] = this.options;
  }
}