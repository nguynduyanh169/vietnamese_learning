import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/presenters/home_screen_presenter.dart';
import 'package:vietnamese_learning/src/resources/lesson_detail.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeScreenContract {
  BuildContext _ctx;
  bool isLoading = true;
  List<Lesson> _listLessons;
  HomeScreenPresenter _presenter;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    loadLesson();
  }

  _HomeScreenState() {
    _presenter = new HomeScreenPresenter(this);
  }

  void loadLesson() {
    _presenter.loadLessonByLevel();
  }

  void _showSnackBar(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blue,
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _ctx = context;
    return Scaffold(
      key: scaffoldKey,
      body: isLoading == true ? _loadingLessons() : _GridLesson(),
    );
  }

  Widget _loadingLessons() {
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

  Widget _GridLesson() {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              child: Image(
                  width: 50,
                  height: 50,
                  image: AssetImage('assets/images/VLwithout.png')),
            ),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: .85,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: List.generate(_listLessons.length, (index) {
                    return CategoryCard(
                        title: _listLessons[index].lessonName,
                        svgSrc: _listLessons[index].lessonImage,
                        press: () => pushNewScreen(context,
                            screen: LessonDetail(lessonName: _listLessons[index].lessonName.trim(),),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino));
                  })),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  void onLoadLessonError(String errorText) {
    print(errorText);
  }

  @override
  void onLoadLessonSuccess(List<Lesson> listLessons) {
    setState(() {
      isLoading = false;
      _listLessons = listLessons;
    });
  }
}
