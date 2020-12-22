import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/widgets/practice_quiz_answer.dart';
import 'package:vietnamese_learning/src/widgets/practice_quiz_question.dart';

class PracticeQuiz extends StatelessWidget{

  final List<Question> questions;
  final int questionIndex;
  final Function answerQuestions;
  final Function choice;
  final BuildContext rootContext;
  final int tappedIndex;
  final bool checkCorrect;
  final String userChoice;
  String correctAnswer;

  PracticeQuiz(
      {@required this.questions,
        @required this.answerQuestions,
        @required this.questionIndex, this.rootContext, this.tappedIndex, this.choice, this.checkCorrect, this.userChoice, this.correctAnswer});

  String correctAns(){
    for (var answer in questions[questionIndex].options){
      if(answer.checkCorrect == true){
        return answer.optionName;
      }
    }
  }

  Widget _loadDialog(BuildContext buildContext) {
    if (checkCorrect == true) {
      showDialog(
          context: buildContext,
          barrierDismissible: false,
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
                                '$userChoice',
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
                        answerQuestions();
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
          barrierDismissible: false,
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
                                '$correctAnswer',
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
                        answerQuestions();
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

  Widget _questionType(int type){
    if(type == 1){
      return Text('Answer the question', style: TextStyle(fontSize: 25, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), textAlign: TextAlign.center,);

    }else if(type == 2){
      return Text('Listen and answer the question', style: TextStyle(fontSize: 25, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
    }
    else if(type == 3){
      return Text('Which one of these is the meaning of this image ?', style: TextStyle(fontSize: 25, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
    }else if(type == 5){
      return Text('Answer the question', style: TextStyle(fontSize: 25, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
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
                IconButton(icon: Icon(Icons.clear), onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) =>
                    new CupertinoAlertDialog(
                      title: new Text(
                        "Confirm exit",
                        style: TextStyle(fontFamily: 'Helvetica'),
                      ),
                      content: new Text(
                        "Do you want to exit?",
                        style: TextStyle(fontFamily: 'Helvetica'),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'yes');
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'no');
                          },
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value == 'yes') {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  });
                }),
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
          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
          _questionType(type),
          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
          PracticeQuizQuestion(questionText: questions[questionIndex].question, questionType: type,),
          Expanded(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: questions[questionIndex].options.length,
                    itemBuilder: (context, index){
                      return PracticeQuizAnswer(questions[questionIndex].options[index].optionName, questions[questionIndex].options[index].checkCorrect, correctAns(), rootContext, index, choice, tappedIndex, questions[questionIndex].options[index].optionID, questions[questionIndex].question, questions[questionIndex].quizType);
                    })
              ],
            ),
          ),
          ButtonTheme(
            buttonColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: FlatButton(
                color: tappedIndex != 5 ? Colors.blueAccent : Colors.black26,
                onPressed: () {
                  if(tappedIndex != 5) {
                    correctAnswer = correctAns();
                    _loadDialog(rootContext);
                  }else{
                    return null;
                  }
                },
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  height: SizeConfig.blockSizeVertical * 8,
                  child: Center(
                    child: Text(
                      'Check',
                      style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )),
          ), SizedBox(height: SizeConfig.blockSizeVertical * 2,)
        ],
      ),
    );
  }
}