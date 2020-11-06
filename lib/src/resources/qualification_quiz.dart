import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/widgets/qualification.dart';
import 'package:vietnamese_learning/src/widgets/qualification_result.dart';

class QualificationQuiz extends StatefulWidget {
  QualificationQuiz({Key key}) : super(key: key);

  @override
  _QualificationQuizState createState() => _QualificationQuizState();
}

class _QualificationQuizState extends State<QualificationQuiz> {
  var _questionIndex = 0;
  var _totalScore = 0;
  bool isNew = true;
  Color primaryColor = Colors.white;
  Color right = Colors.green;
  Color wrong = Colors.red;

  final _questions = const [
    {
      'type': 'Question 1',
      'questionText': 'Which one of these is “bread”?',
      'answers': [
        {'text': 'Con chó', 'score': 0, 'color': Colors.white},
        {'text': 'Con mèo', 'score': 0, 'color': Colors.white},
        {'text': 'Bánh mì', 'score': 10, 'color': Colors.white},
        {'text': 'Cái điện thoại', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 2',
      'questionText': 'Which one of these is “apple”?',
      'answers': [
        {'text': 'Quả táo', 'score': 10, 'color': Colors.white},
        {'text': 'Gió', 'score': 0, 'color': Colors.white},
        {'text': 'Con chó', 'score': 0, 'color': Colors.white},
        {'text': 'Con mèo', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 3',
      'questionText': 'Hello, what is your name?',
      'answers': [
        {'text': 'Xin chào, bạn tên gì?', 'score': 10, 'color': Colors.white},
        {
          'text': 'Xin chào, bạn khoẻ không?',
          'score': 0,
          'color': Colors.white
        },
        {
          'text': 'Tạm biệt. Mai gặp lại nhé?',
          'score': 0,
          'color': Colors.white
        },
        {'text': 'Xin chào, nhà bạn ở đâu?', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 4',
      'questionText': '______, what is your name?',
      'answers': [
        {'text': 'Hello', 'score': 10, 'color': Colors.white},
        {'text': 'Goodbye', 'score': 0, 'color': Colors.white},
        {'text': 'Bye', 'score': 0, 'color': Colors.white},
        {'text': 'How are you', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 5',
      'questionText': 'Which one of these is “dog”?',
      'answers': [
        {'text': 'Con chó', 'score': 10, 'color': Colors.white},
        {'text': 'Con mèo', 'score': 0, 'color': Colors.white},
        {'text': 'Con gà', 'score': 0, 'color': Colors.white},
        {'text': 'Bánh mì', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 6',
      'questionText': 'Which one of these is “bread”?',
      'answers': [
        {'text': 'Con chó', 'score': 0, 'color': Colors.white},
        {'text': 'Con mèo', 'score': 0, 'color': Colors.white},
        {'text': 'Bánh mì', 'score': 10, 'color': Colors.white},
        {'text': 'Cái điện thoại', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 7',
      'questionText': 'Which one of these is “cat”?',
      'answers': [
        {'text': 'Bánh mì', 'score': 0, 'color': Colors.white},
        {'text': 'Bánh ngọt', 'score': 0, 'color': Colors.white},
        {'text': 'Con gà', 'score': 0, 'color': Colors.white},
        {'text': 'Con mèo', 'score': 10, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 8',
      'questionText': 'Which one of these is “bird”?',
      'answers': [
        {'text': 'Con chuột', 'score': 0, 'color': Colors.white},
        {'text': 'Con chim', 'score': 10, 'color': Colors.white},
        {'text': 'Con rắn', 'score': 0, 'color': Colors.white},
        {'text': 'Con gà', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 9',
      'questionText': 'Which one of these is “mouse”?',
      'answers': [
        {'text': 'Con chuột', 'score': 10, 'color': Colors.white},
        {'text': 'Con chim', 'score': 0, 'color': Colors.white},
        {'text': 'Con rắn', 'score': 0, 'color': Colors.white},
        {'text': 'Con gà', 'score': 0, 'color': Colors.white}
      ]
    },
    {
      'type': 'Question 10',
      'questionText': 'Which one of these is “chicken”?',
      'answers': [
        {'text': 'Con gà', 'score': 10, 'color': Colors.white},
        {'text': 'Nước', 'score': 0, 'color': Colors.white},
        {'text': 'Xe đạp', 'score': 0, 'color': Colors.white},
        {'text': 'Cái điện thoại', 'score': 0, 'color': Colors.white}
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
            ? Qualification(
                questions: _questions,
                primaryColor: primaryColor,
                answerQuestions: _answerQuestions,
                questionIndex: _questionIndex,
                rootContext: context,
              )
            : QualificationResult(_totalScore, _resetQuiz),
      ),
    );
  }
}
