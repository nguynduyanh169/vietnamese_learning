import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

class QuizQuestion extends StatelessWidget {
  final String questionText;
  final int questionType;
  HiveUtils _hiveUtils = new HiveUtils();
  QuizQuestion({this.questionText, this.questionType});

  Widget questionWidget(){
    if(questionType == 1){
      return Container(
        width: SizeConfig.blockSizeHorizontal * 75,
        height: SizeConfig.blockSizeVertical * 30,
        child: Column(
          children: <Widget>[
            Text(
              'Which one of these is “$questionText”?',
              style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
              textAlign: TextAlign.center,
            ),
          ],
        )
      );
    }else if(questionType == 2){
      return Container(
        width: SizeConfig.blockSizeHorizontal * 75,
        height: SizeConfig.blockSizeVertical * 28,
        child: Column(
          children: [
            FlatButton(
              onPressed: () {
                AssetsAudioPlayer.playAndForget(Audio.file(_hiveUtils.getFile(boxName: HiveBoxName.CACHE_FILE_BOX, url: questionText)));
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
            // InkWell(
            //   // child: ClipOval(
            //   //   child: Container(
            //   //     color: Colors.amberAccent,
            //   //     width:
            //   //     SizeConfig.blockSizeHorizontal * 18,
            //   //     height:
            //   //     SizeConfig.blockSizeVertical * 10,
            //   //     child: Center(
            //   //       child: Icon(
            //   //         CupertinoIcons.volume_up,
            //   //         color: Colors.white,
            //   //       ),
            //   //     ),
            //   //   ),
            //   // ),
            //   child: ,
            //   onTap: () {
            //
            //   },
            // ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Text(
              'Tap to listen',
              style: TextStyle(fontSize: 12, fontFamily: 'Helvetica'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }else if(questionType == 3){
      return Container(
        width: SizeConfig.blockSizeHorizontal * 75,
        height: SizeConfig.blockSizeVertical * 28,
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              width: SizeConfig.blockSizeHorizontal * 35,
              height: SizeConfig.blockSizeVertical * 25,
              child: Image(
                image: FileImage(File(
                    _hiveUtils.getFile(
                        boxName: HiveBoxName.CACHE_FILE_BOX,
                        url: questionText))),
              ),
            )
          ],
        )
      );
    }else if(questionType == 5){
      return Container(
          width: SizeConfig.blockSizeHorizontal * 75,
          height: SizeConfig.blockSizeVertical * 30,
          child: Column(
            children: <Widget>[
              Text(
                '$questionText',
                style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                textAlign: TextAlign.center,
              ),
            ],
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: questionWidget()
    );
  }
}
