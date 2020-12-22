import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/lessons_cubit.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/resources/alphabet_screen.dart';
import 'package:vietnamese_learning/src/resources/lesson_detail.dart';
import 'package:vietnamese_learning/src/resources/profile_screen.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';
import 'package:vietnamese_learning/src/widgets/searchbar.dart';

import 'image_text_recognite.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "user";
  UserProfile userProfile = new UserProfile();

  _HomeScreenState();

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
        floatingActionButton: FloatingActionButton.extended(
          heroTag: Uuid(),
          onPressed: () => pushNewScreen(
            context,
            screen: DetailTranslateScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.slideUp,
          ),
          icon: Icon(CupertinoIcons.camera_fill),
          label: Text('Translate'),
        ),
        body: BlocBuilder<LessonsCubit, LessonsState>(
          builder: (context, state) {
            if (state is LessonsLoaded) {
              userProfile = state.userProfile;
              print(userProfile.toJson());
              return _gridLesson(state.lessons, userProfile.studentLevel);
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

  Widget _gridLesson(List<Lesson> _listLessons, int leveIdOfUser) {
    String levelOfUser;
    if (leveIdOfUser == 1) {
      levelOfUser = 'Beginner';
    }
    if (leveIdOfUser == 2) {
      levelOfUser = 'Intermediate';
    }
    if (leveIdOfUser == 3) {
      levelOfUser = 'Advanced';
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, $username",
                        style: GoogleFonts.crimsonText(
                            fontSize: 27, color: Colors.orange[900]),
                      ),
                      Text(
                        "Your Level: $levelOfUser",
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 19,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: SizeConfig.blockSizeVertical * 3,
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(userProfile: userProfile)));
                    },
                    child: userProfile.avatar != null
                        ? CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(userProfile.avatar),
                            backgroundColor: Colors.transparent,
                          )
                        : Container(
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
              height: SizeConfig.blockSizeHorizontal * 8,
            ),
            Expanded(child: gridHeader(_listLessons))
          ],
        ),
      ),
    ]);
  }

  Widget gridHeader(List<Lesson> _listLessons) {
    List<Lesson> beginnerLessons = new List();
    List<Lesson> intermediateLessons = new List();
    List<Lesson> advancedLessons = new List();

    for (Lesson lesson in _listLessons) {
      if (lesson.levelId == 1) {
        beginnerLessons.add(lesson);
      }
      if (lesson.levelId == 2) {
        intermediateLessons.add(lesson);
      }
      if (lesson.levelId == 3) {
        advancedLessons.add(lesson);
      }
    }
    List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: SizeConfig.blockSizeVertical * 1.5,
      ),
      itemCount: levels.length,
      itemBuilder: (context, index) {
        if (index == 0 && beginnerLessons.isNotEmpty) {
          return Container(
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    pushNewScreen(context,
                        screen: AlphabetScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideUp);
                  },
                  child: Container(width: 20, height: 20, color: Colors.red),
                ),
                Text(
                  'Beginner',
                  style: GoogleFonts.nunito(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  //textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 90,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: List.generate(beginnerLessons.length, (index) {
                        return CategoryCard(
                          title: beginnerLessons[index].lessonName,
                          img: beginnerLessons[index].lessonImage,
                          progressStatus:
                              beginnerLessons[index].progresStatus.trim(),
                          press: () {
                            if (beginnerLessons[index].progresStatus.trim() ==
                                "lock") {
                              String lessonBefore =
                                  beginnerLessons[index - 1].lessonName;
                              Toast.show(
                                  "You must finish lesson $lessonBefore!",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor: Colors.blueAccent,
                                  textColor: Colors.white);
                            } else {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => LessonDetail(
                                    lessonName: beginnerLessons[index]
                                        .lessonName
                                        .trim(),
                                    lessonId: beginnerLessons[index].lessonId,
                                    progressId:
                                        beginnerLessons[index].progressId,
                                  ),
                                  settings:
                                      RouteSettings(name: '/lessonDetail'),
                                ),
                              );
                            }
                          },
                        );
                      })),
                )
              ],
            ),
          );
        } else if (index == 1 && intermediateLessons.isNotEmpty) {
          return Container(
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Intermediate',
                  style: GoogleFonts.nunito(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 90,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children:
                          List.generate(intermediateLessons.length, (index) {
                        return CategoryCard(
                          title: intermediateLessons[index].lessonName,
                          img: intermediateLessons[index].lessonImage,
                          progressStatus:
                              intermediateLessons[index].progresStatus.trim(),
                          press: () {
                            if (intermediateLessons[index]
                                    .progresStatus
                                    .trim() ==
                                "lock") {
                              String lessonBefore =
                                  intermediateLessons[index - 1].lessonName;
                              Toast.show(
                                  "You must finish lesson $lessonBefore!",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor: Colors.blueAccent,
                                  textColor: Colors.white);
                            } else {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => LessonDetail(
                                    lessonName: intermediateLessons[index]
                                        .lessonName
                                        .trim(),
                                    lessonId:
                                        intermediateLessons[index].lessonId,
                                    progressId:
                                        intermediateLessons[index].progressId,
                                  ),
                                  settings:
                                      RouteSettings(name: '/lessonDetail'),
                                ),
                              );
                            }
                          },
                        );
                      })),
                )
              ],
            ),
          );
        } else if (index == 2 && advancedLessons.isNotEmpty) {
          return Container(
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Advanced',
                  style: GoogleFonts.nunito(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 90,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: List.generate(advancedLessons.length, (index) {
                        return CategoryCard(
                          title: advancedLessons[index].lessonName,
                          img: advancedLessons[index].lessonImage,
                          progressStatus:
                              advancedLessons[index].progresStatus.trim(),
                          press: () {
                            if (advancedLessons[index].progresStatus.trim() ==
                                "lock") {
                              String lessonBefore =
                                  advancedLessons[index - 1].lessonName;
                              Toast.show(
                                  "You must finish lesson $lessonBefore!",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor: Colors.blueAccent,
                                  textColor: Colors.white);
                            } else {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => LessonDetail(
                                    lessonName: advancedLessons[index]
                                        .lessonName
                                        .trim(),
                                    lessonId: advancedLessons[index].lessonId,
                                    progressId:
                                        advancedLessons[index].progressId,
                                  ),
                                  settings:
                                      RouteSettings(name: '/lessonDetail'),
                                ),
                              );
                            }
                          },
                        );
                      })),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
      shrinkWrap: true,
    );
  }
}
