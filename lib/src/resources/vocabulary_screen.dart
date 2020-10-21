import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class VocabularyScreen extends StatefulWidget {
  VocabularyScreen({Key key}) : super(key: key);

  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  var _vocabularyIndex = 0;
  bool isNew = true;
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

  void nextQuestion() {
    setState(() {
      _vocabularyIndex = _vocabularyIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    var percent = _vocabularyIndex * 0.1;
    String vietnamese = _vocabularies[_vocabularyIndex]['vietnamese'];
    String english = _vocabularies[_vocabularyIndex]['english'];
    String img = _vocabularies[_vocabularyIndex]['img'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        child: _vocabularyIndex < 10
            ? Container(
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
                    Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2),
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
                              width: SizeConfig.blockSizeHorizontal * 75,
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
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 40,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: ClipOval(
                                            child: Container(
                                              color: Colors.amberAccent,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  18,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  30,
                                        ),
                                        InkWell(
                                          child: ClipOval(
                                            child: Container(
                                              color: Colors.amberAccent,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  18,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
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
                                          style: GoogleFonts.dmSans(
                                              textStyle:
                                                  TextStyle(fontSize: 30))),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 5,
                                    ),
                                    Text(
                                      '$english (n)',
                                      style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(fontSize: 25)),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: ClipOval(
                                            child: Container(
                                              color: Colors.amberAccent,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  18,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  30,
                                        ),
                                        InkWell(
                                          child: ClipOval(
                                            child: Container(
                                              color: Colors.amberAccent,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  18,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
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
                          style: GoogleFonts.dmSans(
                              textStyle: TextStyle(fontSize: 24)),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        ButtonTheme(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: RaisedButton(
                              onPressed: nextQuestion,
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 70,
                                height: SizeConfig.blockSizeVertical * 8,
                                child: Center(
                                  child: Text(
                                    'Continue',
                                    style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            fontSize: 25, color: Colors.white)),
                                  ),
                                ),
                              )),
                        )
                      ],
                    )
                  ],
                ))
            : Container(
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Congratulation', style: GoogleFonts.dmSans(fontSize: 40),),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                  Text('You has completed flashcard part of Vocabulary', style: GoogleFonts.dmSans(fontSize: 15),),
                  SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                  Image(width: SizeConfig.blockSizeHorizontal * 40, height: SizeConfig.blockSizeVertical * 30,image: AssetImage('assets/images/vocabulary_logo.png'),),
                  MaterialButton(
                    onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),
                    child: Text("Back to Lesson Introduction", style: GoogleFonts.dmSans(fontSize: 20, color: Colors.blueAccent),),)
                ],
              ),
            )
        ),
      )),
    );
  }
}
