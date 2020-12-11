import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/post_cubit.dart';
import 'package:vietnamese_learning/src/data/comment_repository.dart';
import 'package:vietnamese_learning/src/models/comment.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/resources/edit_post_screen.dart';
import 'package:vietnamese_learning/src/states/view_post_state.dart';

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
  String username;
  int numberOfComment = 0;

  String _fileName;
  File file;
  String path;
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool _isRecording = false;
  ProgressDialog pr;
  BuildContext _ctx;

  _ViewPostState({this.content});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(content.link);
    if (content.link != null) {
      if (content.link.toLowerCase().contains('mp4') ||
          content.link.toLowerCase().contains('mov')) {
        player.setDataSource(content.link, autoPlay: true);
      }
    }
    _txtComment = new TextEditingController();
    _loadUsername();
  }

  void _loadUsername() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username');
  }

  File _getAudioContent(String path) {
    return File(path);
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/';
        Directory appDocDicrectory;
        if (Platform.isIOS) {
          appDocDicrectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDicrectory = await getExternalStorageDirectory();
        }
        customPath = appDocDicrectory.path +
            customPath +
            DateTime.now().microsecondsSinceEpoch.toString();
        _recorder = FlutterAudioRecorder(customPath,
            audioFormat: AudioFormat.WAV, sampleRate: 16000);
        await _recorder.initialized;
        var current = await _recorder.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _isRecording = true;
        _current = recording;
      });
      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }
        var current = await _recorder.current(channel: 0);
        setState(() {
          _isRecording = true;
          _current = current;
          _currentStatus = _current.status;
        });
      });
      print(_isRecording);
    } catch (e) {
      print(e);
    }
  }

  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    setState(() {
      path = result.path;
      _current = result;
      _currentStatus = _current.status;
      file = _getAudioContent(path);
      _isRecording = false;
    });
    print(_isRecording);
  }

  void clearCacheFile() {
    setState(() {
      _fileName = null;
      file = null;
    });
    print(_fileName);
  }

  _showRecordDialog(BuildContext context) {
    _init();
    bool isRecord = false;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        content: new Container(
          width: 260.0,
          height: 230.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // dialog top
              new Expanded(
                child: new Row(
                  children: <Widget>[
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 20,
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Text(
                        'Record voice',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              new Expanded(
                child: new Row(
                  children: <Widget>[
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 21,
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Text(
                        '00:01 / 02:00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Helvetica',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              //
              // dialog centre
              new Expanded(
                child: AvatarGlow(
                  animate: _isRecording,
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 100.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: Container(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (isRecord == false) {
                          print('start');
                          _start();
                          setState(() {
                            isRecord = true;
                          });
                        } else {
                          print("Stop");
                          _stop();
                          setState(() {
                            isRecord = false;
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: isRecord == true
                          ? Icon(
                              CupertinoIcons.stop,
                              size: 50,
                            )
                          : Icon(CupertinoIcons.mic_solid),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ),
                flex: 2,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              // dialog bottom
              new Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isRecord = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: new EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.05),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.10)
                        ]),
                    child: new Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontFamily: 'Helvetica',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
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
    BlocProvider.of<PostCubit>(context).saveComment(commentSave, file);
    clearCacheFile();
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
            margin: EdgeInsets.only(top: 8),
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

  Widget _comment(BuildContext context, Comment comment, String commentBy, String postBy) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Row(
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
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 1.5,
                ),
                InkWell(
                  onLongPress: () {
                    if(postBy != username){
                      if(commentBy == username) {
                        _showListActionForComment(context);
                      }else if(commentBy != username){
                        _showListActionForOtherComment(context);
                      }
                    }
                    else {
                      _showListActionForComment(context);
                    }
                  },
                  child: ChatBubble(
                    clipper:
                    ChatBubbleClipper5(type: BubbleType.receiverBubble),
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 0.5,
                        bottom: SizeConfig.blockSizeVertical * 2),
                    backGroundColor: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  comment.studentName,
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1.5,
                                ),
                                Image(
                                  width: 22,
                                  height: 22,
                                  image: NetworkImage(comment.nation),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical * 0.5,
                                ),
                                Container(
                                  child: Text(
                                    DateFormat('dd/MM/yyyy-kk:mm')
                                        .format(comment.date),
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Text(
                                comment.text,
                                style: TextStyle(
                                    fontFamily: 'Helvetica', fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            )
          ],
        ),
        comment.voiceLink != null
            ? Positioned(
          right: SizeConfig.blockSizeHorizontal * 6,
          top: SizeConfig.blockSizeVertical * 1.5,
          child: InkWell(
            child: Center(
              child: Icon(
                CupertinoIcons.volume_up,
                color: Colors.blueAccent,
                size: 20,
              ),
            ),
            onTap: () {
              AssetsAudioPlayer.playAndForget(
                  Audio.network(comment.voiceLink));
            },
          ),
        )
            : Container()
      ],
    );
  }

  Widget _editPost(String name, BuildContext context) {
    if (name == username) {
      return IconButton(
        icon: Icon(CupertinoIcons.ellipsis),
        onPressed: () {
          _showListAction(context);
        },
      );
    } else {
      return Container();
    }
  }

  void _showListAction(BuildContext rootContext) {
    showCupertinoModalPopup(
        context: rootContext,
        builder: (BuildContext context) {
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
                onPressed: () => pushNewScreen(
                  context,
                  screen: EditPostScreen(
                    content: content,
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.slideUp,
                ),
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Delete',
                  style: TextStyle(fontFamily: 'Helvetica', color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    useRootNavigator: true,
                    context: context,
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
                            Navigator.of(context).pop('yes');
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontFamily: 'Helvetica'),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop("no");
                          },
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value == 'yes') {
                      BlocProvider.of<PostCubit>(rootContext)
                          .deletePost(content.id);
                    }
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
    _ctx = context;
    pr = new ProgressDialog(context, showLogs: true, isDismissible: false);
    pr.style(
        progressWidget: CupertinoActivityIndicator(),
        message: 'Please wait...');
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          PostCubit(CommentRepository())..loadComments(content.id),
      child: BlocConsumer<PostCubit, ViewPostState>(listener: (context, state) {
        if (state is LoadingPost) {
          print('loading');
        } else if (state is LoadPostSuccess) {
          print('success');
          state.comments.forEach((comment) {
            commentWidget.add(_comment(context, comment, comment.studentName, content.studentName));
          });
          numberOfComment = state.comments.length;
        } else if (state is CommentPostSuccess) {
          commentWidget.clear();
          _txtComment.clear();
          state.comments.forEach((comment) {
            commentWidget.add(_comment(context, comment, comment.studentName, content.studentName));
          });
          pr.hide();
          numberOfComment = state.comments.length;
        } else if (state is CommentingPost) {
          //print('comment');
          pr.show();
        } else if (state is DeletePostSuccess) {
          pr.hide().whenComplete(() {
            Navigator.of(_ctx).pop('delete');
          });
        } else if (state is DeletingPost) {
          pr.show();
        } else if (state is DeletePostFailed) {
          print("Delete failed");
        }
      }, builder: (context, state) {
        if (state is LoadingPost) {
          return _loadingPosts(context);
        } else {
          return Scaffold(
            bottomNavigationBar: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  color: Color.fromRGBO(255, 239, 215, 100),
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 4,
                      right: SizeConfig.blockSizeHorizontal * 3),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 0.5,
                            right: SizeConfig.blockSizeHorizontal * 3),
                        icon: Icon(
                          CupertinoIcons.mic_circle_fill,
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => _showRecordDialog(context));
                        },
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 65,
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
                              CupertinoIcons.paperplane_fill,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                            onPressed: () {
                              comment(context, _txtComment.text, content.id);
                            }),
                      ),
                    ],
                  ),
                )),
            body: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 4,
                      right: SizeConfig.blockSizeHorizontal * 3),
                  color: Color.fromRGBO(255, 239, 215, 100),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2),
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
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Helvetica'),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 19,
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
                                          color:
                                              Colors.black26.withOpacity(0.05),
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  2,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text(
                                                  content.studentName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Helvetica'),
                                                ),
                                                SizedBox(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                ),
                                                Image(
                                                  width: 22,
                                                  height: 22,
                                                  image: NetworkImage(
                                                      content.nation),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      0.2,
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
                                      content.text,
                                      style: TextStyle(fontFamily: 'Helvetica'),
                                    ),
                                    _mediaPlayer(context, content.link),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 2,
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
                                  'Comments($numberOfComment)',
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
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                    ],
                  ),
                ),
                file != null
                    ? Positioned(
                        top: SizeConfig.blockSizeVertical * 81,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 4,
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        height:
                                            SizeConfig.blockSizeVertical * 8,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15.0),
                                                topLeft: Radius.circular(5.0),
                                                bottomRight:
                                                    Radius.circular(5.0),
                                                bottomLeft:
                                                    Radius.circular(5.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26
                                                      .withOpacity(0.05),
                                                  offset: Offset(0.0, 6.0),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 0.10)
                                            ]),
                                        child: IconButton(
                                          icon: Icon(CupertinoIcons.volume_up),
                                        ),
                                      ),
                                      Positioned(
                                        left: SizeConfig.blockSizeHorizontal *
                                            1.5,
                                        bottom:
                                            SizeConfig.blockSizeVertical * 3.3,
                                        child: new Container(
                                            padding: EdgeInsets.all(1),
                                            constraints: BoxConstraints(
                                              minWidth: 2,
                                              minHeight: 2,
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                CupertinoIcons
                                                    .clear_circled_solid,
                                                color: Colors.redAccent,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                clearCacheFile();
                                              },
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: SizeConfig.blockSizeVertical * 10,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                        ),
                      )
                    : Container()
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _loadingPosts(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
