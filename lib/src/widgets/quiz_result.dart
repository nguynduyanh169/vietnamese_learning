import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class QuizResult extends StatelessWidget {
  final int resultScore;
  final Function resetHandlar;

  QuizResult(this.resultScore, this.resetHandlar);

  String resultText;

  String get resultPhrase {
    if (resultScore <= 20) {
      resultText = 'Not bad!';
    } else if (resultScore <= 30) {
      resultText = 'Pretty good!';
    } else if (resultScore <= 40) {
      resultText = 'Good!';
    } else {
      resultText = 'Awesome!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int correct = resultScore ~/ 10;
    var percent = correct / 10;
    return Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
        color: Color.fromRGBO(255, 239, 204, 100),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '$resultPhrase',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.bold,
                ),
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
                  "$correct/10",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,fontFamily: "Helvetica"),
                ),
                footer: Text('answers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,fontFamily: "Helvetica"),),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.amberAccent,
              ),
              MaterialButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(context),
                child: Text(
                  "Back to Quiz Introduction",
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
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60.0,
                  child: Center(
                    child: Padding(
                      child: Text(
                        "Review",
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
                onPressed: () {},
                color: Colors.blueGrey,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60.0,
                  child: Center(
                    child: Padding(
                      child: Text(
                        "Do again",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                      padding: new EdgeInsets.only(left: 0.0),
                    ),
                  ),
                ),
                onPressed: () {},
                color: Color.fromRGBO(255, 210, 77, 10),
              ),
            ],
          ),
        ));
  }
}
