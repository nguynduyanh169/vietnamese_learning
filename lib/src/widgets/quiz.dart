import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/widgets/quiz_answer.dart';
import 'package:vietnamese_learning/src/widgets/quiz_question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestions;
  final Color primaryColor;



  Quiz(
      {@required this.questions,
      @required this.answerQuestions,
      @required this.questionIndex,
      @required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    var percentStr = questionIndex * 10.0;
    var percent = questionIndex * 0.1;
    SizeConfig().init(context);
    return Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3, left: SizeConfig.blockSizeHorizontal * 5, right: SizeConfig.blockSizeHorizontal * 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only( left: SizeConfig.blockSizeVertical * 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(icon: Icon(Icons.cancel), onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),),
                Container(
                  child: new LinearPercentIndicator(
                    width: SizeConfig.blockSizeHorizontal * 75,
                    animation: false,
                    lineHeight: 15.0,
                    percent: percent,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          QuizQuestion(
            questions[questionIndex]['questionText'],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 9,),
          Expanded(
              child: Column(
                children: [
                  ...(questions[questionIndex]['answers'] as List<Map<String,Object>>).map((answers) {
                    return QuizAnswer(() => answerQuestions(answers['score']), answers['text'], primaryColor);
                  }).toList()
                ],
              )
          )
        ],
      ),
    );
  }
}
