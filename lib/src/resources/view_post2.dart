
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

import 'edit_post_screen.dart';

class ViewPost2 extends StatefulWidget {
  ViewPost2({Key key}) : super(key: key);

  _ViewPost2State createState() => _ViewPost2State();
}

class _ViewPost2State extends State<ViewPost2> {
  //ChewieController _chewieController;

  @override
  void initState() {
    // _chewieController = ChewieController(
    //     videoPlayerController: VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/audio_for_user_post%2Fv07025570000bud8udh5pij7j9uaub80.MP4_2020-11-15%2015%3A16%3A42.109630?alt=media&token=ae7f1ab8-4c16-4c71-80df-f43c6890891d'),
    //     autoInitialize: true,
    //     autoPlay: false,
    //     looping: true,
    //     aspectRatio: 16/9
    // );
    super.initState();
  }

  @override
  void dispose() {
    // _chewieController.videoPlayerController.dispose();
    // _chewieController.dispose();
    super.dispose();
  }
  void _showListActionForComment(BuildContext fatherContext){
    showCupertinoModalPopup(
        context: fatherContext,
        builder: (BuildContext buildContext) {
          return CupertinoActionSheet(
            title: Text('Choose option for this comment', style: TextStyle(fontFamily: 'Helvetica'),),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('Copy', style: TextStyle(fontFamily: 'Helvetica'),),
                onPressed: () {
                  Navigator.of(fatherContext).pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Text('Delete', style: TextStyle(fontFamily: 'Helvetica', color: Colors.red)),
                onPressed: () {
                  showDialog(
                    useRootNavigator: true,
                    context: fatherContext,
                    builder: (BuildContext context) => new CupertinoAlertDialog(
                      title: new Text("Confirm delete",style: TextStyle(fontFamily: 'Helvetica'),),
                      content: new Text("Do you want to delete this comment?", style: TextStyle(fontFamily: 'Helvetica'),),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('Confirm', style: TextStyle(fontFamily: 'Helvetica'),),
                          onPressed: () {
                            Navigator.of(fatherContext).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('Cancel',style: TextStyle(fontFamily: 'Helvetica'),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ).then((value) {
                    Navigator.of(fatherContext).pop();
                  });
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Text('Cancel',style: TextStyle(fontFamily: 'Helvetica')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }

  void _showListActionForOtherComment(BuildContext fatherContext) {
    showCupertinoModalPopup(
        context: fatherContext,
        builder: (BuildContext buildContext) {
          return CupertinoActionSheet(
            title: Text('Choose option for this comment', style: TextStyle(fontFamily: 'Helvetica'),),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('Copy', style: TextStyle(fontFamily: 'Helvetica'),),
                onPressed: () {
                  showBarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context, scrollController) => EditPostScreen(),
                  ).then((value) {
                    Navigator.of(fatherContext).pop();
                  });
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Text('Cancel',style: TextStyle(fontFamily: 'Helvetica')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 3),
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 22,
                  ),
                  Text(
                    'View Post',
                    style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 6,
                          right: SizeConfig.blockSizeHorizontal * 8),
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
                            'My feeling after finishing the course (And learning tips!)',
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
                                    'Baoho',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Helvetica'),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1,
                                  ),
                                  Text(
                                    '20/11/2020 at 11:15pm',
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
                            "Despite having lots of opportunities to learn languages in my younger years, I didn't grab them. Not that I didn't want to, but my friends were already speaking multiple languages fluently. Conscious as any youngster, I refused to toddle next to their sprinting. Fast forward many years til half a year ago, I started Vietnamese on Duolingo. In the course, I learned Vietnamese, of course. But even more important, I learned that me learning anything has nothing to do with other people at all! The course didn't magically make me into a fluent Vietnamese speaker. Very frankly speaking, I can barely speak and listen to the language. (Your fault, Duo!) But what matters is, I now know more than when I started. It's who I should compete with - myself in the past.",
                            style: TextStyle(fontFamily: 'Helvetica'),
                          ),
                          // Container(
                          //   height: SizeConfig.blockSizeVertical * 20,
                          //   child:  Chewie(
                          //     controller: _chewieController,
                          //   ),
                          // ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2),
                      child: Text(
                        'Comments(5)',
                        style: TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 0.5),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              InkWell(
                                onLongPress: (){
                                  _showListActionForOtherComment(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right: SizeConfig.blockSizeHorizontal * 2),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                      Container(
                                        child: Text(
                                          'Ho Xuan Cuong',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                      Container(
                                        child: Text(
                                          'rat hay! minh thich',
                                          style: TextStyle(fontFamily: 'Helvetica'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                      Container(
                                        child: Text(
                                          '2 mins ago',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontSize: 10),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 0.5),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 2,
                                    right: SizeConfig.blockSizeHorizontal * 2),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        'wibu',
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        'chu Bao noi hay the. like',
                                        style: TextStyle(fontFamily: 'Helvetica'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        '2 mins ago',
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontSize: 10),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 0.5),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 2,
                                    right: SizeConfig.blockSizeHorizontal * 2),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        'Ho Xuan Cuong',
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        'Wibu',
                                        style: TextStyle(fontFamily: 'Helvetica'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        '2 mins ago',
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontSize: 10),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 0.5),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 2,
                                    right: SizeConfig.blockSizeHorizontal * 2),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        'Ho Xuan Cuong',
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        'dc',
                                        style: TextStyle(fontFamily: 'Helvetica'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                    Container(
                                      child: Text(
                                        '2 mins ago',
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontSize: 10),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 0.5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 0.5),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              InkWell(
                                onLongPress: (){
                                  _showListActionForComment(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      right: SizeConfig.blockSizeHorizontal * 2),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                      Container(
                                        child: Text(
                                          'haihl',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                      Container(
                                        child: Text(
                                          'Like',
                                          style: TextStyle(fontFamily: 'Helvetica'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                      Container(
                                        child: Text(
                                          '2 mins ago',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontSize: 10),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 0.5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 5,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: SizeConfig.blockSizeHorizontal * 79,
                  height: SizeConfig.blockSizeVertical * 6,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: 'Write your comment',
                      hintStyle:
                      TextStyle(fontFamily: 'Helvetica', fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 0.9,
                ),
                Container(
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                  child: IconButton(
                      icon: Icon(
                        CupertinoIcons.paperplane_fill,
                        color: Colors.blueAccent,
                        size: 30,
                      ),
                      onPressed: () {
                        print('comment');
                      }),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
          ],
        ),
      ),
    );
  }
}