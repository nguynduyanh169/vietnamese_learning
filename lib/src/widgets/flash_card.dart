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
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5),
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 83,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 69,
                  child: FlipCard(
                  front: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, left: SizeConfig.blockSizeHorizontal * 5),
                          width: SizeConfig.blockSizeHorizontal * 85,
                          height: SizeConfig.blockSizeVertical * 59,
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
                                  '$english',
                                  style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(fontSize: 25)),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2,
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        left: SizeConfig.blockSizeHorizontal * 37,
                        top: SizeConfig.blockSizeVertical * 53,
                        child: InkWell(
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
                      )
                    ],
                  ),
                  back: Stack(children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, left: SizeConfig.blockSizeHorizontal * 5),
                        width: SizeConfig.blockSizeHorizontal * 85,
                        height: SizeConfig.blockSizeVertical * 59,
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
                            ],
                          ),
                        )),
                    Positioned(
                      left: SizeConfig.blockSizeHorizontal * 37,
                      top: SizeConfig.blockSizeVertical * 53,
                      child: InkWell(
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
                    )
                  ],),
                  direction: FlipDirection.HORIZONTAL,
                ),),
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