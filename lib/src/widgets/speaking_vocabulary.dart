
import 'dart:async';
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:google_speech/google_speech.dart';
import 'package:google_speech/speech_to_text_beta.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';


class SpeakingVocabulary extends StatefulWidget {
  String vietnamese;
  String english;
  String audioInput;
  Function next;
  BuildContext vocabularyContext;
  LocalFileSystem localFileSystem;

  SpeakingVocabulary({this.english, this.vietnamese, this.audioInput, this.next, this.vocabularyContext});
  @override
  _SpeakingVocabularyState createState() => _SpeakingVocabularyState();
}

class _SpeakingVocabularyState extends State<SpeakingVocabulary> {
  bool showPlayer;
  String path;
  String base64String;
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _init();

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Color.fromRGBO(255, 239, 215, 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            padding: EdgeInsets.only(top: 10),
            child: Center(
            child: Text(
              "Speak this vocabulary",
              style: TextStyle(
                  fontFamily: "Helvetica",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 8,
              ),
              Container(
                width: 45,
                height: 45,
                margin: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Color.fromRGBO(255, 190, 51, 100),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(255, 190, 51, 100),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset:
                      Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                    icon: Icon(
                      CupertinoIcons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      AssetsAudioPlayer.playAndForget(Audio.network(UrlUtils.editAudioUrl(widget.audioInput)));
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  widget.vietnamese,
                  style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 17,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 8,
          ),
          Center(
            // child: Container(
            //   width: 75,
            //   height: 75,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(35),
            //     color: Color.fromRGBO(255, 190, 51, 100),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color.fromRGBO(255, 190, 51, 100)
            //             .withOpacity(0.5),
            //         spreadRadius: 1,
            //         blurRadius: 1,
            //         offset: Offset(0, 1), // changes position of shadow
            //       ),
            //     ],
            //   ),
            //   child: IconButton(
            //     iconSize: 50,
            //     icon: Icon(
            //       CupertinoIcons.mic_solid,
            //       color: Colors.white,
            //     ),
            //     onPressed: () => _start(),
            //   ),
            // ),
            child: AvatarGlow(
              animate: _isRecording,
              glowColor: Theme.of(context).primaryColor,
              endRadius: 100.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: Container(
                width: 100,
                height: 100,
                child: FloatingActionButton(
                onPressed: (){
                  if(_isRecording == false) {
                    print("Start");
                    _start();
                  }else {
                    print("Stop");
                    print(_isRecording);
                    _stop();
                  }
                },
                child: Icon(_isRecording ? Icons.stop_circle_outlined : Icons.mic, size: 50,),
                  backgroundColor: Color.fromRGBO(255, 190, 51, 30),
              ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          Center(
            child: recognizing ?
            Text("Your voice match: ") :
            Text(""),

          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (recognizeFinished)
                  _RecognizeContent(
                    text: text,
                  ),
                RaisedButton(
                  onPressed: recognizing ? () {} : recognize,
                  child: recognizing
                      ? CircularProgressIndicator()
                      : Text('Test with recognize'),
                ),

              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 8,
          ),
          Center(
            child: ButtonTheme(
              buttonColor: Color.fromRGBO(255, 190, 51, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: RaisedButton(
                  onPressed: (){
                    widget.next(widget.vocabularyContext);
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    height: SizeConfig.blockSizeVertical * 8,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }


  void recognize() async {
    setState(() {
      recognizing = true;
    });
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/vnamese-master-c53480d8ac94.json'))}');
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();
    final audio = await _getAudioContent(path);
    await speechToText.recognize(config, audio).then((value) {
      setState(() {
        text = value.results
            .map((e) => e.alternatives.first.transcript)
            .join('\n');
      });

    }).whenComplete(() => setState(() {
      recognizeFinished = true;
      recognizing = false;
    }));
    print(text);
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.command_and_search,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'vi-VN');

  Future<void> _copyFileFromAssets(String name) async {
    var data = await rootBundle.load('assets/$name');
    final directory = await getApplicationDocumentsDirectory();
    final pathAudio = directory.path + '/$name';
    await io.File(pathAudio).writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }



  Future<List<int>> _getAudioContent(String name) async {
    final directory = await getApplicationDocumentsDirectory();
    // final pathAudio = directory.path + '/$name';
    // if (!File(pathAudio).existsSync()) {
    //   await _copyFileFromAssets(name);
    // }
    return io.File(name).readAsBytesSync().toList();
  }

  _init() async{
    try{
      if(await FlutterAudioRecorder.hasPermissions){
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDicrectory;
        if(io.Platform.isIOS){
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
    // File file = widget.localFileSystem.file(result.path);
    // print("File length: ${await file.length()}");
    setState(() {
      _isRecording = false;
      path = result.path;
      _current = result;
      _currentStatus = _current.status;
    });
  }
}

class _RecognizeContent extends StatelessWidget {
  final String text;

  const _RecognizeContent({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'The text recognized by the Google Speech Api:',
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

