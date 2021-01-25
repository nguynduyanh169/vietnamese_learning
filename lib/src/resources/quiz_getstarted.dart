import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/cubit/quiz_cubit.dart';
import 'package:vietnamese_learning/src/data/quiz_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/resources/practice_quiz_screen.dart';
import 'package:vietnamese_learning/src/resources/quiz_screen.dart';
import 'package:vietnamese_learning/src/states/quiz_state.dart';

class QuizGetStarted extends StatefulWidget {
  String lessonId;
  Progress progress;
  String lessonName;

  QuizGetStarted({Key key, this.lessonId, this.progress, this.lessonName}) : super(key: key);

  _QuizGetStartedState createState() =>
      _QuizGetStartedState(lessonId: lessonId, progress: progress, lessonName: lessonName);
}

class _QuizGetStartedState extends State<QuizGetStarted> {
  String lessonId;
  Progress progress;
  String lessonName;

  _QuizGetStartedState({this.lessonId, this.progress, this.lessonName});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => QuizCubit(QuizRepository())..loadQuiz(lessonId),
      child: Scaffold(
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state){
            if (state is QuizLoaded) {
              return _quizDetail(state.questions);
            } else if (state is QuizLoadError) {
              return Center(
                child: Text('Something went wrong!'),
              );
            } else {
              return _loadingQuiz();
            }
          },
        ),
      ),
    );
  }

  Widget _loadingQuiz() {
    return Container(
      color: Colors.lightBlue,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('assets/images/quiz_logo.png'),
                width: 160,
                height: 160,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            CupertinoActivityIndicator(
              radius: 20,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Helvetica',
                  color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quizDetail(List<Question> questions) {
    int numberOfQuestion = questions.length;
    return Container(
      color: Colors.lightBlue,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 4,
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                'Quiz',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Helvetica',
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 50, left: 77, right: 80),
            width: SizeConfig.blockSizeHorizontal * 60,
            child: Image(
              image: AssetImage('assets/images/quiz_logo.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Lesson $lessonName",
              style: GoogleFonts.sansita(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "10pts | $numberOfQuestion Questions",
              style: GoogleFonts.sansita(
                textStyle: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 12,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .85,
            height: 80.0,
            child: Card(
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                  onTap: () {
                    if(questions.length == 0){
                      Toast.show("This lesson does not update any quiz !", context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.TOP,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white);
                    }else {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) => PracticeQuizScreen(questions: questions,),
                          transitionsBuilder: (context, animation,
                              secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pratice Now",
                            style: GoogleFonts.sansita(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .85,
            height: 80.0,
            child: Card(
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                  onTap: () {
                    if(questions.length == 0){
                      Toast.show("This lesson does not update any quiz !", context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.TOP,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white);
                    }else {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  QuizScreen(questions: questions, progress: progress, lessonId: lessonId,),
                          transitionsBuilder: (context, animation,
                              secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Quiz Now",
                            style: GoogleFonts.sansita(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
