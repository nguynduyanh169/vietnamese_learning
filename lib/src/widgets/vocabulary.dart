import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/widgets/vocabulary_card.dart';

class Vocabulary extends StatelessWidget {
  final List<Map<String, Object>> vocabularies;
  final int vocabularyIndex;
  final Function nextHandler;

  Vocabulary({this.vocabularies, this.nextHandler, this.vocabularyIndex});

  @override
  Widget build(BuildContext context) {
    var percentStr = vocabularyIndex * 10.0;
    var percent = vocabularyIndex * 0.1;
    SizeConfig().init(context);
    // TODO: implement build
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
            Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.clear), onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),),
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
            VocabularyCard(
              english: vocabularies[vocabularyIndex]['english'],
              vietnamese: vocabularies[vocabularyIndex]['vietnamese'],
              img: vocabularies[vocabularyIndex]['img'],
              nextHandler: nextHandler,
            )
          ],
        ));
  }
}
