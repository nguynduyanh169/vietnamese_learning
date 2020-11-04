import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/vocabularies_cubit.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
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
      color: Colors.green,
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
              SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
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
      Container(
        width: MediaQuery.of(context).size.width * .85,
        height: 80.0,
        child: Card(
          color: Colors.yellow[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => VocabularyScreen(vocabularies: _vocabularies,),
                ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Learn Now",
                        style: GoogleFonts.sansita(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
        ],
      ),
    );
  }

  Widget _loadingVocabularies() {
    return Container(
      color: Colors.green,
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
