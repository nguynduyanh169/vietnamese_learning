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
  VocabDetailScreen({Key key, this.lessonId, this.lessonName}) : super(key: key);

  _VocabDetailScreenState createState() => _VocabDetailScreenState(lessonId: lessonId, title: lessonName);
}

class _VocabDetailScreenState extends State<VocabDetailScreen>{
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
      create: (context) => VocabulariesCubit(VocabularyRepository())..loadVocabulariesByLessonId(lessonId),
      child: Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
            title: Text(
              "Vocabulary",
              style: TextStyle(color: Colors.white70),
            ),
            leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white70),  onPressed: () => Navigator.of(context).pop(),),
            backgroundColor: Colors.green,
            shadowColor: Colors.green,
          ),
          body: BlocBuilder<VocabulariesCubit, VocabulariesState>(
            builder: (context, state){
              if(state is VocabulariesLoaded){
                return _vocabDetails(state.vocabularies);
              }else if(state is VocabulariesLoadError){
                return Center(
                  child: Text('Something went wrong!'),
                );
              }else{
                return _loadingVocabularies();
              }
            },
          )
      ),
    );
  }

  Widget _vocabDetails(List<Vocabulary> _vocabularies){
    int numOfVocabs = _vocabularies.length;
    return Container(
      width: SizeConfig.blockSizeHorizontal * 99,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage('assets/images/vocabulary_logo.png'),
              width: 160,
              height: 160,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Lesson $title | $numOfVocabs Vocabulary ",
              style: GoogleFonts.sansita(
                textStyle: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 13,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70.0,
            child: Card(
              color: Colors.yellow[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                child: Center( child: Text(
                  'Learn Now',
                  style: GoogleFonts.sansita(
                    fontSize: 40,
                    color: Colors.white,
                  ),),),
                onTap: () => pushNewScreen(
                  context,
                  screen: VocabularyScreen(),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingVocabularies() {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ColoredCircularProgressIndicator(),
            Text(
              'Loading....',
              style: GoogleFonts.dmSans(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

}
