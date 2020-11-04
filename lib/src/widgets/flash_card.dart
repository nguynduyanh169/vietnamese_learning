import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

class FlashCard extends StatelessWidget{
  String vietnamese;
  String english;
  String img;
  String audio;
  Function continueButton;
  BuildContext vocabularyContext;

  FlashCard({this.vietnamese, this.english, this.audio, this.img, this.continueButton, this.vocabularyContext});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
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
                              child: Image(image: NetworkImage(UrlUtils.editImgUrl(img))),
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
                                          CupertinoIcons.volume_up,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    AssetsAudioPlayer.playAndForget(Audio.network(UrlUtils.editAudioUrl(audio)));
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
                                          CupertinoIcons.mic,
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
                              '$english',
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
                                          CupertinoIcons.volume_up,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    AssetsAudioPlayer.playAndForget(Audio.network(UrlUtils.editAudioUrl(audio)));
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
                                          CupertinoIcons.mic,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('mic');
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
                  style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: RaisedButton(
                      onPressed: (){
                        continueButton(vocabularyContext);
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

}