import 'package:flutter/material.dart';

class QuizQuestion extends StatelessWidget {
  final String questionText;

  QuizQuestion(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          questionText,
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ));
  }
}
