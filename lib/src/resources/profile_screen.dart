import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/profile_cubit.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/resources/change_password.dart';
import 'package:vietnamese_learning/src/resources/edit_profile.dart';
import 'package:vietnamese_learning/src/resources/login_page.dart';
import 'package:vietnamese_learning/src/resources/setup_schedule.dart';
import 'package:vietnamese_learning/src/states/change_password_state.dart';
import 'package:vietnamese_learning/src/states/profile_state.dart';
import 'package:vietnamese_learning/src/utils/firebase_util.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

class ProfileScreen extends StatefulWidget {
  UserProfile userProfile;
  ProfileScreen({Key key, this.userProfile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(userProfile: userProfile);
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitch = false;
  UserProfile userProfile;

  HiveUtils _hiveUtils = new HiveUtils();

  _ProfileScreenState({this.userProfile});
  @override
  void initState() {
    super.initState();
  }
  BuildContext _ctx;

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
    _ctx = context;
    String level;
    if(userProfile.studentLevel == 1){
      level = "Beginner";
    }if(userProfile.studentLevel == 2){
      level = "Intermediate";
    }if(userProfile.studentLevel == 3){
      level = "Advanced";
    }
    return BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state){
            if(state is LoggingOut){
              CustomProgressDialog.progressDialog(context);
            }else if(state is LogoutSuccess){
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
            }else if(state is LogoutFailed){
              Navigator.pop(context);
              Toast.show(state.message, context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white);
            }
          },
          builder: (context, state){
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 239, 204, 100),
                ),
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 7,
                    ),
                    Row(
                      children: <Widget>[
                        userProfile.avatar != null ? CircleAvatar(
                          radius: 40.0,
                          backgroundImage: FileImage(
                               File(
                                  _hiveUtils.getFile(
                                      boxName: 'CacheFile',
                                      url: userProfile.avatar))
                          ),
                          backgroundColor: Colors.transparent,
                        )
                            : Container(
                            width: SizeConfig.blockSizeHorizontal * 25,
                            height: SizeConfig.blockSizeVertical * 14,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new ExactAssetImage(
                                    'assets/images/profile.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    userProfile.username,
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'Helvetica'),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2,
                                ),
                                Container(
                                  child: new LinearPercentIndicator(
                                    width: SizeConfig.blockSizeHorizontal * 58,
                                    animation: true,
                                    lineHeight: 15.0,
                                    animationDuration: 1000,
                                    percent: userProfile.userProgress / 100,
                                    center: Text(
                                      "${userProfile.userProgress}%",
                                      style: TextStyle(
                                          fontSize: 9, fontFamily: 'Helvetica'),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1.5,
                                ),
                                Container(
                                  child: Text(
                                    "Learning Progress",
                                    style: TextStyle(
                                        fontSize: 12, fontFamily: 'Helvetica'),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1),
                                ),
                              ]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 190, 51, 60),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: SizeConfig.blockSizeHorizontal * 40,
                            height: SizeConfig.blockSizeVertical * 15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  level,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontFamily: 'Helvetica'),
                                ),
                                SizedBox(height: SizeConfig.blockSizeVertical * 0.5,),
                                Text(
                                  "Level",
                                  style: TextStyle(fontFamily: 'Helvetica'),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 190, 51, 60),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: SizeConfig.blockSizeHorizontal * 40,
                            height: SizeConfig.blockSizeVertical * 15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${userProfile.progressFinish}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      fontFamily: 'Helvetica'),
                                ),
                                Text(
                                  "Lessons done",
                                  style: TextStyle(fontFamily: 'Helvetica'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 3,
                                    right: SizeConfig.blockSizeHorizontal * 3),
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 50,
                                  height: SizeConfig.blockSizeVertical * 50,
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                          color: const Color.fromRGBO(
                                              255, 190, 50, 30),
                                          child: ListTile(
                                            leading: Icon(CupertinoIcons.pencil),
                                            title: Text(
                                              "Edit Profile",
                                              style: TextStyle(
                                                  fontFamily: 'Helvetica'),
                                            ),
                                            trailing:
                                            Icon(CupertinoIcons.forward),
                                            onTap: () => pushNewScreen(context,
                                                screen: EditProfileScreen(),
                                                withNavBar: false,
                                                pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .slideUp),
                                          )),
                                      Card(
                                          color: const Color.fromRGBO(
                                              255, 190, 50, 30),
                                          child: ListTile(
                                            onTap: (){
                                              pushNewScreen(context,
                                                  screen: ChangePasswordScreen(email: userProfile.email, username: userProfile.username,),
                                                  withNavBar: false,
                                                  pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .slideUp);
                                            },
                                            leading:
                                            Icon(CupertinoIcons.lock_fill),
                                            title: Text(
                                              "Change Password",
                                              style: TextStyle(
                                                  fontFamily: 'Helvetica'),
                                            ),
                                            trailing:
                                            Icon(CupertinoIcons.forward),
                                          )),
                                      Card(
                                          color: const Color.fromRGBO(
                                              255, 190, 50, 30),
                                          child: ListTile(
                                            leading:
                                            Icon(CupertinoIcons.bell_fill),
                                            title: Text(
                                              "Reminder setting",
                                              style: TextStyle(
                                                  fontFamily: 'Helvetica'),
                                            ),
                                            trailing: Icon(CupertinoIcons.forward),
                                            onTap: (){
                                              pushNewScreen(context,
                                                  screen: SetupScheduleScreen(),
                                                  withNavBar: false,
                                                  pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .slideUp);
                                            },
                                          )),
                                      Card(
                                        color: const Color.fromRGBO(
                                            255, 190, 50, 30),
                                        child: InkWell(
                                          onTap: (){
                                            BlocProvider.of<ProfileCubit>(context).logout(userProfile.username);
                                          },
                                          child: ListTile(
                                            leading: Icon(CupertinoIcons.person),
                                            title: Text("Sign out"),
                                            trailing:
                                            Icon(CupertinoIcons.forward),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
    );
  }

}
