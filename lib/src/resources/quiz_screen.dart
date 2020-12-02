import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/widgets/quiz.dart';
import 'package:vietnamese_learning/src/widgets/quiz_result.dart';

class QuizScreen extends StatefulWidget {
  List<Question> questions;
  int progressId;
  int quizId;

  QuizScreen({Key key, this.questions, this.progressId, this.quizId})
      : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(
      questions: questions, progressId: progressId, quizId: quizId);
}

class _QuizScreenState extends State<QuizScreen> {
  var _questionIndex = 0;
  double _totalScore = 0;
  List<Question> questions;
  int progressId;
  int quizId;
  List<int> optionIds = new List();
  int chooseOptionId;
  int tappedIndex;
  bool optionCheckCorrect = false;
  String userChoice;
  String correctAns;

  _QuizScreenState({this.questions, this.progressId, this.quizId});

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

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
    double score = 10 / questions.length;
    if (optionCheckCorrect == false) {
      _totalScore += 0;
    } else {
      _totalScore += score;
    }
    setState(() {
      _questionIndex = _questionIndex + 1;
      tappedIndex = 5;
      optionIds.add(chooseOptionId);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tappedIndex = 5;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _questionIndex < questions.length
            ? Quiz(
                questions: questions,
                answerQuestions: _answerQuestions,
                questionIndex: _questionIndex,
                rootContext: context,
                tappedIndex: tappedIndex,
                choice: tapped,
                checkCorrect: optionCheckCorrect,
                userChoice: userChoice,
          correctAnswer: correctAns,
              )
            : QuizResult(
                _totalScore, _resetQuiz, quizId, progressId, optionIds),
      ),
    );
  }
}
