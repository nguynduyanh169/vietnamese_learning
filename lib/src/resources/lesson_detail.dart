import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/conversation_detail.dart';
import 'package:vietnamese_learning/src/resources/conversation_getstarted.dart';
import 'package:vietnamese_learning/src/resources/quiz_getstarted.dart';
import 'package:vietnamese_learning/src/resources/vocab_detail_screen.dart';

class LessonDetail extends StatefulWidget {
  String lessonName;
  String lessonId;
  int progressId;

  LessonDetail({Key key, this.lessonName, this.lessonId, this.progressId})
      : super(key: key);

  @override
  _LessonDetailState createState() => _LessonDetailState(
      title: lessonName, lessonId: lessonId, progressId: progressId);
}

class _LessonDetailState extends State<LessonDetail> {
  String title;
  String lessonId;
  int progressId;

  _LessonDetailState({this.title, this.lessonId, this.progressId});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 21,
                    ),
                    Text(
                      "$title",
                      style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 0,
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5),
                height: SizeConfig.blockSizeVertical * 90, // card height
                child: ListView(
                  children: <Widget>[
                    InkWell(
                      child: Card(
                        color: Colors.green,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2),
                            child: Text(
                              'Vocabulary',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/vocabulary_logo.png'),
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                bottom: SizeConfig.blockSizeVertical * 2),
                            child: Text(
                              'Vocabulary is the key to mastering a language',
                              style: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VocabDetailScreen(
                                    lessonId: lessonId,
                                    lessonName: title,
                                  )),
                        );
                      },
                    ),
                    InkWell(
                      child: Card(
                        color: Colors.amberAccent,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2),
                            child: Text(
                              'Conversation',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/conversation_logo.png'),
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                bottom: SizeConfig.blockSizeVertical * 2),
                            child: Text(
                              'Conversation makes you feel more confident',
                              style: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConversationGetStarted(
                                    lessonId: lessonId,
                                    lessonName: title,
                                  )),
                        );
                      },
                    ),
                    InkWell(
                      child: Card(
                        color: Colors.lightBlue,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2),
                            child: Text(
                              'Quiz',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2),
                            child: Image(
                              image: AssetImage('assets/images/quiz_logo.png'),
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                                bottom: SizeConfig.blockSizeVertical * 2,
                                left: 4.0,
                                right: 4.0),
                            child: Text(
                              'Do the quiz to test your memory',
                              style: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    QuizGetStarted(
                              lessonId: lessonId,
                              progressId: progressId,
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
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
