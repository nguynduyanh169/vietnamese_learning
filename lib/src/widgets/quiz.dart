import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/widgets/quiz_answer.dart';
import 'package:vietnamese_learning/src/widgets/quiz_question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestions;

  Quiz(
      {@required this.questions,
      @required this.answerQuestions,
      @required this.questionIndex});

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
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),),
                Text("Lesson Details", style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          Container(
            child: new LinearPercentIndicator(
              width: SizeConfig.blockSizeHorizontal * 88,
              animation: false,
              lineHeight: 15.0,
              percent: percent,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.blueAccent,
            ),
          ),
          QuizQuestion(
            questions[questionIndex]['questionText'],
          ),
          Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                children: [
                  ...(questions[questionIndex]['answers'] as List<Map<String,Object>>).map((answers) {
                    return QuizAnswer(() => answerQuestions(answers['score']), answers['text']);
                  }).toList()
                ],
              )
          )
        ],
      ),
    );
  }
}
