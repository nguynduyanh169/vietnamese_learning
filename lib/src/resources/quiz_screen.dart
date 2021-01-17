import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/review_quiz.dart';
import 'package:vietnamese_learning/src/widgets/quiz.dart';
import 'package:vietnamese_learning/src/widgets/quiz_result.dart';

class QuizScreen extends StatefulWidget {
  List<Question> questions;
  int progressId;
  String lessonId;

  QuizScreen({Key key, this.questions, this.progressId, this.lessonId})
      : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(
      questions: questions, progressId: progressId, lessonId: lessonId);
}

class _QuizScreenState extends State<QuizScreen> {
  var _questionIndex = 0;
  double _totalScore = 0;
  List<Question> questions;
  int progressId;
  String lessonId;
  int quizId;
  List<int> optionIds = new List();
  int chooseOptionId;
  int tappedIndex;
  bool optionCheckCorrect = false;
  String userChoice;
  String correctAns;
  String question;
  int questionType;
  List<ReviewQuiz> incorrects = new List();

  _QuizScreenState({this.questions, this.progressId, this.quizId, this.lessonId});

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void tapped(int index, int optionId, bool checkCorrect, String userChoose, String correctAnswer, String quizQuestion, int type) {
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
      ReviewQuiz reviewQuiz = new ReviewQuiz(question: question, questionType: questionType, correct: correctAns, userAns: userChoice);
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
    // TODO: implement initState
    super.initState();
    tappedIndex = 5;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
          _totalScore, _resetQuiz, quizId, progressId, optionIds, lessonId, incorrects),
    );
  }
}
