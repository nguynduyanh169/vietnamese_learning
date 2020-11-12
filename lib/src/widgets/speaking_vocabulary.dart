
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class SpeakingVocabulary extends StatelessWidget{
  String vietnamese;
  String english;
  String audioInput;
  Function next;
  BuildContext vocabularyContext;

  SpeakingVocabulary({this.english, this.vietnamese, this.audioInput, this.next, this.vocabularyContext});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Color.fromRGBO(255, 239, 215, 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "Speak this conversation",
              style: TextStyle(
                  fontFamily: "Helvetica",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 14,
              ),
              Container(
                width: 45,
                height: 45,
                margin: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Color.fromRGBO(255, 190, 51, 100),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(255, 190, 51, 100),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset:
                      Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  vietnamese,
                  style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 17,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 8,
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Color.fromRGBO(255, 190, 51, 100),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(255, 190, 51, 100)
                        .withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: IconButton(
                iconSize: 100,
                icon: Icon(
                  CupertinoIcons.mic_solid,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 8,
          ),
          Center(
            child: InkWell(
              onTap: (){
                next(vocabularyContext);
              },
              child: Container(
                  width: SizeConfig.blockSizeHorizontal * 80,
                  height: SizeConfig.blockSizeVertical * 9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(255, 190, 51, 30),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: "Helvetica",
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }


}
