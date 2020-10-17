import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          style: GoogleFonts.dmSans(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ));
  }
}
