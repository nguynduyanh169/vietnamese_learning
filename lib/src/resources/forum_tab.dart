import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/posts_cubit.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/resources/view_post.dart';
import 'package:vietnamese_learning/src/states/posts_state.dart';
import 'package:intl/intl.dart';

class ForumTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForumTabState();
  }
}

class ForumTabState extends State<ForumTab> {
  List<Content> _contents;
  Post currentPost;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  int totalPages;
  int countPages = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> loadMore(BuildContext context) async{
    BlocProvider.of<PostsCubit>(context).loadMorePost(currentPost, countPages, totalPages);
    return true;
  }
  @override
  Widget build(Object context) {
    return BlocProvider(
      create: (context) => PostsCubit(PostRepository())..loadInitPost(),
      child: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is LoadingPosts) {
          } else if (state is LoadPostsSuccess) {
            _contents = state.contents;
            currentPost = state.post;
            totalPages = state.post.totalPages;
          } else if (state is LoadPostsError) {
          } else if (state is LoadMorePostSuccess) {
            isLoadingMore = false;
            if(currentPost.content[0].id != state.post.content[0].id) {
              currentPost = state.post;
              _contents.addAll(state.contents);
            }
            countPages = state.countPost;
          } else if (state is LoadingMorePost) {
            isLoadingMore = true;
          } else if(state is LoadMorePostDone){
            isLoadingMore = false;
          }
        },
        builder: (context, state) {
          if (state is LoadPostsError) {
            return Container(
              child: Center(
                child: Text('No Posts'),
              ),
            );
          } else if (state is LoadingPosts) {
            return _loadingPosts(context);
          } else if (state is LoadMorePostError) {
            return Container(
              child: Center(
                child: Text('No Posts'),
              ),
            );
          } else {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Expanded(
                  child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController..addListener(() {
                        if(_scrollController.offset == _scrollController.position.maxScrollExtent){
                          BlocProvider.of<PostsCubit>(context).loadMorePost(currentPost, countPages, totalPages);
                        }
                      }),
                      itemBuilder: (context, index) {
                        return _postCard(
                            _contents[index].title,
                            _contents[index].postDate,
                            _contents[index].studentName,
                            _contents[index].text);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      itemCount: _contents.length),
                ),
                      isLoadingMore == true ? CupertinoActivityIndicator(radius: 10,) : Container(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _postCard(
      String title, DateTime postDate, String studentName, String content) {
    if(content.length > 100){
      content = content.substring(0, 100) + "...";
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
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Helvetica'),
            ),
            onTap: () => pushNewScreen(context,
                screen: ViewPost(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino),
          ),
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
                  Text(
                    studentName,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontFamily: 'Helvetica'),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy-kk:mm').format(postDate),
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
            content,
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
                '20',
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
