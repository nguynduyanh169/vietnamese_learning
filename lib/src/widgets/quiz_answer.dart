import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class QuizAnswer extends StatelessWidget {
  final String answerText;
  final Function selectHandler;
  final bool checkCorrect;
  final String correct;
  final BuildContext rootContext;

  QuizAnswer(this.selectHandler, this.answerText,
      this.checkCorrect, this.correct, this.rootContext);

  Widget _loadDialog(BuildContext buildContext){
    if (checkCorrect == true) {
      CoolAlert.show(
        barrierDismissible: false,
          context: buildContext,
          type: CoolAlertType.success,
          title: "Correct!",
          text: 'Your choice is: $answerText',
          confirmBtnText: 'Continue',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: (){
            selectHandler();
            Navigator.pop(buildContext);
          });
    } else if (checkCorrect == false) {
      CoolAlert.show(
        barrierDismissible: false,
          context: buildContext,
          type: CoolAlertType.error,
          title: "Incorrect!",
          confirmBtnColor: Colors.red,
          confirmBtnText: 'Continue',
          text:
          'The correct answer is $correct. Your choice is: $answerText',
          onConfirmBtnTap: (){
            selectHandler();
            Navigator.pop(buildContext);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.black, width: 2.0)),
      child: InkWell(
        onTap: () {
          _loadDialog(rootContext);
        },
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 10,
              padding: const EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              child: Text(
                answerText,
                style: TextStyle(fontFamily: 'Helvetica', fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
