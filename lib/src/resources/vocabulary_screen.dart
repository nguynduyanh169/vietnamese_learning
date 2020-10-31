import 'package:cool_alert/cool_alert.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reorderables/reorderables.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/learn_vocabulary_cubit.dart';
import 'package:vietnamese_learning/src/states/learn_vocabulary_state.dart';

class VocabularyScreen extends StatefulWidget {
  VocabularyScreen({Key key}) : super(key: key);

  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  var _vocabularyIndex = 0;
  List<String> chars = new List();
  List<Widget> elements = [];
  TextEditingController txtInputVocabulary = new TextEditingController();
  String input = '';
  String check = '';
  final _vocabularies = const [
    {
      'english': 'Bird',
      'vietnamese': 'Con chim',
      'img': 'assets/images/demovocab/bird.png'
    },
    {
      'english': 'Chicken',
      'vietnamese': 'Con gà',
      'img': 'assets/images/demovocab/chicken.png'
    },
    {
      'english': 'Phone',
      'vietnamese': 'Cái điện thoại',
      'img': 'assets/images/demovocab/phone.png'
    },
    {
      'english': 'Dog',
      'vietnamese': 'Con chó',
      'img': 'assets/images/demovocab/dog.png'
    },
    {
      'english': 'Mouse',
      'vietnamese': 'Con chuột',
      'img': 'assets/images/demovocab/mouse.png'
    },
    {
      'english': 'Car',
      'vietnamese': 'Xe hơi',
      'img': 'assets/images/demovocab/car.png'
    },
    {
      'english': 'Wind',
      'vietnamese': 'Gió',
      'img': 'assets/images/demovocab/bird.png'
    },
    {
      'english': 'Alcohol',
      'vietnamese': 'Rượu',
      'img': 'assets/images/demovocab/dog.png'
    },
    {
      'english': 'Bike',
      'vietnamese': 'Xe đạp',
      'img': 'assets/images/demovocab/bike.png'
    },
    {
      'english': 'Tree',
      'vietnamese': 'Cái cây',
      'img': 'assets/images/demovocab/tree.png'
    },
    {
      'english': 'TV',
      'vietnamese': 'Cái ti vi',
      'img': 'assets/images/demovocab/bird.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    String vietnamese;
    String english;
    String img;

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

    Widget _flashCard(BuildContext context) {
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlipCard(
                    front: Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        height: SizeConfig.blockSizeVertical * 58,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 4,
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 40,
                                height: SizeConfig.blockSizeVertical * 30,
                                child: Image.asset('$img'),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 4,
                              ),
                              Text(
                                '$vietnamese',
                                style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(fontSize: 25)),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: ClipOval(
                                      child: Container(
                                        color: Colors.amberAccent,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 18,
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Center(
                                          child: Icon(
                                            Icons.volume_up,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print('Sound');
                                    },
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                  ),
                                  InkWell(
                                    child: ClipOval(
                                      child: Container(
                                        color: Colors.amberAccent,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 18,
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Center(
                                          child: Icon(
                                            Icons.mic,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print('Micro');
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    back: Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        height: SizeConfig.blockSizeVertical * 58,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 10,
                              ),
                              Container(
                                child: Text('$vietnamese',
                                    style: TextStyle(
                                        fontFamily: 'Helvetica', fontSize: 30)),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              ),
                              Text(
                                '$english (n)',
                                style: TextStyle(
                                    fontFamily: 'Helvetica', fontSize: 25),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: ClipOval(
                                      child: Container(
                                        color: Colors.amberAccent,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 18,
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Center(
                                          child: Icon(
                                            Icons.volume_up,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print('sound');
                                    },
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                  ),
                                  InkWell(
                                    child: ClipOval(
                                      child: Container(
                                        color: Colors.amberAccent,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 18,
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Center(
                                          child: Icon(
                                            Icons.mic,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print('Micro');
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    direction: FlipDirection.HORIZONTAL,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Text(
                    'Touch to flip card',
                    style:
                        GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 24)),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: RaisedButton(
                        onPressed: () {
                          BlocProvider.of<LearnVocabularyCubit>(context)
                              .learnWriting(_vocabularyIndex);
                        },
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 70,
                          height: SizeConfig.blockSizeVertical * 8,
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  )
                ],
              )
            ],
          ));
    }

    Widget _card(String content) {
      return Container(
        width: 30,
        height: 30,
        child: Center(
          child: Text(
            '$content',
            style: TextStyle(fontFamily: 'Helvetica'),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.amber,
            width: 1,
          ),
        ),
      );
    }

    void _onReorder(int oldIndex, int newIndex) {
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
        padding: const EdgeInsets.all(8),
        children: elements,
        onReorder: _onReorder,
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

    Widget _result() {
      return Container(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Congratulation',
                  style: GoogleFonts.dmSans(fontSize: 40),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  'You has completed flashcard part of Vocabulary',
                  style: GoogleFonts.dmSans(fontSize: 15),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 4,
                ),
                Image(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 30,
                  image: AssetImage('assets/images/vocabulary_logo.png'),
                ),
                MaterialButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(context),
                  child: Text(
                    "Back to Lesson Introduction",
                    style: GoogleFonts.dmSans(
                        fontSize: 20, color: Colors.blueAccent),
                  ),
                )
              ],
            ),
          ));
    }

    Widget _loadDialog(BuildContext dialogContext) {
      if (input.toLowerCase() == vietnamese.toLowerCase()) {
        CoolAlert.show(
            context: dialogContext,
            type: CoolAlertType.success,
            title: "Correct!",
            confirmBtnText: 'Continue',
            confirmBtnColor: Colors.green,
            onConfirmBtnTap: () {
              print(_vocabularyIndex);
              BlocProvider.of<LearnVocabularyCubit>(dialogContext)
                  .learnMatching(_vocabularyIndex);
              Navigator.pop(context);
            });
      } else if (input.toLowerCase() != vietnamese.toLowerCase()) {
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
              'Match Vietnamese meaning',
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

    Widget _writingVocabulary(BuildContext context) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Write Vietnamese meaning',
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
                Container(
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: TextField(
                    controller: txtInputVocabulary,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amberAccent)),
                        hintText: 'Type Vietnamese Meaning',
                        hintStyle:
                            TextStyle(fontFamily: 'Helvetica', fontSize: 17),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 26.5),
                ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: RaisedButton(
                      onPressed: () {
                        input = txtInputVocabulary.text;
                        _loadDialog(context);
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
            )
          ],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
              child: BlocProvider(
        create: (context) =>
            LearnVocabularyCubit()..learnFlashCard(_vocabularyIndex),
        child: Scaffold(
          body: BlocBuilder<LearnVocabularyCubit, LearnVocabularyState>(
            builder: (context, state) {
              if (state is LearnVocabularyFlashCard) {
                _vocabularyIndex = state.vocabulariesIndex;
                vietnamese = _vocabularies[_vocabularyIndex]['vietnamese'];
                english = _vocabularies[_vocabularyIndex]['english'];
                img = _vocabularies[_vocabularyIndex]['img'];
                var percent = _vocabularyIndex * 0.1;
                return Column(
                  children: [_percentBar(percent), _flashCard(context)],
                );
              } else if (state is LearnVocabularyWriting) {
                txtInputVocabulary.clear();
                _vocabularyIndex = state.vocabulariesIndex;
                vietnamese = _vocabularies[_vocabularyIndex]['vietnamese'];
                english = _vocabularies[_vocabularyIndex]['english'];
                var percent = _vocabularyIndex * 0.1;
                return Column(
                  children: [_percentBar(percent), _writingVocabulary(context)],
                );
              } else if (state is LearnVocabularyPuzzle) {
                _vocabularyIndex = state.vocabulariesIndex;
                print('$_vocabularyIndex');
                vietnamese = _vocabularies[_vocabularyIndex]['vietnamese'];
                english = _vocabularies[_vocabularyIndex]['english'];
                var percent = _vocabularyIndex * 0.1;
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
                  children: [_percentBar(percent), _matchingVocabulary(context)],
                );
              } else {
                return _result();
              }
            },
          ),
        ),
      ))),
    );
  }
}
