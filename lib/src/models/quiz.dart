import 'package:vietnamese_learning/src/models/option.dart';

class Quiz{
  int quizID;
  String quizName;
  int numberOfQuestion;
  String lessonID;

  Quiz(this.quizID, this.quizName, this.numberOfQuestion, this.lessonID);

  Quiz.fromJson(Map<String, dynamic> json){
    quizID = json['quizID'];
    quizName = json['quizName'];
    numberOfQuestion = json['numberOfQuestion'];
    lessonID = json['lessonID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quizID'] = this.quizID;
    data['quizName'] = this.quizName;
    data['numberOfQuestion'] = this.numberOfQuestion;
    data['lessonID'] = this.lessonID;
  }

}