import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/cubit/conversation_cubit.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/resources/conversation_detail.dart';
import 'package:vietnamese_learning/src/states/conversation_state.dart';

class ConversationGetStarted extends StatefulWidget {
  String lessonId;
  String lessonName;
  ConversationGetStarted({Key key, this.lessonId, this.lessonName})
      : super(key: key);

  _ConversationGetStartedState createState() =>
      _ConversationGetStartedState(lessonId: lessonId, title: lessonName);
}

class _ConversationGetStartedState extends State<ConversationGetStarted> {
  String lessonId;
  String title;
  double percent = 0;
  _ConversationGetStartedState({this.lessonId, this.title});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => ConversationsCubit(ConversationRepository())
        ..loadConversationsByLessonId(lessonId),
      child: Scaffold(
          body: BlocConsumer<ConversationsCubit, ConversationState>(
            listener: (context, state){
              if(state is DownloadingPercentage){
                percent = state.percent;
              }
            },
        builder: (context, state) {
          if (state is ConversationsLoaded) {
            return _conversationDetails(state.conversations);
          } else if (state is ConversationLoadError) {
            return Center(
              child: Text('Something went wrong!'),
            );
          } else {
            return _loadingConversation();
          }
        },
      )),
    );
  }

  Widget _conversationDetails(List<Conversation> _conversations) {
    int numOfVocabs = _conversations.length;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.amber[400],
        body: Column(
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
                  'Conversation',
                  style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                )
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 50, left: 77, right: 80),
              width: SizeConfig.blockSizeHorizontal * 60,
              child: Image(
                image: AssetImage('assets/images/conversation_logo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Lesson $title",
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
                "$numOfVocabs Conversation",
                style: GoogleFonts.sansita(
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              height: 80.0,
              child: Card(
                color: Colors.brown[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                              ConversationDetail(conversations: _conversations, lessonTitle: title,),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Learn Now",
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
      ),
    );
  }

  Widget _loadingConversation() {
    final percentage = percent * 100;
    return Container(
      color: Colors.amber[400],
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('assets/images/vocabulary_logo.png'),
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
    );
  }
}
