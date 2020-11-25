
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

class WritingVocabulary extends StatelessWidget{
  String vietnamese;
  String english;
  String input;
  String audioInput;
  Function checkWriting;
  BuildContext vocabularyContext;
  TextEditingController txtInputVocabulary;

  WritingVocabulary({this.vietnamese, this.english, this.checkWriting, this.vocabularyContext, this.input, this.txtInputVocabulary, this.audioInput});

  Widget _loadDialog(BuildContext dialogContext) {
    // if (input.toLowerCase() == vietnamese.toLowerCase()) {
    //   CoolAlert.show(
    //       context: dialogContext,
    //       type: CoolAlertType.success,
    //       title: "Correct!",
    //       confirmBtnText: 'Continue',
    //       confirmBtnColor: Colors.green,
    //       onConfirmBtnTap: () {
    //         checkWriting(vocabularyContext);
    //       });
    // } else if (input.toLowerCase() != vietnamese.toLowerCase()) {
    //   CoolAlert.show(
    //       context: dialogContext,
    //       type: CoolAlertType.error,
    //       title: "Incorrect!",
    //       text: 'The correct answer is: $vietnamese',
    //       confirmBtnText: 'Try again',
    //       confirmBtnColor: Colors.red,
    //       onConfirmBtnTap: null);
    // }
    if(input.toLowerCase() == vietnamese.toLowerCase()) {
      showDialog(
          context: dialogContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 20,),
                        Text(
                          "Correct!",
                          style: TextStyle(fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica'),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                        Image(
                            width: SizeConfig.blockSizeHorizontal * 10,
                            height: SizeConfig.blockSizeVertical * 8,
                            image: AssetImage('assets/images/happy.png')
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: SizeConfig.blockSizeVertical *
                                  3,),
                              Text('$vietnamese', style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),),
                              SizedBox(height: SizeConfig.blockSizeVertical *
                                  3,),
                              Text('$english', style: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 20),)
                            ],
                          ),
                        )
                    ),
                    InkWell(
                      onTap: () {
                        checkWriting(vocabularyContext);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }else if(input.toLowerCase() != vietnamese.toLowerCase()){
      showDialog(
          context: dialogContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 20,),
                        Text(
                          "Incorrect!",
                          style: TextStyle(fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica'),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                        Image(
                            width: SizeConfig.blockSizeHorizontal * 10,
                            height: SizeConfig.blockSizeVertical * 8,
                            image: AssetImage('assets/images/sad.png')
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: SizeConfig.blockSizeVertical *
                                  3,),
                              Text('Correct solution:', style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 20),),
                              Text('$vietnamese', style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),),
                              SizedBox(height: SizeConfig.blockSizeVertical *
                                  2,),
                              Text('$english', style: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 20),)
                            ],
                          ),
                        )
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Try Again",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }


  @override
  Widget build(BuildContext context) {
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
              Text(
                'Type what you have listen',
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
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
                        CupertinoIcons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  AssetsAudioPlayer.playAndForget(Audio.network(UrlUtils.editAudioUrl(audioInput)));
                },
              ),
              Text(
                'Tap to listen',
                style: TextStyle(fontSize: 12, fontFamily: 'Helvetica'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 15,
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: txtInputVocabulary,
                  decoration: InputDecoration(
                      hintText: 'Type Vietnamese Meaning',
                      hintStyle:
                      TextStyle(fontFamily: 'Helvetica', fontSize: 17),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent),
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 26.5),
              ButtonTheme(
                buttonColor: Color.fromRGBO(255, 190, 51, 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: RaisedButton(
                    onPressed: () {
                      input = txtInputVocabulary.text;
                      _loadDialog(context);
                    },
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      height: SizeConfig.blockSizeVertical * 8,

                      child: Center(
                        child: Text(
                          'Check',
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
      ),
    );
  }

}