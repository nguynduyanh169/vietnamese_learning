import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/widgets/quiz.dart';
import 'package:vietnamese_learning/src/widgets/quiz_result.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({Key key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var _questionIndex = 0;
  var _totalScore = 0;
  Color primaryColor = Colors.white;
  Color right = Colors.green;
  Color wrong = Colors.red;

  final _questions = const [
    {
      'questionText': 'Which\'s capital of India?',
      'answers': [
        {'text': 'Mumbai', 'score': 0},
        {'text': 'New Delhi', 'score': 10},
        {'text': 'Jaipur', 'score': 0},
        {'text': 'Pune', 'score': 0}
      ]
    },
    {
      'questionText': 'Which\'s mother toung of India?',
      'answers': [
        {'text': 'Marathi', 'score': 0},
        {'text': 'Gujarati', 'score': 0},
        {'text': 'Tamil', 'score': 0},
        {'text': 'Hindi', 'score': 10}
      ]
    },
    {
      'questionText': 'Who\'s prime ministor of India?',
      'answers': [
        {'text': 'Narendra Modi', 'score': 10},
        {'text': 'Amit Shah', 'score': 0},
        {'text': 'Sonia Gandhi', 'score': 0},
        {'text': 'Rahul Gandhi', 'score': 0}
      ]
    },
    {
      'questionText': 'Who\'s president of India?',
      'answers': [
        {'text': 'Lalkrishna Advani', 'score': 0},
        {'text': 'Barak Obama', 'score': 0},
        {'text': 'Ramnath Kovind', 'score': 10},
        {'text': 'Pratibha Patil', 'score': 0}
      ]
    },
    {
      'questionText': 'Who\'s Chief Minister of Gujarat?',
      'answers': [
        {'text': 'Nitin Patel', 'score': 0},
        {'text': 'Vijay Rupani', 'score': 10},
        {'text': 'Jayesh Radadiya', 'score': 0},
        {'text': 'Paresh Dhanani', 'score': 0}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0},
        {'text': 'Visakhadatta', 'score': 0},
        {'text': 'Bana Bhatta', 'score': 0},
        {'text': 'Chanakya', 'score': 10}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0},
        {'text': 'Visakhadatta', 'score': 0},
        {'text': 'Bana Bhatta', 'score': 0},
        {'text': 'Chanakya', 'score': 10}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0},
        {'text': 'Visakhadatta', 'score': 0},
        {'text': 'Bana Bhatta', 'score': 0},
        {'text': 'Chanakya', 'score': 10}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0},
        {'text': 'Visakhadatta', 'score': 0},
        {'text': 'Bana Bhatta', 'score': 0},
        {'text': 'Chanakya', 'score': 10}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0},
        {'text': 'Visakhadatta', 'score': 0},
        {'text': 'Bana Bhatta', 'score': 0},
        {'text': 'Chanakya', 'score': 10}
      ]
    },
  ];

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
      if (score == 10) {
        primaryColor = right;
      } else {
        primaryColor = wrong;
      }
    });
    print('_questionIndex:$_questionIndex');
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                primaryColor: primaryColor,
                answerQuestions: _answerQuestions,
                questionIndex: _questionIndex)
            : QuizResult(_totalScore, _resetQuiz),
      ),
    );
  }
}
