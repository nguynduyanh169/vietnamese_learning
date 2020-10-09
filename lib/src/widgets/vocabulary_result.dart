import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/lesson_detail.dart';

class VocabularyResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Congratulation', style: TextStyle(fontSize: 40),),
              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
              Text('You has completed vocabulary part of Introduction'),
              SizedBox(height: SizeConfig.blockSizeVertical * 4,),
              Image(width: SizeConfig.blockSizeHorizontal * 40, height: SizeConfig.blockSizeVertical * 30,image: AssetImage('assets/images/vocabulary_logo.png'),),
              MaterialButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),
                child: Text("Back to Lesson 1"),)
            ],
          ),
        )
    );
  }

}