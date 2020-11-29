import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/lessons_cubit.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/resources/lesson_detail.dart';
import 'package:vietnamese_learning/src/resources/profile_screen.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';
import 'package:vietnamese_learning/src/widgets/searchbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "user";

  @override
  void initState() {
    _loadUsername();
    super.initState();
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
    return BlocProvider(
      create: (context) =>
          LessonsCubit(LessonRepository())..loadLessonByLevel(),
      child: Scaffold(
        body: BlocBuilder<LessonsCubit, LessonsState>(
          builder: (context, state) {
            if (state is LessonsLoaded) {
              return _gridLesson(state.lessons);
            } else if (state is LessonLoadError) {
              return Center(
                child: Text(
                  'Something went wrong!',
                ),
              );
            } else {
              return _loadingLessons(context);
            }
          },
        ),
      ),
    );
  }

  Widget _loadingLessons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 239, 215, 100),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridLesson(List<Lesson> _listLessons) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 239, 215, 100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(45)),
                color: const Color.fromRGBO(255, 190, 51, 100),
              ),
              alignment: Alignment.center,
              child: Container(
                height: 140,
              ),
              // child: Column(
              //   children: <Widget>[
              //     Text(
              //       'Lesson',
              //       style: GoogleFonts.sansita(
              //         fontSize: 20,
              //       ),
              //     ),
              //     Text(
              //       'Beginner Level',
              //       style: GoogleFonts.sansita(fontSize: 15),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeVertical * 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back, $username",
                        style: GoogleFonts.crimsonText(
                            fontSize: 27, color: Colors.orange[900]),
                      ),
                      Text(
                        " Your Level: Beginner",
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 19,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeVertical * 3,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                        image: AssetImage('assets/images/profile.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 5,
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
                      img: _listLessons[index].lessonImage,
                      progressStatus: _listLessons[index].progressStatus.trim(),
                      press: () {
                        if (_listLessons[index].progressStatus.trim() ==
                            "lock") {
                          String lessonBefore =
                              _listLessons[index - 1].lessonName;
                          Toast.show(
                              "You must finish lesson $lessonBefore!", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM,
                              backgroundColor: Colors.blueAccent,
                              textColor: Colors.white);
                        } else {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) => LessonDetail(
                                lessonName:
                                    _listLessons[index].lessonName.trim(),
                                lessonId: _listLessons[index].lessonId,
                                progressId: _listLessons[index].progressId,
                              ),
                              settings: RouteSettings(name: '/lessonDetail'),
                            ),
                          );
                        }
                      },
                    );
                  })),
            ),
          ],
        ),
      ),
    ]);
  }
}
