import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/view_post2.dart';

class ForumNotificationScreen extends StatefulWidget {
  ForumNotificationScreen({Key key}) : super(key: key);

  _ForumNotificationState createState() => _ForumNotificationState();
}

class _ForumNotificationState extends State<ForumNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 22,
                  ),
                  Text(
                    'Notifications',
                    style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            Expanded(child: ListView(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1.5, right: SizeConfig.blockSizeHorizontal * 1.5),
              children: <Widget>[
                InkWell(child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Xuan Cuong',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ), onTap: (){
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) => ViewPost2(),
                  ));
                },),

                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.3,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, bottom: SizeConfig.blockSizeVertical * 2),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Container(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ho Quang Bao',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Helvetica'),
                          ),
                          Text(
                            'has commented on your post',
                            style: TextStyle(
                                fontFamily: 'Helvetica'),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 11,),
                      Text('2 minutes ago', style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),)
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
