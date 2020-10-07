import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

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
              child: ListTile(
                leading: Icon(Icons.book, size: 40.0,),
                title: Text('Beginner', ),
                subtitle: Text('Start from scratch',),
                trailing: Image.asset('assets/images/logolearning.png'),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: Icon(Icons.book, size: 40.0,),
                title: Text('Intermediate'),
                subtitle: Text('Start from scratch'),
                trailing: Image.asset('assets/images/logolearning.png'),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: Icon(Icons.book, size: 40.0,),
                title: Text('Advance'),
                subtitle: Text('Start from scratch'),
                trailing: Image.asset('assets/images/logolearning.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
