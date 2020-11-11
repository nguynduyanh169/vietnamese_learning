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
  final BuildContext rootContext;
  Quiz(
      {@required this.questions,
      @required this.answerQuestions,
      @required this.questionIndex,
      @required this.primaryColor, this.rootContext});

  String correctAns(){
    for (var answer in questions[questionIndex]['answers']){
      if(answer['score'] == 10){
        return answer['text'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var percent = questionIndex * 0.1;
    String type = questions[questionIndex]['type'];
    SizeConfig().init(context);
    return Container(
      color: Color.fromRGBO(255, 239, 204, 100),
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3, left: SizeConfig.blockSizeHorizontal * 5, right: SizeConfig.blockSizeHorizontal * 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only( left: SizeConfig.blockSizeVertical * 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(icon: Icon(Icons.clear), onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),),
                Container(
                  child: new LinearPercentIndicator(
                    width: SizeConfig.blockSizeHorizontal * 75,
                    animation: false,
                    lineHeight: 15.0,
                    percent: percent,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.amberAccent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
          Text('$type', style: TextStyle(fontSize: 25, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          QuizQuestion(
            questions[questionIndex]['questionText'],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          Expanded(
              child: Column(
                children: [
                  ...(questions[questionIndex]['answers'] as List<Map<String,Object>>).map((answers) {
                    return QuizAnswer(() => answerQuestions(answers['score']), answers['text'], primaryColor, answers['score'], correctAns(), rootContext);
                  }).toList()
                ],
              )
          )
        ],
      ),
    );
  }
}
