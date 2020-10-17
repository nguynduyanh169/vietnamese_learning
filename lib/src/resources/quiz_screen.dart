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
        {'text': 'Mumbai', 'score': 0, 'color': Colors.white},
        {'text': 'New Delhi', 'score': 10, 'color': Colors.white},
        {'text': 'Jaipur', 'score': 0, 'color': Colors.white},
        {'text': 'Pune', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'questionText': 'Which\'s mother toung of India?',
      'answers': [
        {'text': 'Marathi', 'score': 0, 'color': Colors.white},
        {'text': 'Gujarati', 'score': 0, 'color': Colors.white},
        {'text': 'Tamil', 'score': 0, 'color': Colors.white},
        {'text': 'Hindi', 'score': 10, 'color': Colors.white}
      ]
    },
    {
      'questionText': 'Who\'s prime ministor of India?',
      'answers': [
        {'text': 'Narendra Modi', 'score': 10, 'color': Colors.white},
        {'text': 'Amit Shah', 'score': 0, 'color': Colors.white},
        {'text': 'Sonia Gandhi', 'score': 0, 'color': Colors.white},
        {'text': 'Rahul Gandhi', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'questionText': 'Who\'s president of India?',
      'answers': [
        {'text': 'Lalkrishna Advani', 'score': 0, 'color': Colors.white},
        {'text': 'Barak Obama', 'score': 0, 'color': Colors.white},
        {'text': 'Ramnath Kovind', 'score': 10, 'color': Colors.white},
        {'text': 'Pratibha Patil', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'questionText': 'Who\'s Chief Minister of Gujarat?',
      'answers': [
        {'text': 'Nitin Patel', 'score': 0, 'color': Colors.white},
        {'text': 'Vijay Rupani', 'score': 10, 'color': Colors.white},
        {'text': 'Jayesh Radadiya', 'score': 0, 'color': Colors.white},
        {'text': 'Paresh Dhanani', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0, 'color': Colors.white},
        {'text': 'Visakhadatta', 'score': 0, 'color': Colors.white},
        {'text': 'Bana Bhatta', 'score': 0, 'color': Colors.white},
        {'text': 'Chanakya', 'score': 10, 'color': Colors.white}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0, 'color': Colors.white},
        {'text': 'Visakhadatta', 'score': 0, 'color': Colors.white},
        {'text': 'Bana Bhatta', 'score': 0, 'color': Colors.white},
        {'text': 'Chanakya', 'score': 10, 'color': Colors.white}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0, 'color': Colors.white},
        {'text': 'Visakhadatta', 'score': 0, 'color': Colors.white},
        {'text': 'Bana Bhatta', 'score': 0, 'color': Colors.white},
        {'text': 'Chanakya', 'score': 10, 'color': Colors.white}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0, 'color': Colors.white},
        {'text': 'Visakhadatta', 'score': 0, 'color': Colors.white},
        {'text': 'Bana Bhatta', 'score': 0, 'color': Colors.white},
        {'text': 'Chanakya', 'score': 10, 'color': Colors.white}
      ]
    },
    {
      'questionText':
          'Which of the following was the author of the Arthashastra?',
      'answers': [
        {'text': 'Kalhan', 'score': 0, 'color': Colors.white},
        {'text': 'Visakhadatta', 'score': 0, 'color': Colors.white},
        {'text': 'Bana Bhatta', 'score': 0, 'color': Colors.white},
        {'text': 'Chanakya', 'score': 10, 'color': Colors.white}
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
