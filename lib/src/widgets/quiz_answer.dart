import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class QuizAnswer extends StatelessWidget{
  final String answerText;
  final Function selectHandler;
  final Color primaryColor;
  final int answerScore;
  final String correct;

  QuizAnswer(this.selectHandler, this.answerText, this.primaryColor, this.answerScore, this.correct);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: (){
          if(answerScore == 10){
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Correct!",
                text: 'Your choice is: $answerText',
                onConfirmBtnTap: selectHandler);
          }
          else if(answerScore == 0){
            CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                title: "Incorrect!",
                text: 'The correct answer is $correct. Your choice is: $answerText',
                onConfirmBtnTap: selectHandler);
          }
        },
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 10,
              padding: const EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              child: Text(
                answerText,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}