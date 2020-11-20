import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';
import 'package:vietnamese_learning/src/resources/view_post2.dart';

class ForumTab2 extends StatefulWidget{
  ForumTab2({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForumTab2State();
  }
}

class _ForumTab2State extends State<ForumTab2>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                          'những câu nói hay về cuộc sống',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Helvetica'),
                        ),
                        onTap: () => pushNewScreen(context,
                            screen: ViewPost2(),
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
                                'haihl',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Helvetica'),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1,
                              ),
                              Text(
                                '20/11/2020 at 3:15pm',
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
                        '1. Thế giới bạn không bước vào được thì đừng cố chen vào, làm khó người khác, lỡ dở mình, hà tất chứ?...',
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