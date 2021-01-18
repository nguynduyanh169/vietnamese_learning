import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/lesson_details_cubit.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/resources/conversation_detail.dart';
import 'package:vietnamese_learning/src/resources/conversation_getstarted.dart';
import 'package:vietnamese_learning/src/resources/quiz_getstarted.dart';
import 'package:vietnamese_learning/src/resources/vocab_detail_screen.dart';
import 'package:vietnamese_learning/src/states/lesson_details_state.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

class LessonDetail extends StatefulWidget {
  String lessonName;
  String lessonId;
  Progress progress;

  LessonDetail({Key key, this.lessonName, this.lessonId, this.progress})
      : super(key: key);

  @override
  _LessonDetailState createState() => _LessonDetailState(
      title: lessonName, lessonId: lessonId, progress: progress);
}

class _LessonDetailState extends State<LessonDetail> {
  String title;
  String lessonId;
  Progress progress;
  double percent = 0;
  bool isDownload = true;
  List<Conversation> conversations = new List();
  List<Vocabulary> vocabularies = new List();
  double vocabProgress = 0;
  double converProgress = 0;
  double quizProgress = 0;
  SaveProgressLocal progressLocal;

  _LessonDetailState({this.title, this.lessonId, this.progress});

  Widget _progress(double progress) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lime,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(255, 239, 215, 10),
            ),
            child: Center(
              child: Text(
                "${(progress * 10).toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[700],
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          LessonDetailsCubit(VocabularyRepository(), ConversationRepository())
            ..loadLessonFromLocalStorage(lessonId),
      child: BlocConsumer<LessonDetailsCubit, LessonDetailsState>(
        listener: (context, state) {
          if (state is DownloadingLesson) {
            percent = state.percent;
          } else if (state is DownloadLessonFailed) {
            print('Download Failed');
          } else if (state is DownloadLessonSuccess) {
            vocabularies = state.vocabularies;
            conversations = state.conversations;
            print('Success');
            isDownload = true;
          } else if (state is LoadingLocalLesson) {
          } else if (state is LoadLocalLessonSuccess) {
            vocabularies = state.vocabularies;
            conversations = state.conversations;
            progressLocal = state.progressLocal;
            converProgress = progressLocal.converProgress;
            vocabProgress = progressLocal.vocabProgress;
            quizProgress = progressLocal.quizProgress;

          } else if (state is CannotLoadLocalLesson) {
            isDownload = false;
            Toast.show(state.message, context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);
          }
        },
        builder: (context, state) {
          if (state is DownloadingLesson) {
            return _loading();
          } else {
            return Scaffold(
              body: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 239, 215, 100),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2,
                            left: SizeConfig.blockSizeVertical * 2),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 5,
                            ),
                            FittedBox(
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 55,
                                child: Text(
                                  "$title",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Helvetica'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            isDownload == false
                                ? Container(
                                    child: IconButton(
                                      icon: Icon(CupertinoIcons.arrow_down_doc),
                                      iconSize: 30,
                                      onPressed: () {
                                        BlocProvider.of<LessonDetailsCubit>(
                                                context)
                                            .downloadLesson(lessonId);
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 0,
                            left: SizeConfig.blockSizeHorizontal * 5,
                            right: SizeConfig.blockSizeHorizontal * 5),
                        height: SizeConfig.blockSizeVertical * 90,
                        // card height
                        child: ListView(
                          children: <Widget>[
                            InkWell(
                              child: Card(
                                color: Colors.green,
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                2,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    19,
                                          ),
                                          child: Text(
                                            'Vocabulary',
                                            style: TextStyle(
                                                fontFamily: 'Helvetica',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 4, right: 4),
                                            child: _progress(vocabProgress),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 2,
                                    ),
                                    Container(
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/vocabulary_logo.png'),
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 2,
                                    ),
                                    Container(
                                      child: Text(
                                        'Vocabulary is the key to mastering a language',
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 2,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (vocabularies.isEmpty) {
                                  Toast.show(
                                      'Please download lesson before learn!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white);
                                } else {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          VocabDetailScreen(
                                        lessonId: lessonId,
                                        lessonName: title,
                                            vocabularies: vocabularies,
                                      ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  ).whenComplete(() {
                                    BlocProvider.of<LessonDetailsCubit>(context).loadLessonFromLocalStorage(lessonId);
                                  });
                                }
                              },
                            ),
                            InkWell(
                              child: Card(
                                color: Colors.amberAccent,
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Column(children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 2,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  16,
                                        ),
                                        child: Text(
                                          'Conversation',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        child: Container(
                                          padding:
                                              EdgeInsets.only(top: 4, right: 4),
                                          child: _progress(converProgress),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/conversation_logo.png'),
                                      width: 90,
                                      height: 90,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        bottom:
                                            SizeConfig.blockSizeVertical * 2),
                                    child: Text(
                                      'Conversation makes you feel more confident',
                                      style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ]),
                              ),
                              onTap: () {
                                if (conversations.isEmpty) {
                                  Toast.show(
                                      'Please download lesson before learn!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white);
                                }else {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          ConversationGetStarted(
                                            lessonId: lessonId,
                                            lessonName: title,
                                            conversations: conversations,
                                          ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  ).whenComplete(() {
                                    BlocProvider.of<LessonDetailsCubit>(context).loadLessonFromLocalStorage(lessonId);
                                  });
                                }
                              },
                            ),
                            InkWell(
                              child: Card(
                                color: Colors.lightBlue,
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Column(children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 2,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  27,
                                        ),
                                        child: Text(
                                          'Quiz',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        child: Container(
                                          padding:
                                              EdgeInsets.only(top: 4, right: 4),
                                          child: _progress(quizProgress),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/quiz_logo.png'),
                                      width: 90,
                                      height: 90,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2,
                                        bottom:
                                            SizeConfig.blockSizeVertical * 2,
                                        left: 4.0,
                                        right: 4.0),
                                    child: Text(
                                      'Do the quiz to test your memory',
                                      style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ]),
                              ),
                              onTap: () {
                                if(vocabProgress < 0.8 && converProgress < 0.8){
                                  Toast.show(
                                      'You need to finish the lesson before do the quiz',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white);
                                }else{
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          QuizGetStarted(
                                            lessonId: lessonId,
                                            progress: progress,
                                            lessonName: title,
                                          ),
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
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          }
        },
      ),
    );
  }

  Widget _loading() {
    final percentage = percent * 100;
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage('assets/images/download_icon.png'),
                  width: 160,
                  height: 160,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 15,
                    right: SizeConfig.blockSizeHorizontal * 15),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 150,
                  height: 40.0,
                  child: LiquidLinearProgressIndicator(
                    value: percent,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(
                      //Color.fromRGBO(255, 190, 51, 30),
                      Colors.blueAccent,
                    ),
                    borderRadius: 12.0,
                    center: Text(
                      "${percentage.toStringAsFixed(0)}%",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // LinearPercentIndicator(
                //   width: SizeConfig.blockSizeHorizontal * 60,
                //   animation: false,
                //   lineHeight: 18.0,
                //   animationDuration: 1000,
                //   percent: percent,
                //   center: Text(
                //     "${(percent * 100).toStringAsFixed(2)}%",
                //     style: TextStyle(
                //         fontSize: 9, fontFamily: 'Helvetica'),
                //   ),
                //   linearStrokeCap: LinearStrokeCap.roundAll,
                //   progressColor: Colors.amberAccent,
                // ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Text(
                'Loading...',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Helvetica', color: Colors.black38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
