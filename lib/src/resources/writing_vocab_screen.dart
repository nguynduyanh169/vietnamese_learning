import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class WritingVocabScreen extends StatefulWidget {
  WritingVocabScreen({Key key}) : super(key: key);

  _WritingVocabScreenState createState() => _WritingVocabScreenState();
}

class _WritingVocabScreenState extends State<WritingVocabScreen> {
  var _vocabularyIndex = 0;
  bool check = false;
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
    print('VocabularyIndex:$_vocabularyIndex');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    var percent = _vocabularyIndex * 0.1;
    String vietnamese = _vocabularies[_vocabularyIndex]['vietnamese'];
    String english = _vocabularies[_vocabularyIndex]['english'];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
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
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                  Text(
                    'Write Vietnamese meaning',
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Text(
                    '$english',
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 15,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Type Vietnamese Meaning',
                          hintStyle: GoogleFonts.dmSans(
                              textStyle: TextStyle(fontSize: 16)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 20),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: RaisedButton(
                        onPressed: () {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            title: "Correct!",
                            onConfirmBtnTap: nextQuestion
                          );
                        },
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 70,
                          height: SizeConfig.blockSizeVertical * 8,
                          child: Center(
                            child: Text(
                              'Check',
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
          ),
        ),
      ),
    );
  }
}
