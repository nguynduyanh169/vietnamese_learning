import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

class ConversationRight extends StatelessWidget {
  String english, vietnamese, voiceLink;
  ConversationRight({this.english, this.vietnamese, this.voiceLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 30,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          top: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 80,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "$vietnamese",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Colors.redAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FittedBox(
                child: Container(
                  alignment: Alignment.centerRight,
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: Text(
                    "$english",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 3,
          ),
          InkWell(
            onTap: () {
              AssetsAudioPlayer.playAndForget(
                  Audio.network(UrlUtils.editAudioUrl(voiceLink)));
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 190, 51, 5),
              ),
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.volume_up,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              width: SizeConfig.blockSizeHorizontal * 10,
              margin: const EdgeInsets.all(8),
            ),
          )
        ],
      ),
    );
  }
}
