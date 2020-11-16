import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/create_post_cubit.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/states/create_post_state.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key key}) : super(key: key);

  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePostScreen> {
  String _fileName;
  File file;
  TextEditingController _titleController, _contentController;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    _titleController = new TextEditingController();
    _contentController = new TextEditingController();
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
    print('clean');
    FilePicker.platform.clearTemporaryFiles();
    setState(() {
      _fileName = null;
      file = null;
    });
    print(_fileName);
  }

  Future uploadFile() async {
    await Firebase.initializeApp();
    String url;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('audio_for_user_post')
        .child(basename(file.path) + '_' + DateTime.now().toString());

    UploadTask uploadTask = reference.putFile(file);
    uploadTask.whenComplete(() async {
      try {
        url = await reference.getDownloadURL();
      } catch (onError) {
        print("Error");
      }
      print(url);
    });
  }

  void createPost(BuildContext context){
    String title, content;
    title = _titleController.text;
    content = _contentController.text;
    BlocProvider.of<CreatePostCubit>(context).createPost(content: content, file: file, title: title);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return BlocProvider(
      create: (context) => CreatePostCubit(PostRepository()),
      child: Scaffold(
        body: BlocConsumer<CreatePostCubit, CreatePostState>(
          listener: (context, state){
            if(state is CreatingPost){
              pr.show();
            }
            else if(state is CreatePostSuccess){
              print(state.fileUrl);
              Navigator.of(context).pop();
            }else if(state is CreatePostError){
              print('Create failed');
            }
          },
          builder: (context, state){
            return Container(
              color: Color.fromRGBO(255, 239, 215, 1),
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
                          width: SizeConfig.blockSizeHorizontal * 4,
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
                          width: SizeConfig.blockSizeHorizontal * 53,
                        ),
                        InkWell(
                          child: Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 15,
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
                              child: Center(
                                child: Text(
                                  "Post",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Helvetica',
                                    color: Colors.black45,
                                  ),
                                ),
                              )),
                          onTap: () {
                            createPost(context);
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
                              'haihl',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Helvetica'),
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
                    child: TextField(
                      controller: _titleController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Enter title here',
                        labelStyle: TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 95,
                    height: SizeConfig.blockSizeVertical * 25,
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
                    child: TextField(
                      controller: _contentController,
                      maxLines: 13,
                      decoration: InputDecoration(
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
                  _fileName != null
                      ? Row(
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
                                      color: Colors.black26.withOpacity(0.05),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: IconButton(
                              icon: Icon(CupertinoIcons.volume_up),
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
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(CupertinoIcons.add_circled),
                                onPressed: () {
                                  getFilePath();
                                },
                              ),
                              Text(
                                'Choose audio file',
                                style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
