import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/widgets/quilification_notification.dart';

class QualificationResult extends StatelessWidget {
  final double resultScore;
  LoginResponse loginResponse;
  String username;
  int correctAnswer, totalAnswer;
  QualificationResult(this.resultScore, this.loginResponse, this.username, this.correctAnswer, this.totalAnswer);
  String resultText;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var percent = resultScore / 10;
    return Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
        color: Color.fromRGBO(255, 239, 204, 100),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Result',
                style: GoogleFonts.varelaRound(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Text(
                'You got',
                style: TextStyle(
                    fontSize: 27, fontFamily: "Helvetica", color: Colors.blue),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4,
              ),
              CircularPercentIndicator(
                radius: 170.0,
                lineWidth: 20.0,
                animation: true,
                percent: percent,
                center: new Text(
                  "${resultScore.toStringAsFixed(1)}/10",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      fontFamily: "Helvetica"),
                ),
                footer: Text(
                  'score',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      fontFamily: "Helvetica"),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 15,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60.0,
                  child: Center(
                    child: Padding(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                      padding: new EdgeInsets.only(left: 0.0),
                    ),
                  ),
                ),
                onPressed: () {
                  int level;
                  if(resultScore <= 6){
                    level = 1;
                  }
                  if(resultScore > 6 && resultScore <= 8){
                    level = 2;
                  }
                  if(resultScore > 8){
                    level = 3;
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QualificationNotification(level: level,loginResponse: loginResponse, username: username)));
                },
                color: Color.fromRGBO(255, 210, 77, 10),
              ),
            ],
          ),
        ));
  }
}
