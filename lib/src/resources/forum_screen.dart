import 'package:floating_menu/floating_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/forum_notification_screen.dart';
import 'package:vietnamese_learning/src/resources/forum_tab.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';
import 'package:vietnamese_learning/src/widgets/create_post.dart';
import 'package:vietnamese_learning/src/widgets/search.dart';

class ForumScreen extends StatefulWidget {
  ForumScreen({Key key}) : super(key: key);

  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('All Post', style: TextStyle(fontFamily: 'Helvetica'),),
    1: Text('My Post', style: TextStyle(fontFamily: 'Helvetica')),
    2: Text('Follow Post', style: TextStyle(fontFamily: 'Helvetica')),
  };
  final Map<int, Widget> icons = <int, Widget>{
    0: ForumTab(),
    1: null,
    2: null,
  };

  int sharedValue = 0;
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
                    onPressed: () => pushNewScreen(context,
                        screen: ForumNotificationScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 24,
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
                          CupertinoIcons.search,
                          size: 30,
                        ),
                      ],
                    ),
                    onPressed: () => pushNewScreen(context,
                        screen: Search(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            SizedBox(
              width: 500.0,
              child: CupertinoSegmentedControl<int>(
                children: logoWidgets,
                selectedColor: Color.fromRGBO(230, 172, 0, 10),
                borderColor: Color.fromRGBO(102, 77, 0, 100),
                onValueChanged: (int val) {
                  setState(() {
                    sharedValue = val;
                  });
                },
                groupValue: sharedValue,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: icons[sharedValue],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBarModalBottomSheet(
            expand: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context, scrollController) => CreatePost(),
          );
        },
        child: Icon(CupertinoIcons.pen),
      ),
    );
  }
}
