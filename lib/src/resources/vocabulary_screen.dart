import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reorderables/reorderables.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/learn_vocabulary_cubit.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/states/learn_vocabulary_state.dart';
import 'package:vietnamese_learning/src/widgets/flash_card.dart';
import 'package:vietnamese_learning/src/widgets/speaking_vocabulary.dart';
import 'package:vietnamese_learning/src/widgets/vocabulary_result.dart';
import 'package:vietnamese_learning/src/widgets/writing_vocabulary.dart';

class VocabularyScreen extends StatefulWidget {
  List<Vocabulary> vocabularies;

  VocabularyScreen({Key key, this.vocabularies}) : super(key: key);

  _VocabularyScreenState createState() =>
      _VocabularyScreenState(vocabularies: vocabularies);
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  List<Vocabulary> vocabularies;

  _VocabularyScreenState({this.vocabularies});

  var _vocabularyIndex = 0;
  List<String> chars = new List();
  List<Widget> elements = new List();
  String check;
  String input;
  TextEditingController txtInputVocabulary = new TextEditingController();

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

    void flashCardButton(BuildContext context) {
      BlocProvider.of<LearnVocabularyCubit>(context)
          .learnWriting(_vocabularyIndex);
    }

    void checkWritingButton(BuildContext dialogContext) {
      txtInputVocabulary.clear();
      BlocProvider.of<LearnVocabularyCubit>(dialogContext)
          .learnSpeaking(_vocabularyIndex);
      Navigator.pop(context);
    }

    void speakingButton(BuildContext context) {
      print('speaking');
      BlocProvider.of<LearnVocabularyCubit>(context)
          .learnMatching(_vocabularyIndex);
    }

    Widget _card(String content) {
      return Container(
        width: SizeConfig.blockSizeHorizontal * 10,
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
              BlocProvider.of<LearnVocabularyCubit>(dialogContext)
                  .learnFlashCard(_vocabularyIndex + 1);
              Navigator.pop(context);
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

    Widget _matchingVocabulary(BuildContext context) {
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
              'Correct the vocabulary',
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
              height: SizeConfig.blockSizeVertical * 26.5,
            ),
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: RaisedButton(
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
                } else if (state is LearnVocabularyWriting) {
                  _vocabularyIndex = state.vocabulariesIndex;
                  vietnamese = vocabularies[_vocabularyIndex].vocabulary;
                  english = vocabularies[_vocabularyIndex].description;
                  audio = vocabularies[_vocabularyIndex].voice_link;
                  var percent =
                      _vocabularyIndex * (1 / (vocabularies.length + 1));
                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _percentBar(percent),
                        WritingVocabulary(
                          vietnamese: vietnamese,
                          english: english,
                          vocabularyContext: context,
                          checkWriting: checkWritingButton,
                          input: input,
                          txtInputVocabulary: txtInputVocabulary,
                          audioInput: audio,
                        )
                      ],
                    ),
                  );
                } else if (state is LearnVocabularyPuzzle) {
                  _vocabularyIndex = state.vocabulariesIndex;
                  vietnamese = vocabularies[_vocabularyIndex].vocabulary;
                  english = vocabularies[_vocabularyIndex].description;
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
                      _matchingVocabulary(context)
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
                      )
                    ],
                  );
                } else {
                  return VocabularyResult(
                    words: vocabularies.length,
                  );
                }
              },
            ),
          ),
        )));
  }
}
