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

class ConversationGetStarted extends StatelessWidget {
  String lessonId;
  String lessonName;
  List<Conversation> conversations;

  ConversationGetStarted({this.lessonId, this.lessonName, this.conversations});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int numOfVocabs = conversations.length;
    return Scaffold(
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
                onPressed: () => Navigator.of(context).pop('No reload'),
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
                            ConversationDetail(conversations: conversations, lessonTitle: lessonName, lessonID: lessonId,),
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
    );
  }

}

