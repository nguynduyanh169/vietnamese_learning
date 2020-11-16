import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/cubit/conversation_cubit.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/resources/conversation_detail.dart';
import 'package:vietnamese_learning/src/states/conversation_state.dart';
import 'package:vietnamese_learning/src/widgets/conversation_speaking.dart';

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
      child: Scaffold(body: BlocBuilder<ConversationsCubit, ConversationState>(
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            ConversationDetail(conversations: _conversations),
                      ));
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
    return Container(
      color: Colors.amber[400],
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: 20,
            ),
            Text(
              'Loading....',
              style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
            )
          ],
        ),
      ),
    );
  }
}
