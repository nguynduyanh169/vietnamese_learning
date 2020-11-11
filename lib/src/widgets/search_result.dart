import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';
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
      backgroundColor: Color.fromRGBO(255, 239, 215, 1),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black26,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
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
          ),
          Expanded(
            child: ListView(children: <Widget>[
              InkWell(child: Container(
                margin: EdgeInsets.all(6),
                height: SizeConfig.blockSizeVertical * 12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          Text(
                            'Những câu nói hay',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Helvetica',
                              fontSize: 15,
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
                                'haihl',
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
                        width: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.conversation_bubble),
                        onPressed: () => null,
                      ),
                      Text('113', style: TextStyle(fontFamily: 'Helvetica'),)
                    ],
                  ),
                ),
              ), onTap: (){
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (context) => ViewPost(),
                ));
              },),

              SizedBox(
                height: SizeConfig.blockSizeVertical * .1,
              ),
              Container(
                margin: EdgeInsets.all(6),
                height: SizeConfig.blockSizeVertical * 12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          Text(
                            'Những câu nói hay',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Helvetica',
                              fontSize: 15,
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
                                'baohq',
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
                        width: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.conversation_bubble),
                        onPressed: () => null,
                      ),
                      Text('113', style: TextStyle(fontFamily: 'Helvetica'),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * .1,
              ),
              Container(
                margin: EdgeInsets.all(6),
                height: SizeConfig.blockSizeVertical * 12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          Text(
                            'Những câu nói hay',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Helvetica',
                              fontSize: 15,
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
                                'baohq',
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
                        width: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.conversation_bubble),
                        onPressed: () => null,
                      ),
                      Text('113', style: TextStyle(fontFamily: 'Helvetica'),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * .1,
              ),
              Container(
                margin: EdgeInsets.all(6),
                height: SizeConfig.blockSizeVertical * 12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          Text(
                            'Những câu nói hay',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Helvetica',
                              fontSize: 15,
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
                                'baohq',
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
                        width: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.conversation_bubble),
                        onPressed: () => null,
                      ),
                      Text('113', style: TextStyle(fontFamily: 'Helvetica'),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * .1,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
