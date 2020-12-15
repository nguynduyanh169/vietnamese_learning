import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/review_quiz.dart';
import 'package:vietnamese_learning/src/widgets/practice_quiz.dart';
import 'package:vietnamese_learning/src/widgets/practice_quiz_result.dart';

class PracticeQuizScreen extends StatefulWidget {
  List<Question> questions;

  PracticeQuizScreen({Key key, this.questions}) : super(key: key);

  _PracticeQuizScreenState createState() =>
      _PracticeQuizScreenState(questions: questions);
}

class _PracticeQuizScreenState extends State<PracticeQuizScreen> {
  var _questionIndex = 0;
  double _totalScore = 0;
  List<Question> questions;
  List<int> optionIds = new List();
  int chooseOptionId;
  int tappedIndex;
  bool optionCheckCorrect = false;
  String userChoice;
  String correctAns;
  String question;
  int questionType;
  List<ReviewQuiz> incorrects = new List();

  _PracticeQuizScreenState({this.questions});

  void tapped(int index, int optionId, bool checkCorrect, String userChoose,
      String correctAnswer, String quizQuestion, int type) {
    setState(() {
      tappedIndex = index;
      chooseOptionId = optionId;
      optionCheckCorrect = checkCorrect;
      userChoice = userChoose;
      correctAns = correctAnswer;
      question = quizQuestion;
      questionType = type;
    });
  }

  void _answerQuestions() {
    double score = 10 / questions.length;
    if (optionCheckCorrect == false) {
      _totalScore += 0;
      ReviewQuiz reviewQuiz = new ReviewQuiz(
          question: question,
          questionType: questionType,
          correct: correctAns,
          userAns: userChoice);
      incorrects.add(reviewQuiz);
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
    super.initState();
    tappedIndex = 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _questionIndex < questions.length
          ? PracticeQuiz(
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
          : PracticeQuizResult(_totalScore, incorrects),
    );
  }
}
