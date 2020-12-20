import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reorderables/reorderables.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/learn_conversation_cubit.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/resources/conversation_result.dart';
import 'package:vietnamese_learning/src/states/learn_converasation_state.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:google_speech/google_speech.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../config/size_config.dart';
import 'chat_bubble.dart';

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
  bool recognizing = false;
  bool recognizeFinished = false;
  bool checkText = false;
  String text = '';
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool _isRecording = false;
  String path;

  void initState() {
    super.initState();
    _init();
  }

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
                progressColor: Colors.green,
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
        width: SizeConfig.blockSizeHorizontal * 15,
        height: SizeConfig.blockSizeVertical * 7,
        child: Center(
          child: Text(
            '$content',
            style: TextStyle(fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.05),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10)
            ]),
      );
    }

    Widget _loadDialogForMatching(BuildContext dialogContext) {
      if (check.toLowerCase() == vietnamese.toLowerCase()) {
        showDialog(
            context: dialogContext,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 20,
                          ),
                          Text(
                            "Correct!",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica'),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Image(
                              width: SizeConfig.blockSizeHorizontal * 10,
                              height: SizeConfig.blockSizeVertical * 8,
                              image: AssetImage('assets/images/happy.png')),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 3,
                                ),
                                Text(
                                  '$vietnamese',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          chars.clear();
                          elements.clear();
                          BlocProvider.of<LearnConversationCubit>(dialogContext)
                              .learnSpeaking(conversationIndex + 1);
                          Navigator.pop(context);
                          conversationIndex = conversationIndex + 1;
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else if (check.toLowerCase() != vietnamese.toLowerCase()) {
        showDialog(
            context: dialogContext,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 20,
                          ),
                          Text(
                            "Incorrect!",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica'),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Image(
                              width: SizeConfig.blockSizeHorizontal * 10,
                              height: SizeConfig.blockSizeVertical * 8,
                              image: AssetImage('assets/images/sad.png')),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 4.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 3,
                                ),
                                Text(
                                  'Correct solution:',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica', fontSize: 20),
                                ),
                                Text(
                                  '$vietnamese',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 3,
                                ),
                              ],
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0)),
                          ),
                          child: Text(
                            "Try Again",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
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
              'Arrange the sentence',
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              child: Align(
                alignment: Alignment.center,
                //Change this to Alignment.topRight or Alignment.topLeft
                child: CustomPaint(
                  painter: ChatBubble(
                      color: Colors.amber, alignment: Alignment.center),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Stack(
                      children: <Widget>[
                        Text(
                          '$english',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 10,
            ),
            column,
            SizedBox(
              height: SizeConfig.blockSizeVertical * 20,
            ),
            ButtonTheme(
              buttonColor: Color.fromRGBO(255, 190, 51, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: FlatButton(
                color: Color.fromRGBO(255, 190, 51, 30),
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
                  var percent =
                      conversationIndex * (1 / (conversations.length + 1));
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
                              height: SizeConfig.blockSizeVertical * 10,
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
                                      conversations[conversationIndex]
                                          .voiceLink));
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
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        Center(
                          // child: Container(
                          //   width: 200,
                          //   height: 200,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(35),
                          //     color: Color.fromRGBO(255, 190, 51, 100),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Color.fromRGBO(255, 190, 51, 100)
                          //             .withOpacity(0.5),
                          //         spreadRadius: 1,
                          //         blurRadius: 1,
                          //         offset: Offset(
                          //             0, 1), // changes position of shadow
                          //       ),
                          //     ],
                          //   ),
                          //   child: IconButton(
                          //     iconSize: 100,
                          //     icon: Icon(
                          //       CupertinoIcons.mic_solid,
                          //       color: Colors.white,
                          //     ),
                          //     onPressed: null,
                          //   ),
                          // ),
                          child: AvatarGlow(
                            animate: _isRecording,
                            glowColor: Theme.of(context).primaryColor,
                            endRadius: 130.0,
                            duration: const Duration(milliseconds: 2000),
                            repeatPauseDuration:
                                const Duration(milliseconds: 100),
                            repeat: true,
                            child: Container(
                              width: 150,
                              height: 150,
                              child: FloatingActionButton(
                                onPressed: () {
                                  if (_isRecording == false) {
                                    _start();
                                  } else {
                                    _stop();
                                  }
                                },
                                child: Icon(
                                  _isRecording
                                      ? CupertinoIcons.stop
                                      : CupertinoIcons.mic,
                                  size: 100,
                                ),
                                backgroundColor:
                                    Color.fromRGBO(255, 190, 51, 30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Center(
                          // child: Container(
                          //   child: checkText ?
                          //       Container(
                          //         margin: const EdgeInsets.all(2.0),
                          //         decoration: BoxDecoration(
                          //             border: Border.all(
                          //               color: Colors.black,
                          //             ),
                          //             borderRadius: BorderRadius.all(Radius.circular(20.0))
                          //         ),
                          //         child: Padding(padding: const EdgeInsets.all(2.0),
                          //         child: AutoSizeText(
                          //           '$text',
                          //           maxLines: 3,
                          //           overflow: TextOverflow.ellipsis,
                          //           maxFontSize: 20,
                          //           minFontSize: 15,
                          //         ),
                          //         ),
                          //       )
                          //       : Text("$text"),
                          //
                          // ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              if (recognizeFinished)
                                _RecognizeContent(
                                  text: text,
                                ),
                              Center(
                                child: recognizing
                                    ? CircularProgressIndicator()
                                    : Text(""),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        Center(
                          child: ButtonTheme(
                            buttonColor: Color.fromRGBO(255, 190, 51, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: RaisedButton(
                                onPressed: () {
                                  speakingButton(context);
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  height: SizeConfig.blockSizeVertical * 8,
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 20,
                                          color: Colors.white),
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

  void recognize() async {
    setState(() {
      recognizing = true;
    });
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/vietnamese-master-2e898b96ecf0.json'))}');
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();
    final audio = await _getAudioContent(path);
    await speechToText.recognize(config, audio).then((value) {
      setState(() {
        text = value.results
            .map((e) => e.alternatives.first.transcript)
            .join('\n');
      });
    }).whenComplete(() => setState(() {
          recognizeFinished = true;
          recognizing = false;
          _init();
        }));
    if (text.isEmpty) {
      checkText = false;
    } else {
      checkText = true;
    }
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.command_and_search,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'vi-VN');

  Future<void> _copyFileFromAssets(String name) async {
    var data = await rootBundle.load('assets/$name');
    final directory = await getApplicationDocumentsDirectory();
    final pathAudio = directory.path + '/$name';
    await io.File(pathAudio).writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<List<int>> _getAudioContent(String name) async {
    final directory = await getApplicationDocumentsDirectory();
    // final pathAudio = directory.path + '/$name';
    // if (!File(pathAudio).existsSync()) {
    //   await _copyFileFromAssets(name);
    // }
    return io.File(name).readAsBytesSync().toList();
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDicrectory;
        if (io.Platform.isIOS) {
          appDocDicrectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDicrectory = await getExternalStorageDirectory();
        }

        customPath = appDocDicrectory.path +
            customPath +
            DateTime.now().microsecondsSinceEpoch.toString();

        _recorder = FlutterAudioRecorder(customPath,
            audioFormat: AudioFormat.WAV, sampleRate: 16000);

        await _recorder.initialized;

        var current = await _recorder.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        setState(() {
          _isRecording = true;
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    // File file = widget.localFileSystem.file(result.path);
    // print("File length: ${await file.length()}");
    setState(() {
      _isRecording = false;
      path = result.path;
      _current = result;
      _currentStatus = _current.status;
      recognize();
    });
  }
}

class _RecognizeContent extends StatelessWidget {
  final String text;

  const _RecognizeContent({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              'The conversation recognized from your voice',
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AutoSizeText(
                  text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  maxFontSize: 20,
                  minFontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
