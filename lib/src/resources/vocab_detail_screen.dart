import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/presenters/vocabulary_screen_presenter.dart';
import 'package:vietnamese_learning/src/resources/vocabulary_screen.dart';
import 'package:vietnamese_learning/src/resources/writing_vocab_screen.dart';

class VocabDetailScreen extends StatefulWidget {
  String lessonId;
  String lessonName;
  VocabDetailScreen({Key key, this.lessonId, this.lessonName}) : super(key: key);

  _VocabDetailScreenState createState() => _VocabDetailScreenState(lessonId: lessonId, title: lessonName);
}

class _VocabDetailScreenState extends State<VocabDetailScreen> implements VocabularyScreenContract {
  bool isLoading = true;
  List<Vocabulary> _vocabularies;
  VocabularyScreenPresenter _presenter;
  String lessonId;
  String title;

  _VocabDetailScreenState({this.lessonId, this.title}){
    _presenter = new VocabularyScreenPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVocabularies();
  }

  void _loadVocabularies(){
    _presenter.loadVocabularyByLessonId(lessonId);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
        body: isLoading == true ? _loadingVocabularies() : _VocabDetails()
    );
  }

  Widget _VocabDetails(){
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
                  'FlashCard',
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
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
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
                  child: Center(child: Text('Writing',
                    style: GoogleFonts.sansita(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),),
                  onTap: () => pushNewScreen(
                    context,
                    screen: WritingVocabScreen(),
                  )),
            ),)
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

  @override
  void onLoadVocabularyError(String error) {
    print(error);
  }

  @override
  void onLoadVocabularySuccess(List<Vocabulary> vocabularies) {
    print('success');
    setState(() {
      isLoading = false;
      _vocabularies = vocabularies;
    });
  }
}
