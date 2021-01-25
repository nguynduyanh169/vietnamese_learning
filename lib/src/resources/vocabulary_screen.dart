import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reorderables/reorderables.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/cubit/learn_vocabulary_cubit.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/states/learn_vocabulary_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';
import 'package:vietnamese_learning/src/widgets/flash_card.dart';
import 'package:vietnamese_learning/src/widgets/speaking_vocabulary.dart';
import 'package:vietnamese_learning/src/widgets/vocabulary_result.dart';

class VocabularyScreen extends StatefulWidget {
  List<Vocabulary> vocabularies;
  String lessonID;

  VocabularyScreen({Key key, this.vocabularies, this.lessonID}) : super(key: key);

  _VocabularyScreenState createState() =>
      _VocabularyScreenState(vocabularies: vocabularies, lessonID: lessonID);
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  List<Vocabulary> vocabularies;
  String lessonID;

  _VocabularyScreenState({this.vocabularies, this.lessonID});

  var _vocabularyIndex = 0;
  List<String> chars = new List();
  List<Widget> elements = new List();
  String check;
  String input;
  TextEditingController txtInputVocabulary = new TextEditingController();
  double finalMark = 0;
  double markForAnswer;
  HiveUtils _hiveUtils = new HiveUtils();

  @override
  void initState() {
    markForAnswer = 10 / (vocabularies.length * 2);
    super.initState();
  }

