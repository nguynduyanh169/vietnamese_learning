import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/conversation_result.dart';
import 'package:vietnamese_learning/src/widgets/conversation_left.dart';
import 'package:vietnamese_learning/src/widgets/conversation_right.dart';

class ConversationDetail extends StatefulWidget {
  ConversationDetail({Key key}) : super(key: key);

  _ConversationDetailState createState() => _ConversationDetailState();
}

class _ConversationDetailState extends State<ConversationDetail> {
  int conversationIndex = 10;
  final List<String> entries = <String>[
    'Xin Chào',
    'Bạn tên gì',
    'Bạn bao nhiêu tuổi'
  ];
  final List<String> english = <String>[
    'Hello',
    'What is your name',
    'How old are you'
  ];

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
                  Text(
                    'Conversation',
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
                child: ListView(
                  children: [
                    ConversationLeft(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationRight(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationLeft(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationRight(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationLeft(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationRight(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationLeft(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationRight(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationLeft(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    ConversationRight(),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConversationResult(
                        words: conversationIndex,
                      ),
                    ));
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
                          "Finish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: "Helvetica",
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
