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
      return Text(
        questionText,
        style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
        textAlign: TextAlign.center,
      );
    }else if(questionType == 2){
      return InkWell(
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
      );
    }else if(questionType == 3){
      return Container(
        width: SizeConfig.blockSizeHorizontal * 25,
        height: SizeConfig.blockSizeVertical * 15,
        child: Image(image: NetworkImage(UrlUtils.editImgUrl(questionText))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //width: double.infinity,
        margin: EdgeInsets.all(10),
        child: questionWidget()
    );
  }
}
