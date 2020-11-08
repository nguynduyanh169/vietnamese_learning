import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/widgets/search_bar.dart';

class SearchResult extends StatefulWidget {
  SearchResult({Key key}) : super(key: key);

  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Search Result',
                    style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Phan nan ve dich vu',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Helvetica',
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Row(
                          children: [
                            Text(
                              '2 days ago by ',
                              style: TextStyle(
                                  fontSize: 13, fontFamily: 'Helvetica'),
                            ),
                            Text(
                              'Ho Quang Bao',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () => null,
                    ),
                    Text("113")
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Phan nan ve dich vu',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Helvetica',
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Row(
                          children: [
                            Text(
                              '2 days ago by ',
                              style: TextStyle(
                                  fontSize: 13, fontFamily: 'Helvetica'),
                            ),
                            Text(
                              'Ho Quang Bao',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () => null,
                    ),
                    Text("113")
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Phan nan ve dich vu',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Helvetica',
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Row(
                          children: [
                            Text(
                              '2 days ago by ',
                              style: TextStyle(
                                  fontSize: 13, fontFamily: 'Helvetica'),
                            ),
                            Text(
                              'Ho Quang Bao',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () => null,
                    ),
                    Text("113")
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
