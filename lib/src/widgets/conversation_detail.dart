import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/conversation_detail.dart';
import 'package:vietnamese_learning/src/resources/login_page.dart';

class ConversationDetail1 extends StatefulWidget {
  ConversationDetail1({Key key}) : super(key: key);
  _ConversationDetail1State createState() => _ConversationDetail1State();
}

@override
class _ConversationDetail1State extends State<ConversationDetail1> {
  int conversationIndex = 0;
  var percent = 0.0;
  final conversations = [
    {
      'vietnamese': 'Xin Chào',
      'english': "Hello",
    },
    {
      'vietnamese': 'Xin Chào, bạn tên gì',
      'english': "Hi, What is your name?",
    },
    {
      'vietnamese': 'Tôi tên A, bạn tên gì',
      'english': "My name is A, what is your name?",
    },
    {
      'vietnamese': 'Tôi tên B, bạn có khỏe không',
      'english': "My name is B, how are you?",
    },
    {
      'vietnamese': 'Tôi khỏe, còn bạn',
      'english': "I am fine, how are you?",
    },
    {
      'vietnamese': 'Tôi khỏe, cảm ơn',
      'english': "I am fine, thank you",
    },
    {
      'vietnamese': 'Tôi tên A, bạn tên gì',
      'english': "My name is A, what is your name?",
    },
    {
      'vietnamese': 'Tôi tên B, bạn có khỏe không',
      'english': "My name is B, how are you?",
    },
    {
      'vietnamese': 'Tôi khỏe, còn bạn',
      'english': "I am fine, how are you?",
    },
    {
      'vietnamese': 'Tôi khỏe, cảm ơn',
      'english': "I am fine, thank you",
    },
  ];

  void nextQuestion() {
    setState(() {
      percent = conversationIndex * 0.1;
      conversationIndex = conversationIndex + 1;
    });
  }

  Widget _percentBar(var percent) {
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeHorizontal * 1),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(context),
          ),
          Container(
            child: new LinearPercentIndicator(
              width: SizeConfig.blockSizeHorizontal * 78,
              animation: false,
              lineHeight: 15.0,
              percent: percent,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.amberAccent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var percent = conversationIndex * 0.1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: conversationIndex < conversations.length
          ? Container(
              color: Color.fromRGBO(255, 239, 215, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context),
                        ),
                        Container(
                          child: new LinearPercentIndicator(
                            width: SizeConfig.blockSizeHorizontal * 78,
                            animation: false,
                            lineHeight: 15.0,
                            percent: percent,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.amberAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "Speak this conversation",
                      style: TextStyle(
                          fontFamily: "Helvetica",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 14,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        margin: EdgeInsets.only(left: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Color.fromRGBO(255, 190, 51, 100),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(255, 190, 51, 100),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.volume_up,
                            color: Colors.white,
                          ),
                          onPressed: null,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          conversations[conversationIndex]['vietnamese'],
                          style: TextStyle(
                              fontFamily: "Helvetica",
                              fontSize: 17,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 8,
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color.fromRGBO(255, 190, 51, 100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(255, 190, 51, 100)
                                .withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 100,
                        icon: Icon(
                          CupertinoIcons.mic_solid,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 8,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        nextQuestion();
                      },
                      child: Container(
                          width: SizeConfig.blockSizeHorizontal * 80,
                          height: SizeConfig.blockSizeVertical * 9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(255, 190, 51, 30),
                          ),
                          child: Center(
                            child: Text(
                              "Check",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            )
          : ConversationDetail(),
    );
  }
}
