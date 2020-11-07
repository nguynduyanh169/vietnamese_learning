import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';

class ForumTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForumTabState();
  }
}

class ForumTabState extends State<ForumTab> {
  @override
  Widget build(Object context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  InkWell(
                    child: Text(
                      'Phan nan ve dich vu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Helvetica'),
                    ),
                    onTap: () => pushNewScreen(context,
                        screen: ViewPost(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
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
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            '20/11/2020',
                            style: TextStyle(
                                fontSize: 10, fontFamily: 'Helvetica'),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Text(
                    'Circle or Circular images always look cool. Really, like we are'
                    ' used to seeing them almost everywhere, and as I could not '
                    'find any simple example code for doing this...',
                    style: TextStyle(fontFamily: 'Helvetica'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.heart,
                          ),
                          onPressed: null),
                      Text(
                        '10',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.conversation_bubble,
                          ),
                          onPressed: null),
                      Text(
                        '20',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Text(
                    'Phan nan ve dich vu',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Helvetica'),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
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
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            '20/11/2020',
                            style: TextStyle(
                                fontSize: 10, fontFamily: 'Helvetica'),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Text(
                    'Circle or Circular images always look cool. Really, like we are'
                    ' used to seeing them almost everywhere, and as I could not '
                    'find any simple example code for doing this...',
                    style: TextStyle(fontFamily: 'Helvetica'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.heart,
                          ),
                          onPressed: null),
                      Text(
                        '10',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.conversation_bubble,
                          ),
                          onPressed: null),
                      Text(
                        '20',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Text(
                    'Phan nan ve dich vu',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Helvetica'),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
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
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            '20/11/2020',
                            style: TextStyle(
                                fontSize: 10, fontFamily: 'Helvetica'),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Text(
                    'Circle or Circular images always look cool. Really, like we are'
                    ' used to seeing them almost everywhere, and as I could not '
                    'find any simple example code for doing this...',
                    style: TextStyle(fontFamily: 'Helvetica'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.heart,
                          ),
                          onPressed: null),
                      Text(
                        '10',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.conversation_bubble,
                          ),
                          onPressed: null),
                      Text(
                        '20',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Text(
                    'Phan nan ve dich vu',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Helvetica'),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
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
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            '20/11/2020',
                            style: TextStyle(
                                fontSize: 10, fontFamily: 'Helvetica'),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Text(
                    'Circle or Circular images always look cool. Really, like we are'
                    ' used to seeing them almost everywhere, and as I could not '
                    'find any simple example code for doing this...',
                    style: TextStyle(fontFamily: 'Helvetica'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.heart,
                          ),
                          onPressed: null),
                      Text(
                        '10',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.conversation_bubble,
                          ),
                          onPressed: null),
                      Text(
                        '20',
                        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}
