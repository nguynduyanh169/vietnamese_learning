import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';
import 'package:vietnamese_learning/src/widgets/conversation_speaking.dart';

class ConversationLeft extends StatelessWidget {
  String english, vietnamese, voiceLink;
  HiveUtils _hiveUtils = new HiveUtils();
  ConversationLeft({this.english, this.vietnamese, this.voiceLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 30,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      //color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              AssetsAudioPlayer.playAndForget(
                  Audio.file(_hiveUtils.getFile(boxName: 'CacheFile', url: voiceLink)));
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 190, 51, 5),
              ),
              child: IconButton(
                icon: Icon(CupertinoIcons.volume_up, color: Colors.white),
                onPressed: null,
              ),
              width: SizeConfig.blockSizeHorizontal * 10,
              margin: const EdgeInsets.all(8),
            ),
          ),
          ChatBubble(
            elevation: 0,
            clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
                bottom: SizeConfig.blockSizeVertical * 2),
            //backGroundColor: Color(0xffE7E7ED),
            backGroundColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
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
                            color: Colors.orange[300],
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
            ),
          ),
        ],
      ),
    );
  }
}
