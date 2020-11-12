import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/widgets/quiz.dart';
import 'package:vietnamese_learning/src/widgets/quiz_result.dart';

class QuizScreen extends StatefulWidget {
  List<Question> questions;

  QuizScreen({Key key, this.questions}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(questions: questions);
}

class _QuizScreenState extends State<QuizScreen> {
  var _questionIndex = 0;
  var _totalScore = 0;
  List<Question> questions;

  _QuizScreenState({this.questions});

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestions(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
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
              )
            : QuizResult(_totalScore, _resetQuiz),
      ),
    );
  }
}
