import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/lessons_cubit.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/resources/lesson_detail.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Widget _gridLesson(List<Lesson> _listLessons) {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    'Lesson',
                    style: GoogleFonts.sansita(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Beginner Level',
                    style: GoogleFonts.sansita(fontSize: 15),
                  ),
                ],
              ),
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
                        pushNewScreen(context,
                            screen: LessonDetail(
                                lessonName:
                                    _listLessons[index].lessonName.trim(),
                                lessonId: _listLessons[index].lessonId),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino);
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
