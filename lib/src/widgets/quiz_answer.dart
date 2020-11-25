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

  QuizAnswer(this.selectHandler, this.answerText, this.checkCorrect,
      this.correct, this.rootContext);

  Widget _loadDialog(BuildContext buildContext) {
    // if (checkCorrect == true) {
    //   CoolAlert.show(
    //     barrierDismissible: false,
    //       context: buildContext,
    //       type: CoolAlertType.success,
    //       title: "Correct!",
    //       text: 'Your choice is: $answerText',
    //       confirmBtnText: 'Continue',
    //       confirmBtnColor: Colors.green,
    //       onConfirmBtnTap: (){
    //         selectHandler();
    //         Navigator.pop(buildContext);
    //       });
    // } else if (checkCorrect == false) {
    //   CoolAlert.show(
    //     barrierDismissible: false,
    //       context: buildContext,
    //       type: CoolAlertType.error,
    //       title: "Incorrect!",
    //       confirmBtnColor: Colors.red,
    //       confirmBtnText: 'Continue',
    //       text:
    //       'The correct answer is $correct. Your choice is: $answerText',
    //       onConfirmBtnTap: (){
    //         selectHandler();
    //         Navigator.pop(buildContext);
    //       });
    // }

    if (checkCorrect == true) {
      showDialog(
          context: buildContext,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 20,
                        ),
                        Text(
                          "Correct!",
                          style: TextStyle(
                            color: Colors.green,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica'),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        Image(
                            width: SizeConfig.blockSizeHorizontal * 10,
                            height: SizeConfig.blockSizeVertical * 8,
                            image: AssetImage('assets/images/happy.png')),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                'Your choice is:',
                                style: TextStyle(
                                    fontFamily: 'Helvetica', fontSize: 20),
                              ),
                              Text(
                                '$answerText',
                                style: TextStyle(
                                  color: Colors.green,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        selectHandler();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else if (checkCorrect == false) {
      showDialog(
          context: buildContext,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 20,
                        ),
                        Text(
                          "Incorrect!",
                          style: TextStyle(
                            color: Colors.redAccent,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica'),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        Image(
                            width: SizeConfig.blockSizeHorizontal * 10,
                            height: SizeConfig.blockSizeVertical * 8,
                            image: AssetImage('assets/images/sad.png')),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                'Correct solution:',
                                style: TextStyle(
                                    fontFamily: 'Helvetica', fontSize: 20),
                              ),
                              Text(
                                '$answerText',
                                style: TextStyle(
                                  color: Colors.green,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                            ],
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        selectHandler();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
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
