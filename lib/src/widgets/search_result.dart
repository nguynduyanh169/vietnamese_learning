
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';
import 'package:vietnamese_learning/src/widgets/search_bar.dart';
import 'package:intl/intl.dart';


class SearchResult extends StatelessWidget {
  String searchKey;
  List<Content> searchPosts;
  SearchResult({Key key, this.searchKey, this.searchPosts}) : super(key: key);

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
            child: ListView.separated(
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2,
                        right: SizeConfig.blockSizeHorizontal * 2),
                    child: _postCard(searchPosts[index], context),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.5 ,
                ),
                itemCount: searchPosts.length),
          ),
        ],
      ),
    );
  }

  Widget _postCard(Content content, BuildContext context) {
    String showContent;
    if (content.text.length > 100) {
      showContent = content.text.substring(0, 100) + "...";
    } else {
      showContent = content.text;
    }
    return Container(
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
              content.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Helvetica'),
            ),
            onTap: () => pushNewScreen(context,
                screen: ViewPost(
                  content: content,
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Row(
            children: <Widget>[
              content.avatar == null ?
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ): CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(content.avatar),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        content.studentName,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Helvetica'),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Image(
                        width: 22,
                        height: 22,
                        image: NetworkImage(content.nation),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.2,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy-kk:mm').format(content.postDate),
                    style: TextStyle(fontSize: 10, fontFamily: 'Helvetica'),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Text(
            showContent,
            style: TextStyle(fontFamily: 'Helvetica'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    CupertinoIcons.bubble_middle_bottom,
                  ),
                  onPressed: null),
              Text(
                content.numberOfComment.toString(),
                style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
