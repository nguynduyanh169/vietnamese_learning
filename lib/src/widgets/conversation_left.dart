import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';
import 'package:vietnamese_learning/src/widgets/conversation_speaking.dart';

class ConversationLeft extends StatelessWidget {
  String english, vietnamese, voiceLink;
  ConversationLeft({this.english, this.vietnamese, this.voiceLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 30,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print('$voiceLink');
              AssetsAudioPlayer.playAndForget(
                  Audio.network(UrlUtils.editAudioUrl(voiceLink)));
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 190, 51, 5),
              ),
              child: IconButton(
                icon: Icon(Icons.volume_up, color: Colors.white),
                onPressed: null,
              ),
              width: SizeConfig.blockSizeHorizontal * 10,
              margin: const EdgeInsets.all(8),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 80,
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
        ],
      ),
    );
  }
}
