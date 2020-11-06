import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:floating_menu/floating_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';

class ForumScreen extends StatefulWidget {
  ForumScreen({Key key}) : super(key: key);

  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 36,
                  ),
                  Text(
                    'Discuss',
                    style: GoogleFonts.sansita(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 24,
                  ),
                  IconButton(
                      icon: Stack(
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.bell_solid,
                            size: 30,
                          ),
                          Positioned(
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: new Text(
                                '10',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Helvetica'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        print('create post');
                      }),
                ],
              ),
            ),
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
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
                              ),
                              IconButton(
                                  icon: Icon(
                                    CupertinoIcons.conversation_bubble,
                                  ),
                                  onPressed: null),
                              Text(
                                '20',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
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
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
                              ),
                              IconButton(
                                  icon: Icon(
                                    CupertinoIcons.conversation_bubble,
                                  ),
                                  onPressed: null),
                              Text(
                                '20',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
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
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
                              ),
                              IconButton(
                                  icon: Icon(
                                    CupertinoIcons.conversation_bubble,
                                  ),
                                  onPressed: null),
                              Text(
                                '20',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
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
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
                              ),
                              IconButton(
                                  icon: Icon(
                                    CupertinoIcons.conversation_bubble,
                                  ),
                                  onPressed: null),
                              Text(
                                '20',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: 'Helvetica'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingMenu(
        isMainButton: true,
        mainButtonColor: Colors.redAccent,
        mainButtonIcon: Icons.menu,
        mainButtonShape: BoxShape.circle,
        floatingType: FloatingType.RightCurve,
        floatingButtonShape: BoxShape.circle,
        floatingButtons: [
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 70,
            shape: BoxShape.circle,
            color: Colors.blueAccent,
            label: "New post",
            icon: CupertinoIcons.create,
            size: Size(45, 45),
            onPress: (){
              print('post');
            }
          ),
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 130,
            shape: BoxShape.circle,
            color: Colors.indigoAccent,
            label: "My posts",
            icon: CupertinoIcons.person,
            size: Size(45, 45),
            onPress: () {
              print("My posts");
            },
          ),
          FloatingButtonModel(
            locationDegree: 270,
            locationDistance: 190,
            shape: BoxShape.circle,
            color: Colors.blueAccent,
            label: "Notification",
            icon: CupertinoIcons.bell_solid,
            size: Size(45, 45),
            onPress: () {
              print("New post");
            },
          ),
        ],
      ),
    );
  }
}
