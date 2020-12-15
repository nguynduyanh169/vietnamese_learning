import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class PracticeQuizAnswer extends StatelessWidget{
  final String answerText;
  final bool checkCorrect;
  final String correct;
  final BuildContext rootContext;
  final int index;
  final Function choice;
  final int tappedIndex;
  final int optionId;
  final String question;
  final int questionType;

  PracticeQuizAnswer(this.answerText, this.checkCorrect,
      this.correct, this.rootContext, this.index, this.choice, this.tappedIndex, this.optionId, this.question, this.questionType);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: tappedIndex == index ? Colors.blueAccent : Colors.black87, width: 2.0)),
      child: InkWell(
        onTap: () {
          choice(index, optionId, checkCorrect, answerText, correct, question, questionType);
        },
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 8,
              padding: const EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              child: Text(
                answerText,
                style: TextStyle(fontFamily: 'Helvetica', fontSize: 18, color: tappedIndex == index ? Colors.blueAccent : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}