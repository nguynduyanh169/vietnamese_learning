import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/edit_post_cubit.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/edit_post_state.dart';

class EditPostScreen extends StatefulWidget{
  Content content;
  EditPostScreen({Key key, this.content}): super(key: key);

  _EditPostState createState() => _EditPostState(content: content);
}

class _EditPostState extends State<EditPostScreen>{
  TextEditingController txtTitle;
  TextEditingController txtContent;
  Content content;
  File file;
  bool showPlayer;
  String path;
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool _isRecording = false;
  final picker = ImagePicker();
  ProgressDialog pr;

  _EditPostState({this.content});
  String username = "user";
  @override
  void initState() {
    txtTitle = new TextEditingController(text: content.title);
    txtContent = new TextEditingController(text: content.text);
    _loadUsername();
    super.initState();
  }

  void clearCacheFile() {
    setState(() {
      file = null;
      content.link = null;
    });
  }

  File _getAudioContent(String path)  {
    return File(path);
  }

  Future getVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera, maxDuration: Duration(seconds: 60));
    setState(() {
      if (pickedFile != null) {
        content.link = null;
        file = File(pickedFile.path);
      } else {
        print('No video selected.');
      }
    });
  }

  _init() async{
    try{
      if(await FlutterAudioRecorder.hasPermissions){
        String customPath = '/';
        Directory appDocDicrectory;
        if(Platform.isIOS){
          appDocDicrectory = await getApplicationDocumentsDirectory();
        }else{
          appDocDicrectory = await getExternalStorageDirectory();
        }
        customPath = appDocDicrectory.path + customPath + DateTime.now().microsecondsSinceEpoch.toString();
        _recorder = FlutterAudioRecorder(
            customPath, audioFormat: AudioFormat.WAV, sampleRate: 16000
        );
        await _recorder.initialized;
        var current = await _recorder.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      }
    }catch(e){
      print(e);
    }
  }

  _start() async{
    try{
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _isRecording = true;
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if(_currentStatus == RecordingStatus.Stopped){
          t.cancel();
        }
        var current = await _recorder.current(channel: 0);
        setState(() {
          _isRecording = true;
          _current = current;
          _currentStatus = _current.status;
        });
      });
    }catch(e){
      print(e);
    }
  }

  _stop() async{
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    setState(() {
      path = result.path;
      _current = result;
      _currentStatus = _current.status;
      file = _getAudioContent(path);
      content.link = null;
    });
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
            borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // dialog top
              new Expanded(
                child: new Row(
                  children: <Widget>[
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 14,
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Text(
                        'Record your voice',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
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
                      width: SizeConfig.blockSizeHorizontal * 25,
                    ),
                    new Container(
                        decoration: new BoxDecoration(
                          color: Colors.white,
                        ),
                        child: isRecord == true
                            ? Countdown(
                          duration: Duration(minutes: 2),
                          onFinish: () {
                            _stop();
                            setState(() {
                              isRecord = false;
                            });
                            Navigator.pop(context);
                          },
                          builder:
                              (BuildContext ctx, Duration remaining) {
                            return new Text(
                              "${remaining.inMinutes.toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Helvetica',
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        )
                            : Text(
                          "02:00",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Helvetica',
                          ),
                          textAlign: TextAlign.center,
                        )),
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
                          _start();
                          setState(() {
                            isRecord = true;
                          });
                        } else {
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
                        size: 40,
                      )
                          : Icon(CupertinoIcons.mic_solid, size: 40,),
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

  void _editPost(BuildContext context){
    String title, text;
    title = txtTitle.text;
    text = txtContent.text;
    content.title = title;
    content.text = text;
    if(file == null) {
      PostUpdate postUpdate = new PostUpdate(
          link: content.link, postId: content.id, text: text, title: title);
      BlocProvider.of<EditPostCubit>(context).editPost(postUpdate, null);
    }else{
      PostUpdate postUpdate = new PostUpdate(
          link: content.link, postId: content.id, text: text, title: title);
      BlocProvider.of<EditPostCubit>(context).editPost(postUpdate, file);
    }
  }

  void _loadUsername() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString('username');
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    pr = new ProgressDialog(
        context, showLogs: true, isDismissible: false
    );
    pr.style(
        progressWidget: CupertinoActivityIndicator(), message: 'Please wait...');
    return BlocProvider(
        create: (context) => EditPostCubit(PostRepository()),
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.5),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black26))
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 65,
                  ),
                  IconButton(
                      icon: Icon(
                        CupertinoIcons.mic_circle_fill,
                        size: 45,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => _showRecordDialog(context));
                      }),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  IconButton(
                      icon: Icon(CupertinoIcons.camera_circle_fill,
                          size: 45, color: Colors.blueAccent),
                      onPressed: () async {
                        getVideo();
                      })
                ],
              ),
            ),
          ),
          backgroundColor: Color.fromRGBO(255, 239, 215, 1),
          body: BlocConsumer<EditPostCubit, EditPostState>(
            listener: (context, state){
              if (state is EditingPost) {
                pr.show();
              } else if (state is EditPostSuccess) {
                pr.hide().whenComplete(() => {Navigator.pop(context)});
              } else if (state is EditPostFailed) {
                pr.hide();
              }
            },
            builder: (context, state){
              return Container(
                color: Color.fromRGBO(255, 239, 215, 1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.7,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black26,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 2,
                            ),
                            IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => new CupertinoAlertDialog(
                                      title: new Text(
                                        "Confirm exit",
                                        style: TextStyle(fontFamily: 'Helvetica'),
                                      ),
                                      content: new Text(
                                        "Do you want to exit?",
                                        style: TextStyle(fontFamily: 'Helvetica'),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, 'yes');
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(fontFamily: 'Helvetica'),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, 'no');
                                          },
                                        ),
                                      ],
                                    ),
                                  ).then((value) {
                                    if(value == 'yes'){
                                      Navigator.of(context).pop();
                                    }
                                  });
                                }
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal * 23,),
                            Text(
                              "Edit Post",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Helvetica',
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 25,
                            ),
                            InkWell(
                              child: Container(
                                  height: SizeConfig.blockSizeVertical * 5,
                                  width: SizeConfig.blockSizeHorizontal * 15,
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
                                  child: Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              onTap: () {
                                _editPost(context);
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
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
                                  username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontFamily: 'Helvetica'),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Container(
                                  width: 110,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '20/11/2020 at 12:00am',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Helvetica',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 95,
                        height: SizeConfig.blockSizeVertical * 20,
                        child: TextField(
                          controller: txtTitle,
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Enter title here',
                            labelStyle:
                            TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 95,
                        height: SizeConfig.blockSizeVertical * 25,
                        child: TextField(
                          controller: txtContent,
                          maxLines: 13,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Enter content here',
                            labelStyle: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                      (file != null || content.link !=null)
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 4,
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 20,
                                    height: SizeConfig.blockSizeVertical * 15,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20.0),
                                            topLeft: Radius.circular(5.0),
                                            bottomRight: Radius.circular(5.0),
                                            bottomLeft: Radius.circular(5.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26
                                                  .withOpacity(0.05),
                                              offset: Offset(0.0, 6.0),
                                              blurRadius: 10.0,
                                              spreadRadius: 0.10)
                                        ]),
                                    child: IconButton(
                                      icon: Icon(CupertinoIcons.paperclip),
                                    ),
                                  ),
                                  Positioned(
                                    left: SizeConfig.blockSizeHorizontal * 10,
                                    bottom: SizeConfig.blockSizeVertical * 9,
                                    child: new Container(
                                        padding: EdgeInsets.all(1),
                                        constraints: BoxConstraints(
                                          minWidth: 12,
                                          minHeight: 12,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            CupertinoIcons.clear_circled_solid,
                                            color: Colors.redAccent,
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
                      ) : Row(
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeVertical * 15,
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0)),
                            ),
                            // child: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     IconButton(
                            //       icon: Icon(CupertinoIcons.add_circled),
                            //       onPressed: () {
                            //         getFilePath();
                            //       },
                            //     ),
                            //     Text(
                            //       'Choose audio or video file',
                            //       style: TextStyle(
                            //         fontFamily: 'Helvetica',
                            //         fontSize: 10,
                            //       ),
                            //       textAlign: TextAlign.center,
                            //     )
                            //   ],
                            // )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    );
  }

}