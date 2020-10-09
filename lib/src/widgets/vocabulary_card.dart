import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class VocabularyCard extends StatelessWidget {
  final String english;
  final String vietnamese;
  final Function nextHandler;

  VocabularyCard({this.english, this.vietnamese, this.nextHandler});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 80,
          height: SizeConfig.blockSizeVertical * 50,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$english',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  '$vietnamese',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Image(
                    width: 50,
                    height: 50,
                    image: AssetImage('assets/images/logolearning.png')),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(Icons.volume_up),
                )
              ],
            ),
          ),
        ),
        MaterialButton(
          onPressed: nextHandler,
          shape: CircleBorder(side: BorderSide.none),
          child: Icon(Icons.arrow_forward),
        )
      ],
    );
  }
}
