import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/home_screen.dart';

class LevelScreen extends StatefulWidget {
  LevelScreen({Key key}) : super(key: key);

  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 30,
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () => pushNewScreen(
                      context,
                      screen: HomeScreen(),
                      withNavBar: true,
                ),
                child: Column(
                  children: <Widget>[
                    Text("Beginner")
                  ],
                )
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
                child: Column(
                  children: <Widget>[
                    Text("Intermediate")
                  ],
                )
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
                child: Column(
                  children: <Widget>[
                    Text("Advanced")
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
