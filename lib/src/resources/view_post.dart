import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class ViewPost extends StatefulWidget {
  ViewPost({Key key}) : super(key: key);

  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'View Post',
                    style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  )
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5),
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
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
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
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Text(
                'Comments(5)',
                style: TextStyle(fontFamily: 'Helvetica', fontSize: 15),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
            Expanded(
                child: ListView(
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
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1.5,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
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
                                  style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),
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
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1.5,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
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
                                  style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),
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
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1.5,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
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
                                  style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),
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
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1.5,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
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
                                  style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),
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
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1.5,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
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
                                  style: TextStyle(fontFamily: 'Helvetica', fontSize: 10),
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
            )),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            TextField(
              decoration: InputDecoration.collapsed(hintText: "Start typing ..."),
            ),
          ],
        ),
      ),
    );
  }
}
