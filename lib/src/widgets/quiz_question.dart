import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

class QuizQuestion extends StatelessWidget {
  final String questionText;
  final int questionType;
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
                      CupertinoIcons.volume_up,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () {
                AssetsAudioPlayer.playAndForget(Audio.network(UrlUtils.editAudioUrl(questionText)));
              },
            ),
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
                  image: NetworkImage(UrlUtils.editImgUrl(questionText))
              ),
            )
          ],
        )
      );
    }else if(questionType == 4){
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
