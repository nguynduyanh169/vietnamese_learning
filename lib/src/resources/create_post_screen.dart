import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:countdown/countdown.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/create_post_cubit.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/create_post_state.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key key}) : super(key: key);

  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePostScreen> {
  String _fileName;
  File file;
  TextEditingController _titleController, _contentController;
  ProgressDialog pr;
  BuildContext _context;
  String titleInvalid, contentInvalid;
  String path;
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool _isRecording = false;
  UserProfile userProfile = new UserProfile();
  final picker = ImagePicker();

  final formKey = new GlobalKey<FormState>();

  _CreatePostState();

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _titleController = new TextEditingController();
    _contentController = new TextEditingController();
  }

  Future getVideo() async {
    final pickedFile = await picker.getVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 60));
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No video selected.');
      }
    });
  }

  void _loadUsername() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();
    setState(() {
      String username = prefs.getString('username');
      userProfile = UserProfile.fromJson(json.decode(prefs.getString(username + 'profile')));
    });
  }

  void getFilePath() async {
    try {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      if (result == null) {
        print('null');
        return;
      }
      File file = File(result.files.single.path);
      print("File path: " + file.path);
      setState(() {
        this._fileName = file.path;
        this.file = file;
      });
    } on PlatformException catch (e) {
      print(e.message);
    } catch (ex) {
      print(ex.toString());
    }
  }

  void clearCacheFile() {
    FilePicker.platform.clearTemporaryFiles();
    setState(() {
      _fileName = null;
      file = null;
    });
    print(_fileName);
  }

  void createPost(BuildContext context) {
    String title, content;
    title = _titleController.text;
    content = _contentController.text;
    BlocProvider.of<CreatePostCubit>(context)
        .createPost(content: content, file: file, title: title);
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _context = context;
    return BlocProvider(
      create: (context) => CreatePostCubit(PostRepository()),
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
        body: BlocConsumer<CreatePostCubit, CreatePostState>(
          listener: (context, state) {
            if (state is CreatingPost) {
              CustomProgressDialog.progressDialog(context);
            } else if (state is ValidatePost) {
              titleInvalid = state.titleMessage;
              contentInvalid = state.contentMessage;
            } else if (state is CreatePostSuccess) {
              Navigator.pop(context);
              Navigator.of(context).pop();
            } else if (state is CreatePostError) {
              pr.hide();
            }
          },
          builder: (context, state) {
            return Form(
                key: formKey,
                child: Container(
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
                                  builder: (context) =>
                                  new CupertinoAlertDialog(
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
                                          style: TextStyle(
                                              fontFamily: 'Helvetica'),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, 'yes');
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontFamily: 'Helvetica'),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, 'no');
                                        },
                                      ),
                                    ],
                                  ),
                                ).then((value) {
                                  if (value == 'yes') {
                                    Navigator.of(context).pop();
                                  }
                                });
                              }),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 20,
                          ),
                          Text(
                            "Create Post",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Helvetica',
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 23,
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
                                          color:
                                          Colors.black26.withOpacity(0.05),
                                          offset: Offset(0.0, 6.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.10)
                                    ]),
                                child: Center(
                                  child: Text(
                                    "Post",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Helvetica',
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                            onTap: () {
                              if(formKey.currentState.validate()){
                                createPost(context);
                              }
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
                            radius: 25,
                            backgroundImage:
                            userProfile.avatar == null ? AssetImage('assets/images/profile.png') : NetworkImage(userProfile.avatar),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userProfile.fullname == null ? 'user' : userProfile.fullname,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Helvetica'),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1,
                              ),
                              Container(
                                width: 150,
                                height: 20,
                                child: Text(
                                  "What's on your mind?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Helvetica',
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
                      child: TextFormField(
                        validator: ValidationBuilder().minLength(1, 'Please type your title').build(),
                        controller: _titleController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorText: titleInvalid,
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
                      child: TextFormField(
                        validator: ValidationBuilder().minLength(1, 'Please type your content').build(),
                        controller: _contentController,
                        maxLines: 13,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorText: contentInvalid,
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
                    file != null
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
                                  width:
                                  SizeConfig.blockSizeHorizontal * 20,
                                  height:
                                  SizeConfig.blockSizeVertical * 15,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
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
                                    icon: Icon(CupertinoIcons.paperclip),
                                  ),
                                ),
                                Positioned(
                                  left:
                                  SizeConfig.blockSizeHorizontal * 10,
                                  bottom:
                                  SizeConfig.blockSizeVertical * 9,
                                  child: new Container(
                                      padding: EdgeInsets.all(1),
                                      constraints: BoxConstraints(
                                        minWidth: 12,
                                        minHeight: 12,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          CupertinoIcons
                                              .clear_circled_solid,
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
                    )
                        : Row(
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
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                  ],
                ),
              ),
            )
            );
          },
        ),
      ),
    );
  }
}
