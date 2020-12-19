import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/resources/edit_profile.dart';
import 'package:vietnamese_learning/src/resources/login_page.dart';
import 'package:vietnamese_learning/src/utils/firebase_util.dart';

class ProfileScreen extends StatefulWidget {
  UserProfile userProfile;
  ProfileScreen({Key key, this.userProfile}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(userProfile: userProfile);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = "";
  bool isSwitch = false;
  UserProfile userProfile;

  _ProfileScreenState({this.userProfile});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  BuildContext _ctx;

  Future<void> _loadUsername() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _username = sharedPreferences.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
    return FutureBuilder(
        future: _loadUsername(),
        builder: (context, snapshot) {
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
                        backgroundImage: NetworkImage(userProfile.avatar),
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
                                  '$_username',
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
                                  progressColor: Colors.amberAccent,
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
                                            "Notification Setting",
                                            style: TextStyle(
                                                fontFamily: 'Helvetica'),
                                          ),
                                          trailing: Switch(
                                              value: isSwitch,
                                              onChanged: (value) {
                                                isSwitch = value;
                                                print(isSwitch);
                                              }),
                                        )),
                                    Card(
                                      color: const Color.fromRGBO(
                                          255, 190, 50, 30),
                                      child: InkWell(
                                        onTap: logout,
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
        });
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('accessToken');
    prefs.remove(_username + 'profile');
    prefs.remove(_username  + "SearchHistory");
    signOutUser();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
