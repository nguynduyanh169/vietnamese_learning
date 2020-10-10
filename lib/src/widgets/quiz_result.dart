import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class QuizResult extends StatelessWidget{
  final int resultScore;
  final Function resetHandlar;

  QuizResult(this.resultScore,this.resetHandlar);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 20) {
      resultText = 'You are Bad! Result Score:$resultScore';
    } else if (resultScore <= 30) {
      resultText = 'You are Good! Result Score:$resultScore';
    } else if (resultScore <= 40) {
      resultText = 'You are Great! Result Score:$resultScore';
    } else {
      resultText = 'You are awasome! Result Score:$resultScore';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int correct = resultScore ~/ 10;
    int incorrect = 10 - correct;
    return Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Congratulation', style: TextStyle(fontSize: 40),),
              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
              Text('You has completed quiz part of Introduction'),
              SizedBox(height: SizeConfig.blockSizeVertical * 4,),
              Image(width: SizeConfig.blockSizeHorizontal * 40, height: SizeConfig.blockSizeVertical * 30,image: AssetImage('assets/images/quiz_logo.png'),),
              Text('Correct: $correct'),
              Text('Incorrect: $incorrect'),
              MaterialButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),
                child: Text("Back to Lesson Introduction"),)
            ],
          ),
        )
    );
  }
}