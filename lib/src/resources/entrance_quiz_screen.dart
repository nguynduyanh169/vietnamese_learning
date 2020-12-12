import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/models/entrance_quiz.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/widgets/qualification_quiz.dart';
import 'package:vietnamese_learning/src/widgets/qualification_result.dart';

class EntranceQuizScreen extends StatefulWidget {
  List<EntranceQuiz> entranceQuizzes;
  LoginResponse loginResponse;
  String username;

  EntranceQuizScreen({Key key, this.entranceQuizzes, this.loginResponse, this.username})
      : super(key: key);

  @override
  _EntranceQuizState createState() => _EntranceQuizState(entranceQuizzes: entranceQuizzes,loginResponse: loginResponse, username: username);
}

class _EntranceQuizState extends State<EntranceQuizScreen> {
  var _questionIndex = 0;
  double _totalScore = 0;
  List<EntranceQuiz> entranceQuizzes;
  List<int> optionIds = new List();
  int chooseOptionId;
  int tappedIndex;
  bool optionCheckCorrect = false;
  String userChoice;
  String correctAns;
  LoginResponse loginResponse;
  String username;
  int correctAnswer = 0;


  _EntranceQuizState({this.entranceQuizzes, this.loginResponse, this.username});

  void tapped(int index, int optionId, bool checkCorrect, String userChoose, String correctAnswer) {
    setState(() {
      tappedIndex = index;
      chooseOptionId = optionId;
      optionCheckCorrect = checkCorrect;
      userChoice = userChoose;
      correctAns = correctAnswer;
    });
  }

  void _answerQuestions() {
    double score = 10 / entranceQuizzes.length;
    if (optionCheckCorrect == false) {
      _totalScore += 0;
    } else {
      correctAnswer += 1;
      _totalScore += score;
    }
    setState(() {
      _questionIndex = _questionIndex + 1;
      tappedIndex = 5;
      optionIds.add(chooseOptionId);
    });
    print(_totalScore);
  }

  @override
  void initState() {
    super.initState();
    tappedIndex = 5;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _questionIndex < entranceQuizzes.length
            ? QualificationQuiz(
          entranceQuizzes: entranceQuizzes,
          answerQuestions: _answerQuestions,
          questionIndex: _questionIndex,
          rootContext: context,
          tappedIndex: tappedIndex,
          choice: tapped,
          checkCorrect: optionCheckCorrect,
          userChoice: userChoice,
          correctAnswer: correctAns,
        ) : QualificationResult(_totalScore, loginResponse, username, correctAnswer, entranceQuizzes.length),
      ),
    );
  }
}