  void caculateMark(double answerMark){
    finalMark = finalMark + answerMark;
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String vietnamese;
    String english;
    String img;
    String audio;

    Widget _percentBar(var percent) {
      return Container(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 1),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                  new CupertinoAlertDialog(
                    title: new Text(
                      "Confirm exit",
                      style: TextStyle(fontFamily: 'Helvetica'),
                    ),
                    content: new Text(
                      "Do you want to exit?",
                      style: TextStyle(fontFamily: 'Helvetica'),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              fontFamily: 'Helvetica'),
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'yes');
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontFamily: 'Helvetica'),
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'no');
                        },
                      ),
                    ],
                  ),
                ).then((value) {
                  if (value == 'yes') {
                    Navigator.of(context).pop();
                  }
                });
              }
                  //Navigator.of(context, rootNavigator: true).pop(context),
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

    void flashCardButton(BuildContext context) {
      BlocProvider.of<LearnVocabularyCubit>(context)
          .learnSpeaking(_vocabularyIndex);
    }

    void speakingButton(BuildContext context) {
      BlocProvider.of<LearnVocabularyCubit>(context)
          .learnMatching(_vocabularyIndex);
    }

    Widget _card(String content) {
      return Container(
        width: SizeConfig.blockSizeHorizontal * 10,
        height: SizeConfig.blockSizeVertical * 6,
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

    void _loadDialogForMatching(BuildContext dialogContext) {
      if(check.toLowerCase() == vietnamese.toLowerCase()){
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
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 20,),
                          Text(
                            "Correct!",
                            style: TextStyle(fontSize: 30.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica'),
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                          Image(
                              width: SizeConfig.blockSizeHorizontal * 10,
                              height: SizeConfig.blockSizeVertical * 8,
                              image: AssetImage('assets/images/happy.png')
                          ),
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
                                SizedBox(height: SizeConfig.blockSizeVertical *
                                    3,),
                                Text('$vietnamese', style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 25),),
                                SizedBox(height: SizeConfig.blockSizeVertical *
                                    3,),
                                Text('$english', style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Helvetica', fontSize: 20),)
                              ],
                            ),
                          )
                      ),
                      InkWell(
                        onTap: () {
                          print(markForAnswer);
                                  caculateMark(markForAnswer);
                                  chars.clear();
                                  elements.clear();
                                  BlocProvider.of<LearnVocabularyCubit>(dialogContext)
                                      .learnFlashCard(_vocabularyIndex + 1);
                                  Navigator.pop(context);
                                  print('final mark ' +  finalMark.toString());
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
      }
      else if(check.toLowerCase() != vietnamese.toLowerCase()){
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
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 20,),
                          Text(
                            "Incorrect!",
                            style: TextStyle(fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontFamily: 'Helvetica'),
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                          Image(
                              width: SizeConfig.blockSizeHorizontal * 10,
                              height: SizeConfig.blockSizeVertical * 8,
                              image: AssetImage('assets/images/sad.png')
                          ),
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
                                SizedBox(height: SizeConfig.blockSizeVertical *
                                    3,),
                                Text('Correct solution:', style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 20),),
                                Text('$vietnamese', style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),),
                                SizedBox(height: SizeConfig.blockSizeVertical *
                                    2,),
                                Text('$english', style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Helvetica', fontSize: 20),)
                              ],
                            ),
                          )
                      ),
                      InkWell(
                        onTap: () {
                          chars.clear();
                          elements.clear();
                          BlocProvider.of<LearnVocabularyCubit>(dialogContext)
                              .learnFlashCard(_vocabularyIndex + 1);
                          Navigator.pop(context);
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
      }
    }

    Widget _matchingVocabulary(BuildContext context, String audioInput) {
      HiveUtils _hiveUtils = new HiveUtils();
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
              'Listen and arrange the vocabulary',
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            FlatButton(
              onPressed: () async{
                print('audio' + audio);
                AssetsAudioPlayer.playAndForget(Audio.file(_hiveUtils.getFile(boxName: HiveBoxName.CACHE_FILE_BOX, url: audioInput)));
              },
              color: Colors.amberAccent,
              textColor: Colors.white,
              child: Icon(
                CupertinoIcons.volume_up,
                size: 24,
              ),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            ),
            Text(
              'Tap to listen',
              style: TextStyle(fontSize: 12, fontFamily: 'Helvetica'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            column,
            SizedBox(
              height: SizeConfig.blockSizeVertical * 30,
            ),
            ButtonTheme(
              buttonColor: Color.fromRGBO(255, 190, 51, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: FlatButton(
                color: Color.fromRGBO(255, 190, 51, 30),
                  onPressed: () {
                    check = chars.join('');
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
        resizeToAvoidBottomInset: false,
        body: Container(
            child: BlocProvider(
          create: (context) => LearnVocabularyCubit(vocabularies.length)
            ..learnFlashCard(_vocabularyIndex),
          child: Scaffold(
            backgroundColor: Color.fromRGBO(255, 239, 204, 100),
            body: BlocBuilder<LearnVocabularyCubit, LearnVocabularyState>(
              builder: (context, state) {
                if (state is LearnVocabularyFlashCard) {
                  _vocabularyIndex = state.vocabulariesIndex;
                  vietnamese = vocabularies[_vocabularyIndex].vocabulary;
                  english = vocabularies[_vocabularyIndex].description;
                  img = vocabularies[_vocabularyIndex].image;
                  audio = vocabularies[_vocabularyIndex].voice_link;
                  var percent =
                      _vocabularyIndex * (1 / (vocabularies.length + 1));
                  return Column(
                    children: [
                      _percentBar(percent),
                      FlashCard(
                        vietnamese: vietnamese,
                        english: english,
                        audio: audio,
                        img: img,
                        continueButton: flashCardButton,
                        vocabularyContext: context,
                      )
                    ],
                  );
                } else if (state is LearnVocabularyPuzzle) {
                  _vocabularyIndex = state.vocabulariesIndex;
                  vietnamese = vocabularies[_vocabularyIndex].vocabulary;
                  english = vocabularies[_vocabularyIndex].description;
                  audio = vocabularies[_vocabularyIndex].voice_link;
                  var percent =
                      _vocabularyIndex * (1 / (vocabularies.length + 1));
                  if (chars.isEmpty == true) {
                    chars = vietnamese.split('').toList();
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
                      _matchingVocabulary(context, audio)
                    ],
                  );
                } else if (state is LearnVocabularySpeaking) {
                  _vocabularyIndex = state.vocabulariesIndex;
                  vietnamese = vocabularies[_vocabularyIndex].vocabulary;
                  english = vocabularies[_vocabularyIndex].description;
                  audio = vocabularies[_vocabularyIndex].voice_link;
                  var percent =
                      _vocabularyIndex * (1 / (vocabularies.length + 1));
                  return Column(
                    children: <Widget>[
                      _percentBar(percent),
                      SpeakingVocabulary(
                        vietnamese: vietnamese,
                        english: english,
                        next: speakingButton,
                        audioInput: audio,
                        vocabularyContext: context,
                        caculateMark: caculateMark,
                        answerMark: markForAnswer,
                      )
                    ],
                  );
                } else {
                  SaveProgressLocal updateProgress = _hiveUtils.getLocalProgress(boxName: HiveBoxName.PROGRESS_BOX, lessonId: lessonID);
                  updateProgress.vocabProgress = finalMark;
                  DateTime now = DateTime.now();
                  DateTime currentDate = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
                  updateProgress.updateTime = currentDate.toLocal();
                  _hiveUtils.updateLocalProgress(progressLocal: updateProgress, boxName: HiveBoxName.PROGRESS_BOX);
                  return VocabularyResult(
                    words: vocabularies.length,
                    finalMark: finalMark,
                  );
                }
              },
            ),
          ),
        )));
  }
}
