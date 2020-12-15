import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/review_quiz.dart';
import 'package:vietnamese_learning/src/resources/review_quiz_screen.dart';

class PracticeQuizResult extends StatelessWidget {
  final List<ReviewQuiz> incorrects;
  final double resultScore;

  PracticeQuizResult(this.resultScore, this.incorrects);

  String resultText;

  String get resultPhrase {
    if (resultScore <= 3) {
      resultText = 'Limited level!';
    } else if (resultScore <= 5) {
      resultText = 'Modest level!';
    } else if (resultScore <= 7) {
      resultText = 'Competent level!';
    } else {
      resultText = 'Good level!';
    }
    return resultText;
  }

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
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Text(
                'You has correct ',
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
                  "$resultScore/10",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      fontFamily: "Helvetica"),
                ),
                footer: Text(
                  'Questions',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      fontFamily: "Helvetica"),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .popUntil(ModalRoute.withName('/lessonDetail'));
                },
                child: Text(
                  "Back to Lesson Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Helvetica",
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 8,
              ),
              Container(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 60.0,
                    child: Center(
                      child: Padding(
                        child: Text(
                          "Review your quiz",
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
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReviewQuizScreen(
                            incorrects: incorrects,
                          ))),
                  color: Colors.blueGrey,
                ),
              )
            ],
          ),
        ));
  }
}
