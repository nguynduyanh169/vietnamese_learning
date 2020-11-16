import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reorderables/reorderables.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/learn_conversation_cubit.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/resources/conversation_result.dart';
import 'package:vietnamese_learning/src/states/learn_converasation_state.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

class ConversationSpeaking extends StatefulWidget {
  List<Conversation> conversations;
  ConversationSpeaking({Key key, this.conversations}) : super(key: key);
  _ConversationSpeakingState createState() =>
      _ConversationSpeakingState(conversations: conversations);
}

@override
class _ConversationSpeakingState extends State<ConversationSpeaking> {
  List<Conversation> conversations;
  _ConversationSpeakingState({this.conversations});
  int conversationIndex = 0;
  var percent = 0.0;
  List<Widget> elements = new List();
  List<String> chars = new List();
  String vietnamese;
  String english;
  String check;

  void nextQuestion() {
    setState(() {
      percent = conversationIndex * 0.1;
      conversationIndex = conversationIndex + 1;
    });
  }

  void speakingButton(BuildContext context) {
    BlocProvider.of<LearnConversationCubit>(context)
        .learnMatching(conversationIndex);
  }

  @override
  Widget build(BuildContext context) {
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

    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = elements.removeAt(oldIndex);
        String char = chars.removeAt(oldIndex);
        elements.insert(newIndex, row);
        chars.insert(newIndex, char);
      });
    }

    var wrap = ReorderableWrap(
        spacing: 8.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(3),
        children: elements,
        onReorder: onReorder,
        onNoReorder: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
        });

    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[wrap],
    );

    Widget _card(String content) {
      return Container(
        width: SizeConfig.blockSizeHorizontal * 20,
        height: SizeConfig.blockSizeVertical * 7,
        child: Center(
          child: Text(
            '$content',
            style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.amber,
            width: 2,
          ),
        ),
      );
    }

    Widget _loadDialogForMatching(BuildContext dialogContext) {
      if (check.toLowerCase() == vietnamese.toLowerCase()) {
        CoolAlert.show(
            context: dialogContext,
            type: CoolAlertType.success,
            title: "Correct!",
            confirmBtnText: 'Continue',
            confirmBtnColor: Colors.green,
            onConfirmBtnTap: () {
              chars.clear();
              elements.clear();
              BlocProvider.of<LearnConversationCubit>(dialogContext)
                  .learnSpeaking(conversationIndex + 1);
              Navigator.pop(context);
              conversationIndex = conversationIndex + 1;
            });
      } else if (check.toLowerCase() != vietnamese.toLowerCase()) {
        CoolAlert.show(
            context: dialogContext,
            type: CoolAlertType.error,
            title: "Incorrect!",
            text: 'The correct answer is: $vietnamese',
            confirmBtnText: 'Try again',
            confirmBtnColor: Colors.red,
            onConfirmBtnTap: null);
      }
    }

    Widget _matchingConversation(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 3,
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5),
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Correct the conversation',
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Text(
              '$english',
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 15,
            ),
            column,
            SizedBox(
              height: SizeConfig.blockSizeVertical * 14,
            ),
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: RaisedButton(
                  onPressed: () {
                    check = chars.join(' ');
                    _loadDialogForMatching(context);
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    height: SizeConfig.blockSizeVertical * 8,
                    child: Center(
                      child: Text(
                        'Check',
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )),
            )
          ],
        ),
      );
    }

    var percent = conversationIndex * 0.1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: BlocProvider(
          create: (context) => LearnConversationCubit(conversations.length)
            ..learnSpeaking(conversationIndex),
          child: Scaffold(
            backgroundColor: Color.fromRGBO(255, 239, 204, 100),
            body: BlocBuilder<LearnConversationCubit, LearnConversationState>(
              builder: (context, state) {
                if (state is LearnConversationSpeaking) {
                  conversationIndex = conversationIndex;
                  return Container(
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
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.volume_up,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  AssetsAudioPlayer.playAndForget(Audio.network(
                                      UrlUtils.editAudioUrl(
                                          conversations[conversationIndex]
                                              .voiceLink)));
                                },
                              ),
                            ),
                            FittedBox(
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 80,
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  conversations[conversationIndex].conversation,
                                  style: TextStyle(
                                      fontFamily: "Helvetica",
                                      fontSize: 17,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            )
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
                                  offset: Offset(
                                      0, 1), // changes position of shadow
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
                              speakingButton(context);
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
                  );
                } else if (state is LearnConversationPuzzle) {
                  conversationIndex = state.conversationsIndex;
                  vietnamese = conversations[conversationIndex].conversation;
                  english = conversations[conversationIndex].description;
                  var percent =
                      conversationIndex * (1 / (conversations.length + 1));
                  if (chars.isEmpty == true) {
                    chars = vietnamese.split(' ').toList();
                    chars.shuffle();
                  } else {
                    elements.clear();
                  }
                  for (String item in chars) {
                    elements.add(_card(item.toUpperCase()));
                  }
                  return Column(
                    children: [
                      _percentBar(percent),
                      _matchingConversation(context)
                    ],
                  );
                } else {
                  return ConversationResult(
                    words: conversationIndex,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
