import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizAnswer extends StatelessWidget{
  final String answerText;
  final Function selectHandler;

  QuizAnswer(this.selectHandler, this.answerText);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: selectHandler,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              child: Image(
                  width: 50,
                  height: 50,
                  image: AssetImage('assets/images/logolearning.png')
              ),
            ),
            Text(answerText, style: TextStyle(fontSize: 15.0),)
          ],
        ),
      ),
    );
  }
}