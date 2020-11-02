import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/vocabularies_cubit.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/resources/demo_match_vocab.dart';
import 'package:vietnamese_learning/src/resources/vocabulary_screen.dart';
import 'package:vietnamese_learning/src/states/vocabularies_state.dart';

class VocabDetailScreen extends StatefulWidget {
  String lessonId;
  String lessonName;

  VocabDetailScreen({Key key, this.lessonId, this.lessonName})
      : super(key: key);

  _VocabDetailScreenState createState() =>
      _VocabDetailScreenState(lessonId: lessonId, title: lessonName);
}

class _VocabDetailScreenState extends State<VocabDetailScreen> {
  String lessonId;
  String title;

  _VocabDetailScreenState({this.lessonId, this.title});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => VocabulariesCubit(VocabularyRepository())
        ..loadVocabulariesByLessonId(lessonId),
      child: Scaffold(
          body: BlocBuilder<VocabulariesCubit, VocabulariesState>(
            builder: (context, state) {
              if (state is VocabulariesLoaded) {
                return _vocabDetails(state.vocabularies);
              } else if (state is VocabulariesLoadError) {
                return Center(
                  child: Text('Something went wrong!'),
                );
              } else {
                return _loadingVocabularies();
              }
            },
          )),
    );
  }

  Widget _vocabDetails(List<Vocabulary> _vocabularies) {
    int numOfVocabs = _vocabularies.length;
    return Container(
      color: Color.fromRGBO(255, 239, 204, 100),
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                'Vocabulary',
                style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 15,
          ),
          Container(
            child: Image(
              image: AssetImage('assets/images/vocabulary_logo.png'),
              width: 160,
              height: 160,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          Container(
            child: Text(
              "Lesson $title",
              style: TextStyle(fontFamily: 'Helvetica', fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            child: Text(
              "$numOfVocabs Vocabularies",
              style: TextStyle(fontFamily: 'Helvetica', fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 20,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50.0,
              child: Center(
                child: Padding(
                  child: Text(
                    "Learn Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Helvetica'),
                  ),
                  padding: new EdgeInsets.only(left: 0.0),
                ),
              ),
            ),
            onPressed: () => pushNewScreen(context, screen: VocabularyScreen()),
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _loadingVocabularies() {
    return Container(
      color: Color.fromRGBO(255, 239, 204, 100),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: 20,
            ),
            Text(
              'Loading....',
              style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
            )
          ],
        ),
      ),
    );
  }
}
