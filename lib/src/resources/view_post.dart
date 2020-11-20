import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/post_cubit.dart';
import 'package:vietnamese_learning/src/data/comment_repository.dart';
import 'package:vietnamese_learning/src/models/comment.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/resources/edit_post_screen.dart';
import 'package:vietnamese_learning/src/states/view_post_state.dart';
import 'package:vietnamese_learning/src/utils/auth_utils.dart';

class ViewPost extends StatefulWidget {
  Content content;

  ViewPost({Key key, this.content}) : super(key: key);

  _ViewPostState createState() => _ViewPostState(content: content);
}

class _ViewPostState extends State<ViewPost> {
  Content content;
  final assetsAudioPlayer = AssetsAudioPlayer();
  final FijkPlayer player = FijkPlayer();
  TextEditingController _txtComment;
  List<Widget> commentWidget = new List<Widget>();
  bool isplaying = false;

  _ViewPostState({this.content});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(content.link);
    if (content.link != null) {
      if (content.link.toLowerCase().contains('mp4') ||
          content.link.toLowerCase().contains('mov')) {
        player.setDataSource(
            content.link, autoPlay: true);
      }
    }
    _txtComment = new TextEditingController();
  }

  @override
  void dispose() {
    player.dispose();
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void comment(BuildContext context, String comment, int postId) {
    CommentSave commentSave =
        new CommentSave(date: DateTime.now(), postId: postId, text: comment);
    BlocProvider.of<PostCubit>(context).saveComment(commentSave);
  }

  Widget _mediaPlayer(BuildContext context, String link) {
    if (link != null) {
      if (link.toLowerCase().contains('mp4') ||
          link.toLowerCase().contains('mov')) {
        return FijkView(
          fit: FijkFit(aspectRatio: -1, sizeFactor: 2),
          width: SizeConfig.blockSizeHorizontal * 85,
          height: SizeConfig.blockSizeVertical * 30,
          player: player,
        );
      } else {
        return InkWell(
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 35,
            height: SizeConfig.blockSizeVertical * 8,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Color.fromRGBO(255, 190, 51, 1),
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    CupertinoIcons.play_arrow_solid,
                    color: Colors.black54,
                  ),
                  iconSize: 20,
                ),
                Text(
                  'Press to listen',
                  style: TextStyle(fontFamily: 'Helvetica', fontSize: 12),
                )
              ],
            ),
          ),
          onTap: () {
            assetsAudioPlayer.open(Audio.network(link));
          },
        );
      }
    } else {
      return Container();
    }
  }

  Widget _comment(BuildContext context, Comment comment) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 1.5,
            ),
            Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 1.5,
            ),
            InkWell(
              onLongPress: () {
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
                        comment.studentName,
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
                        comment.text,
                        style: TextStyle(fontFamily: 'Helvetica'),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.5,
                    ),
                    Container(
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(comment.date),
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
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.5,
        )
      ],
    );
  }

  Widget _editPost(String name, BuildContext context){
    if(name == 'haihl'){
      return IconButton(
        icon: Icon(CupertinoIcons.ellipsis),
        onPressed: () {
          _showListAction(context);
        },
      );
    }
    else{
      return Container();
    }
  }

  void _showListAction(BuildContext fatherContext) {
    showCupertinoModalPopup(
        context: fatherContext,
        builder: (BuildContext buildContext) {
          return CupertinoActionSheet(
            title: Text(
              'Choose option for this post',
              style: TextStyle(fontFamily: 'Helvetica'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  'Edit',
                  style: TextStyle(fontFamily: 'Helvetica'),
                ),
                onPressed: () {
                  showBarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context, scrollController) => EditPostScreen(content: content,),
                  ).then((value) {
                    Navigator.of(fatherContext).pop();
                  });
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Delete',
                  style: TextStyle(fontFamily: 'Helvetica', color: Colors.red),
                ),
                onPressed: () {
                  showDialog(
                    useRootNavigator: true,
                    context: fatherContext,
                    builder: (BuildContext context) => new CupertinoAlertDialog(
                      title: new Text(
                        "Confirm delete",
                        style: TextStyle(fontFamily: 'Helvetica'),
                      ),
                      content: new Text(
                        "Do you want to delete this post?",
                        style: TextStyle(fontFamily: 'Helvetica'),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            'Confirm',
                            style: TextStyle(fontFamily: 'Helvetica'),
                          ),
                          onPressed: () {
                            Navigator.of(fatherContext).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontFamily: 'Helvetica'),
                          ),
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
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: 'Helvetica'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }

  void _showListActionForComment(BuildContext fatherContext) {
    showCupertinoModalPopup(
        context: fatherContext,
        builder: (BuildContext buildContext) {
          return CupertinoActionSheet(
            title: Text(
              'Choose option for this comment',
              style: TextStyle(fontFamily: 'Helvetica'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  child: Text(
                    'Copy',
                    style: TextStyle(fontFamily: 'Helvetica'),
                  ),
                  onPressed: () {
                    Navigator.of(fatherContext).pop();
                  }),
              CupertinoActionSheetAction(
                child: Text('Delete',
                    style:
                        TextStyle(fontFamily: 'Helvetica', color: Colors.red)),
                onPressed: () {
                  showDialog(
                    useRootNavigator: true,
                    context: fatherContext,
                    builder: (BuildContext context) => new CupertinoAlertDialog(
                      title: new Text(
                        "Confirm delete",
                        style: TextStyle(fontFamily: 'Helvetica'),
                      ),
                      content: new Text(
                        "Do you want to delete this comment?",
                        style: TextStyle(fontFamily: 'Helvetica'),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            'Confirm',
                            style: TextStyle(fontFamily: 'Helvetica'),
                          ),
                          onPressed: () {
                            Navigator.of(fatherContext).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontFamily: 'Helvetica'),
                          ),
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
              child: Text('Cancel', style: TextStyle(fontFamily: 'Helvetica')),
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
            title: Text(
              'Choose option for this comment',
              style: TextStyle(fontFamily: 'Helvetica'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  'Copy',
                  style: TextStyle(fontFamily: 'Helvetica'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Text('Cancel', style: TextStyle(fontFamily: 'Helvetica')),
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
    return BlocProvider(
      create: (context) =>
          PostCubit(CommentRepository())..loadComments(content.id),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
            BlocConsumer<PostCubit, ViewPostState>(listener: (context, state) {
          if (state is LoadingPost) {
            print('loading');
          } else if (state is LoadPostSuccess) {
            print('success');
            state.comments.forEach((comment) {
              commentWidget.add(_comment(context, comment));
            });
          } else if (state is CommentPostSuccess) {
            print('success');
            commentWidget.clear();
            _txtComment.clear();
            state.comments.forEach((comment) {
              commentWidget.add(_comment(context, comment));
            });
          }
        }, builder: (context, state) {
          if (state is LoadingPost) {
            return _loadingPosts(context);
          } else {
            return Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 4,
                  right: SizeConfig.blockSizeHorizontal * 3),
              color: Color.fromRGBO(255, 239, 215, 100),
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 22,
                        ),
                        _editPost(content.studentName, context)
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
                                  content.title,
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
                                      backgroundImage: AssetImage(
                                          'assets/images/profile.png'),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          content.studentName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Helvetica'),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1,
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy-kk:mm')
                                              .format(content.postDate),
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Helvetica'),
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
                                _mediaPlayer(context, content.link),
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
                              style: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1.5,
                          ),
                          Column(
                            children: commentWidget,
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
                          controller: _txtComment,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'Write your comment',
                            hintStyle: TextStyle(
                                fontFamily: 'Helvetica', fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 0.9,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: IconButton(
                            icon: Icon(
                              CupertinoIcons.bubble_left_fill,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                            onPressed: () {
                              comment(context, _txtComment.text, content.id);
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                ],
              ),
            );
          }
        }),
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
