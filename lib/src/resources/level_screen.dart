import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/progress_cubit.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/models/entrance_quiz.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/resources/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/resources/entrance_quiz_screen.dart';
import 'package:vietnamese_learning/src/resources/quiz_screen.dart';
import 'package:vietnamese_learning/src/states/progress_state.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

class LevelScreen extends StatefulWidget {
  static final String routeName = "level";
  LoginResponse loginResponse;
  String username;

  LevelScreen({Key key, this.loginResponse, this.username}) : super(key: key);

  _LevelScreenState createState() => _LevelScreenState(loginResponse: loginResponse, username: username);
}

class _LevelScreenState extends State<LevelScreen> {
  BuildContext _ctx;
  LoginResponse loginResponse;
  String username;

  _LevelScreenState({this.loginResponse, this.username});
  void submit(int levelId, BuildContext context){
    BlocProvider.of<ProgressCubit>(context).createProgress(levelId, loginResponse, username);
  }

  void loadEntranceQuiz(BuildContext context){
    BlocProvider.of<ProgressCubit>(context).loadEntranceQuiz();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _ctx = context;
    SizeConfig().init(context);
    return BlocProvider(
        create: (context) => ProgressCubit(ProgressRepository()),
      child: Scaffold(
        body: BlocConsumer<ProgressCubit, ProgressState>(
          listener: (context, state){
            if(state is CreatingProgress){
              CustomProgressDialog.progressDialog(context);
            }else if(state is CreateProgressSuccess){
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
            }else if(state is LoadedEntranceQuiz){
              Navigator.pop(context);
              List<EntranceQuiz> entranceQuizzes = state.entranceQuizzes;
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                          EntranceQuizScreen(entranceQuizzes: entranceQuizzes, loginResponse: loginResponse, username: username,),
                  transitionsBuilder: (context, animation,
                      secondaryAnimation, child) {
                    var begin = Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            }else if(state is LoadingEntranceQuiz){
              CustomProgressDialog.progressDialog(context);
            }
          },
          builder: (context, state){
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/backgroundlevel.png"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 8,
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      'SET UP YOUR LEVEL',
                      style: GoogleFonts.sansita(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 130.0,
                    child: Card(
                      color: Colors.yellow[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                          onTap: () {
                            int levelId = 1;
                            submit(levelId, context);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 3,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Beginner",
                                        style: GoogleFonts.sansita(
                                          fontSize: 33,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Start learning from the begin",
                                        style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 11,
                                  ),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 15.5,
                                    height: SizeConfig.blockSizeVertical * 10,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/owlwithclassescolor.png'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 130.0,
                    child: Card(
                      color: Colors.red[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                          onTap: () {
                            loadEntranceQuiz(context);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/owlexpertcolor.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeVertical * 4,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Entrance Quiz",
                                        style: GoogleFonts.sansita(
                                          fontSize: 33,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Do a quiz to identify your level",
                                        style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
