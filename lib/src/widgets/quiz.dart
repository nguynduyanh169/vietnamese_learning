import 'package:flutter/material.dart';
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
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 8),
      child: Column(
        children: [
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
