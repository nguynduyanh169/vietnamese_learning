import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
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
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/resources/alphabet_screen.dart';
import 'package:vietnamese_learning/src/resources/lesson_detail.dart';
import 'package:vietnamese_learning/src/resources/profile_screen.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

import 'image_text_recognite.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "user";
  UserProfile userProfile = new UserProfile();
  List<Lesson> _listLessons = new List<Lesson>();

  _HomeScreenState();

  @override
  initState() {
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

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      return false;
    }else{
      return true;
    }
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
          onPressed: () async {
            bool checkInternet = await checkConnectivity();
            if(checkInternet == true){
              pushNewScreen(
                context,
                screen: DetailTranslateScreen(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.slideUp,
              );
            }else{
              Toast.show(
                  "This function required internet connection!",
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white);
            }

          },
          icon: Icon(CupertinoIcons.camera_fill),
          label: Text('Translator'),
        ),
        body: BlocConsumer<LessonsCubit, LessonsState>(
          listener: (context, state){
            if(state is ReloadingLessons){
              CustomProgressDialog.progressDialog(context);
            }else if(state is LessonsLoaded){
              userProfile = state.userProfile;
              _listLessons = state.lessons;
            }else if(state is ReloadLessonsSuccess){
              _listLessons = state.lessons;
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          builder: (context, state) {
            if (state is LessonLoadError) {
              return Center(
                child: Text(
                  'Something went wrong!',
                ),
              );
            } else if(state is LessonsLoading){
              return _loadingLessons(context);
            }else{
              return _gridLesson(_listLessons, userProfile.studentLevel, context);
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

  Widget _gridLesson(List<Lesson> _listLessons, int leveIdOfUser, BuildContext context) {
    HiveUtils _hiveUtils = new HiveUtils();
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
                            backgroundImage: FileImage(File(_hiveUtils.getFile(
                                boxName: 'CacheFile',
                                url: userProfile.avatar))),
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
            Expanded(child: gridHeader(_listLessons, context))
          ],
        ),
      ),
    ]);
  }

  Widget gridHeader(List<Lesson> _listLessons, BuildContext context) {
    List<Lesson> beginnerLessons = new List();
    List<Lesson> intermediateLessons = new List();
    List<Lesson> advancedLessons = new List();

    for (Lesson lesson in _listLessons) {
      if (lesson.levelID == 1) {
        beginnerLessons.add(lesson);
      }
      if (lesson.levelID == 2) {
        intermediateLessons.add(lesson);
      }
      if (lesson.levelID == 3) {
        advancedLessons.add(lesson);
      }
    }
    List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];
    return RefreshIndicator(
        child: ListView.separated(
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
                          children:
                              List.generate(beginnerLessons.length, (index) {
                            return CategoryCard(
                              title: beginnerLessons[index].lessonName,
                              img: beginnerLessons[index].lessonImage,
                              progressStatus: beginnerLessons[index]
                                  .progress
                                  .progresStatus
                                  .trim(),
                              press: () {
                                if (beginnerLessons[index]
                                        .progress
                                        .progresStatus
                                        .trim() ==
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
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    PageRouteBuilder(
                                      settings: RouteSettings(name: '/lessonDetail'),
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          LessonDetail(
                                            lessonName: beginnerLessons[index]
                                                .lessonName
                                                .trim(),
                                            lessonId:
                                            beginnerLessons[index].lessonID,
                                            progress:
                                            beginnerLessons[index].progress,
                                            lesson: beginnerLessons[index],
                                          ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
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
                          children: List.generate(intermediateLessons.length,
                              (index) {
                            return CategoryCard(
                              title: intermediateLessons[index].lessonName,
                              img: intermediateLessons[index].lessonImage,
                              progressStatus: intermediateLessons[index]
                                  .progress
                                  .progresStatus
                                  .trim(),
                              press: () {
                                if (intermediateLessons[index]
                                        .progress
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
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    PageRouteBuilder(
                                      settings: RouteSettings(name: '/lessonDetail'),
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          LessonDetail(
                                            lessonName: intermediateLessons[index]
                                                .lessonName
                                                .trim(),
                                            lessonId:
                                            intermediateLessons[index].lessonID,
                                            progress:
                                            intermediateLessons[index].progress,
                                            lesson: intermediateLessons[index],
                                          ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
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
                          children:
                              List.generate(advancedLessons.length, (index) {
                            return CategoryCard(
                              title: advancedLessons[index].lessonName,
                              img: advancedLessons[index].lessonImage,
                              progressStatus: advancedLessons[index]
                                  .progress
                                  .progresStatus
                                  .trim(),
                              press: () {
                                if (advancedLessons[index]
                                        .progress
                                        .progresStatus
                                        .trim() ==
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
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    PageRouteBuilder(
                                      settings: RouteSettings(name: '/lessonDetail'),
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          LessonDetail(
                                            lessonName: advancedLessons[index]
                                                .lessonName
                                                .trim(),
                                            lessonId:
                                            advancedLessons[index].lessonID,
                                            progress:
                                            advancedLessons[index].progress,
                                            lesson: advancedLessons[index],
                                          ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;
                                        var tween = Tween(
                                            begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
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
        ),
        onRefresh: () async {
          BlocProvider.of<LessonsCubit>(context).reloadLessons();
        });
  }
}
