
import 'dart:async';
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:google_speech/google_speech.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'dart:math' as Math;


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
  List<double> values =[];

  @override
  void initState() {
    super.initState();
    _init();

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    MediaQueryData queryData = MediaQuery.of(context);
    var rng = new Math.Random();
    for (var i = 0; i < 100; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
    return Container(
      color: Color.fromRGBO(255, 239, 215, 100),
      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5, right: SizeConfig.blockSizeHorizontal * 5),
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
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 66,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                Row(
                  children: [
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
                            AssetsAudioPlayer.playAndForget(Audio.network(widget.audioInput));
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
                Center(
                  child: AvatarGlow(
                    animate: _isRecording,
                    //glowColor: Theme.of(context).primaryColor,
                    endRadius: 90.0,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    repeat: true,
                    child: Container(
                      width: 140,
                      height: 140,
                      child: FloatingActionButton(
                        onPressed: (){
                          if(_isRecording == false) {
                            setState(() {
                              _isRecording = true;
                            });
                            _start();

                          }else {
                            setState(() {
                              _isRecording = false;
                            });
                            _stop();

                          }
                        },
                        child: _isRecording == true
                            ? Icon(
                          CupertinoIcons.stop,
                          size: 80,
                        )
                            : Icon(CupertinoIcons.mic_solid, size: 80,),
                        backgroundColor: Color.fromRGBO(255, 190, 51, 30),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(child: _isRecording == false ? Text('Tap to record your voice', style: TextStyle(fontFamily: 'Helvetica'),): Text('Recording', style: TextStyle(fontFamily: 'Helvetica'),),),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      if (recognizeFinished)
                        _RecognizeContent(
                          text: printSimilarity(widget.vietnamese, text),
                        ),
                      Center(
                        child: recognizing ? CupertinoActivityIndicator(
                          radius: 10.0,
                        ) : Text(""),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
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
        '${(await rootBundle.loadString('assets/vietnamese-master-2e898b96ecf0.json'))}');
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
      _init();
    }));
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
          //_isRecording = true;
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
      //_isRecording = false;
      path = result.path;
      _current = result;
      _currentStatus = _current.status;
      recognize();
    });
  }

  int editDistance(String s1, String s2)
  {
    s1 = s1.toLowerCase();
    s2 = s2.toLowerCase();
    List<int> costs = new List<int>((s2.length + 1));
    for (int i = 0; i <= s1.length; i++) {
      int lastValue = i;
      for (int j = 0; j <= s2.length; j++) {
        if (i == 0) {
          costs[j] = j;
        } else {
          if (j > 0) {
            int newValue = costs[j - 1];
            if (s1.codeUnitAt(i - 1) != s2.codeUnitAt(j - 1)) {
              newValue = (Math.min(Math.min(newValue, lastValue), costs[j]) + 1);
            }
            costs[j - 1] = lastValue;
            lastValue = newValue;
          }
        }
      }
      if (i > 0) {
        costs[s2.length] = lastValue;
      }
    }
    return costs[s2.length];
  }

  double similarity(String s1, String s2)
  {
    String longer = s1;
    String shorter = s2;
    if (s1.length < s2.length) {
      longer = s2;
      shorter = s1;
    }
    int longerLength = longer.length;
    if (longerLength == 0) {
      return 1;
    }
    return (longerLength.toDouble() - editDistance(longer, shorter).toDouble()) / longerLength.toDouble();
  }

  String printSimilarity(String s, String t)
  {
    String result = (similarity(s, t) * 100).toString();
    return result;
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
          Center(
            child: Text(
              'The word we hear from your voice',
              style: TextStyle(fontFamily: 'Helvetica'),
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              child: Padding(padding: const EdgeInsets.all(4.0),
                child: AutoSizeText(
                  text,
                  maxLines: 3,
                  style: TextStyle(fontFamily: 'Helvetica'),
                  overflow: TextOverflow.ellipsis,
                  maxFontSize: 20,
                  minFontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

