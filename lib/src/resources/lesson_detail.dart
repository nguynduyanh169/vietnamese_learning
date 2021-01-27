import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/lesson_details_cubit.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
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
import 'package:vietnamese_learning/src/utils/hive_utils.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

import '../constants.dart';

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
  VocabularyRepository _vocabularyRepository = new VocabularyRepository();
  ConversationRepository _conversationRepository =  new ConversationRepository();
  LessonRepository _lessonRepository = new LessonRepository();
  String title;
  String lessonId;
  Progress progress;
  double percent = 0;
  bool isDownload = true;
  bool isUpdate = true;
  bool isProgressSync = true;
  List<Conversation> conversations = new List();
  List<Vocabulary> vocabularies = new List();
  double vocabProgress = 0;
  double converProgress = 0;
  double quizProgress = 0;
  SaveProgressLocal progressLocal;

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      return false;
    }else{
      return true;
    }
  }

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

  Widget _button(BuildContext context) {
    if (isDownload == false) {
      return InkWell(
        onTap: () async {
          bool checkInternet = await checkConnectivity();
          if(checkInternet == true) {
            BlocProvider.of<LessonDetailsCubit>(context)
                .downloadLesson(lessonId);
          }else{
            Toast.show('Please connect internet to download lesson!', context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);
          }
        },
        child: Container(
          alignment: Alignment.centerRight,
          width: SizeConfig.blockSizeHorizontal * 30,
          height: SizeConfig.blockSizeVertical * 9,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.cloud_download,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
              Text(
                "Download",
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Helvetica',
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    }if (isUpdate == false) {
      return InkWell(
        onTap: () async {
          bool checkInternet = await checkConnectivity();
          if(checkInternet == true) {
            BlocProvider.of<LessonDetailsCubit>(context)
                .downloadLesson(lessonId);
          }
        },
        child: Container(
          alignment: Alignment.centerRight,
          width: SizeConfig.blockSizeHorizontal * 30,
          height: SizeConfig.blockSizeVertical * 9,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.cloud_download,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
              Text(
                "Update",
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Helvetica',
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      if (isProgressSync == false) {
        return InkWell(
          onTap: () async {
            bool checkInternet = await checkConnectivity();
            if(checkInternet == true){
              BlocProvider.of<LessonDetailsCubit>(context)
                  .syncNewProgress(progress, progressLocal);
            }else{
              Toast.show('Please connect internet to sync progress lesson!', context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white);
            }

          },
          child: Container(
              alignment: Alignment.centerLeft,
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 9,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.arrow_up_arrow_down_circle,
                      color: Colors.blue,
                    ),
                    iconSize: 30,
                  ),
                  Text(
                    "Sync Progress",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Helvetica',
                      fontSize: 10,
                    ),
                  ),
                ],
              )),
        );
      } else {
        return Container();
      }
    }
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => LessonDetailsCubit(VocabularyRepository(),
          ConversationRepository(), ProgressRepository())
        ..loadLessonFromLocalStorage(lessonId, progress),
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
            isProgressSync = state.isSyncProgress;
            isUpdate = state.isUpdated;
            print(isDownload);
          } else if (state is CannotLoadLocalLesson) {
            isDownload = false;
            progressLocal = state.progressLocal;
            converProgress = progressLocal.converProgress;
            vocabProgress = progressLocal.vocabProgress;
            quizProgress = progressLocal.quizProgress;
            isProgressSync = state.isSyncProgress;
            Toast.show(state.message, context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);
          } else if (state is SyncingProgress) {
            print('Sync');
            CustomProgressDialog.progressDialog(context);
          } else if (state is SyncProgressSuccess) {
            Navigator.pop(context);
            print('success');
            isProgressSync = true;
            progressLocal = state.newProgressLocal;
            converProgress = progressLocal.converProgress;
            vocabProgress = progressLocal.vocabProgress;
            quizProgress = progressLocal.quizProgress;
          } else if(state is SyncProgressFailed){
            Navigator.pop(context);
            isProgressSync = false;
            print('failed');
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
                            left: SizeConfig.blockSizeVertical * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FlatButton.icon(
                              icon: Icon(
                                CupertinoIcons.back,
                                color: Colors.black,
                                size: 20,
                              ),
                              label: Text(
                                "Back",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 42,
                            ),
                            _button(context)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        width: SizeConfig.blockSizeHorizontal * 87,
                        child: Text(
                          "$title",
                          style: TextStyle(
                            fontSize: 29,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 0,
                            left: SizeConfig.blockSizeHorizontal * 5,
                            right: SizeConfig.blockSizeHorizontal * 5),
                        height: SizeConfig.blockSizeVertical * 84,
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
                                                1,
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
                                      height: SizeConfig.blockSizeVertical * 1,
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
                                      height: SizeConfig.blockSizeVertical * 1,
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
                                if(isDownload == false){
                                  Toast.show(
                                      'Please download lesson before learn!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white);
                                }else{
                                  if (vocabularies.isEmpty) {
                                    Toast.show(
                                        'This lesson has not updated vocabulary part!',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        textColor: Colors.white);
                                  } else {
                                    Navigator.of(context)
                                        .push(
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
                                    )
                                        .whenComplete(() {
                                      BlocProvider.of<LessonDetailsCubit>(context)
                                          .loadLessonFromLocalStorage(
                                          lessonId, progress);
                                    });
                                  }
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
                                          top: SizeConfig.blockSizeVertical * 1,
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
                                        top: SizeConfig.blockSizeVertical * 1),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/conversation_logo.png'),
                                      width: 90,
                                      height: 90,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
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
                                if(isDownload == false){
                                  Toast.show(
                                      'Please download lesson before learn!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white);
                                }else{
                                  if (conversations.isEmpty) {
                                    Toast.show(
                                        'This lesson has not updated conversation part!',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        textColor: Colors.white);
                                  } else {
                                    Navigator.of(context)
                                        .push(
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
                                    )
                                        .whenComplete(() {
                                      BlocProvider.of<LessonDetailsCubit>(context)
                                          .loadLessonFromLocalStorage(
                                          lessonId, progress);
                                    });
                                  }
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
                                        top: SizeConfig.blockSizeVertical * 1),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/quiz_logo.png'),
                                      width: 90,
                                      height: 90,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
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
                              onTap: () async {
                                bool checkInternet = await checkConnectivity();
                                if(checkInternet == true){
                                  print(converProgress);
                                  if (vocabProgress < 8 ||
                                      converProgress < 8) {
                                    Toast.show(
                                        'You need to finish the lesson before do the quiz',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        textColor: Colors.white);
                                  } else {
                                    Navigator.of(context)
                                        .push(
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
                                          var tween = Tween(
                                              begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    )
                                        .whenComplete(() {
                                      BlocProvider.of<LessonDetailsCubit>(context)
                                          .loadLessonFromLocalStorage(
                                          lessonId, progress);
                                    });
                                  }
                                }
                                else{
                                  Toast.show(
                                      'Please connect internet to do quiz!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      textColor: Colors.white);
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
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
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
      ),
    );
  }


}
