import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/option.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/widgets/quiz_answer.dart';
import 'package:vietnamese_learning/src/widgets/quiz_question.dart';

class Quiz extends StatelessWidget {
  final List<Question> questions;
  final int questionIndex;
  final Function answerQuestions;
  final BuildContext rootContext;
  Quiz(
      {@required this.questions,
      @required this.answerQuestions,
      @required this.questionIndex, this.rootContext});

  String correctAns(){
    for (var answer in questions[questionIndex].options){
      if(answer.checkCorrect == true){
        return answer.optionName;
      }
    }
  }

  Widget _questionType(int type){
    if(type == 1){
      return Text('Answer the question', style: TextStyle(fontSize: 25, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), textAlign: TextAlign.center,);

    }else if(type == 2){
      return Text('Listen and answer the question', style: TextStyle(fontSize: 25, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), textAlign: TextAlign.center,);

    }
  }

  @override
  Widget build(BuildContext context) {
    var percent = questionIndex * (1/questions.length);
    int type = questions[questionIndex].quizType;
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
          _questionType(type),
          QuizQuestion(questionText: questions[questionIndex].question, questionType: type,),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          Expanded(
              child: Column(
                children: [
                  ...(questions[questionIndex].options as List<Option>).map((answers) {
                    return QuizAnswer(() => answerQuestions(10), answers.optionName, answers.checkCorrect, correctAns(), rootContext);
                  }).toList()
                ],
              )
          )
        ],
      ),
    );
  }
}
