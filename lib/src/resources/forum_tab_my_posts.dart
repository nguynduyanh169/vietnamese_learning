import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/my_posts_cubit.dart';
import 'package:vietnamese_learning/src/cubit/posts_cubit.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';
import 'package:intl/intl.dart';
import 'package:vietnamese_learning/src/resources/view_post2.dart';
import 'package:vietnamese_learning/src/states/posts_state.dart';

class MyPostsTab extends StatefulWidget {
  MyPostsTab({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyPostTabState();
  }
}

class _MyPostTabState extends State<MyPostsTab> {
  List<Content> myPosts;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => MyPostsCubit(PostRepository())..loadMyPosts(),
      child: BlocConsumer<MyPostsCubit, PostsState>(
        listener: (context, state) {
          if (state is LoadMyPostsSuccess) {
            myPosts = state.myPosts;
          }
        },
        builder: (context, state) {
          if (state is LoadMyPostsError) {
            return Container(
              child: Center(
                child: Text('No Posts'),
              ),
            );
          } else if (state is LoadingMyPosts) {
            return _loadingPosts(context);
          } else {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      myPosts.clear();
                      BlocProvider.of<MyPostsCubit>(context).loadMyPosts();
                    },
                    child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _postCard(myPosts[index], context);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: SizeConfig.blockSizeVertical * 1.5,
                            ),
                        itemCount: myPosts.length),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _postCard(Content content, BuildContext buildContext) {
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
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino)
                      .then((value) {
                    if (value == 'delete') {
                      myPosts.clear();
                      BlocProvider.of<MyPostsCubit>(buildContext).loadMyPosts();
                    }
                  })),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Row(
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

  Widget _loadingPosts(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoActivityIndicator(
            radius: 20,
          ),
        ],
      ),
    );
  }
}
