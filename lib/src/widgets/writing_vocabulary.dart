
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class WritingVocabulary extends StatelessWidget{
  String vietnamese;
  String english;
  String input;
  Function checkWriting;
  BuildContext vocabularyContext;
  TextEditingController txtInputVocabulary = new TextEditingController();

  WritingVocabulary({this.vietnamese, this.english, this.checkWriting, this.vocabularyContext});

  Widget _loadDialog(BuildContext dialogContext) {
    if (input.toLowerCase() == vietnamese.toLowerCase()) {
      CoolAlert.show(
          context: dialogContext,
          type: CoolAlertType.success,
          title: "Correct!",
          confirmBtnText: 'Continue',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: () {
            checkWriting(vocabularyContext);
          });
    } else if (input.toLowerCase() != vietnamese.toLowerCase()) {
      CoolAlert.show(
          context: dialogContext,
          type: CoolAlertType.error,
          title: "Incorrect!",
          text: 'The correct answer is: $vietnamese',
          confirmBtnText: 'Try again',
          confirmBtnColor: Colors.red,
          onConfirmBtnTap: null);
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
                'Write Vietnamese meaning',
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Text(
                '$english',
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
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