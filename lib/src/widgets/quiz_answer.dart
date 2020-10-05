import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizAnswer extends StatelessWidget{
  final String answerText;
  final Function selectHandler;

  QuizAnswer(this.selectHandler, this.answerText);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        answerText,
        style: Theme
            .of(context)
            .textTheme
            .headline5,
      ),
    );
  }
}