import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/edit_post_screen.dart';

class ViewPost extends StatefulWidget {
  ViewPost({Key key}) : super(key: key);

  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {

  void _showListAction(BuildContext fatherContext){
    showCupertinoModalPopup(
        context: fatherContext,
        builder: (BuildContext buildContext) {
          return CupertinoActionSheet(
            title: Text('Choose option for this post', style: TextStyle(fontFamily: 'Helvetica'),),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('Edit', style: TextStyle(fontFamily: 'Helvetica'),),
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
              CupertinoActionSheetAction(
                child: Text('Delete',style: TextStyle(fontFamily: 'Helvetica', color: Colors.red),),
                onPressed: () {
                  showDialog(
                    useRootNavigator: true,
                    context: fatherContext,
                    builder: (BuildContext context) => new CupertinoAlertDialog(
                      title: new Text("Confirm delete", style: TextStyle(fontFamily: 'Helvetica'),),
                      content: new Text("Do you want to delete this post?", style: TextStyle(fontFamily: 'Helvetica'),),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('Confirm', style: TextStyle(fontFamily: 'Helvetica'),),
                          onPressed: () {
                            Navigator.of(fatherContext).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('Cancel', style: TextStyle(fontFamily: 'Helvetica'),),
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
              child: Text('Cancel', style: TextStyle(fontFamily: 'Helvetica'),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
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
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 20,
                  ),
                  IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        _showListAction(context);
                      }),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Expanded(
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
                          'Những người đầu tiên dùng thử Starlink, hệ thống '
                          'internet cung cấp bởi dàn vệ tinh trên quỹ đạo, '
                          'đã đang chia sẻ những cảm nhận đầu tiên; nhìn chung, '
                          'những phản hồi tích cực đều cho thấy internet tốc độ và độ trễ thấp, '
                          'ngay cả khi chảo Starlink được đặt ở vùng ngoại ô. Người dùng Reddit có tên Wandering-coder mang hệ thống Starlink ra vùng công viên quốc gia tại Idaho và nhận thấy tốc độ download lên được tới 120 Mbps. ',
                          style: TextStyle(fontFamily: 'Helvetica'),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2),
                    child: LikeButton(
                      mainAxisAlignment: MainAxisAlignment.start,
                      size: 30,
                      circleColor: CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          CupertinoIcons.heart,
                          color: isLiked ? Colors.redAccent : Colors.black,
                          size: 30,
                        );
                      },
                      likeCount: 10,
                      countBuilder: (int count, bool isLiked, String text) {
                        var color = isLiked ? Colors.redAccent : Colors.black;
                        Widget result;
                        if (count == 0) {
                          result = Text(
                            "love",
                            style: TextStyle(color: color),
                          );
                        } else
                          result = Text(
                            text,
                            style: TextStyle(color: color),
                          );
                        return result;
                      },
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
                                        'Với chảo vệ tinh đặt tại khoảng đất rung',
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
                                      'Với chảo vệ tinh đặt tại khoảng đất rung',
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
                                      'Với chảo vệ tinh đặt tại khoảng đất rung',
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
                                      'Với chảo vệ tinh đặt tại khoảng đất',
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
                        Icons.send,
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
