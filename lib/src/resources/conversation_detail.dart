import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/resources/conversation_result.dart';
import 'package:vietnamese_learning/src/widgets/conversation_speaking.dart';
import 'package:vietnamese_learning/src/widgets/conversation_left.dart';
import 'package:vietnamese_learning/src/widgets/conversation_right.dart';

class ConversationDetail extends StatefulWidget {
  List<Conversation> conversations;
  String lessonTitle;
  ConversationDetail({Key key, this.conversations, this.lessonTitle})
      : super(key: key);

  _ConversationDetailState createState() => _ConversationDetailState(
      conversations: conversations, lessonTitle: lessonTitle);
}

class _ConversationDetailState extends State<ConversationDetail> {
  List<Conversation> conversations;
  String lessonTitle;
  _ConversationDetailState({this.conversations, this.lessonTitle});

  var conversationIndex = 0;

  List<String> words = new List();
  List<Widget> elements = new List();

  Widget _placeConversation(
      String english, String vietnamese, int index, String voiceLink) {
    if (index % 2 == 0) {
      return ConversationLeft(
        english: english,
        vietnamese: vietnamese,
        voiceLink: voiceLink,
      );
    } else if (index % 2 != 0) {
      return ConversationRight(
        english: english,
        vietnamese: vietnamese,
        voiceLink: voiceLink,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(255, 239, 215, 15),
        body: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 23,),
                  Text(
                    '$lessonTitle',
                    style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  )
                ],
              ),
              Container(
                width: SizeConfig.blockSizeVertical * 60,
                height: SizeConfig.blockSizeHorizontal * 40,
                child: Image(
                  image: AssetImage('assets/images/chaohoi.png'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _placeConversation(
                        conversations[index].description,
                        conversations[index].conversation,
                        index,
                        conversations[index].voiceLink);
                  },
                  itemCount: conversations.length,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: ButtonTheme(
                  buttonColor: Color.fromRGBO(255, 190, 51, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: FlatButton(
                    color: Color.fromRGBO(255, 190, 51, 30),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                ConversationSpeaking(conversations: conversations),
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
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 70,
                        height: SizeConfig.blockSizeVertical * 8,
                        child: Center(
                          child: Text(
                            'Learn now',
                            style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
