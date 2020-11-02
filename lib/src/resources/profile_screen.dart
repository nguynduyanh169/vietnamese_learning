import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/login_page.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = "";

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
    return FutureBuilder(
        future: _loadUsername(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 239, 215, 100),
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
                      Container(
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
                                  percent: 0.2,
                                  center: Text(
                                    "20.0%",
                                    style: TextStyle(
                                        fontSize: 9, fontFamily: 'Helvetica'),
                                  ),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Colors.blueAccent,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1.5,
                              ),
                              Container(
                                child: Text(
                                  "Learning Progress",
                                  style: TextStyle(
                                      fontSize: 10, fontFamily: 'Helvetica'),
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
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
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
                                  "3",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 25,
                                      fontFamily: 'Helvetica'),
                                ),
                                Text(
                                  "Days learn",
                                  style: TextStyle(fontFamily: 'Helvetica'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
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
                                  "1",
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
                      ),
                    ],
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
                                          leading: Icon(CupertinoIcons.reply),
                                          title: Text(
                                            "Feedback",
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
                                              Icon(CupertinoIcons.settings),
                                          title: Text(
                                            "Level",
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
                                              Icon(CupertinoIcons.bell_solid),
                                          title: Text(
                                            "Notification Setting",
                                            style: TextStyle(
                                                fontFamily: 'Helvetica'),
                                          ),
                                          trailing: Switch(
                                              value: false, onChanged: null),
                                        )),
                                    Card(
                                      color: const Color.fromRGBO(
                                          255, 190, 50, 30),
                                      child: InkWell(
                                        onTap: logout,
                                        child: ListTile(
                                          leading:
                                              Icon(CupertinoIcons.person_solid),
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
    prefs.setString('username', null);
    prefs.setString('accessToken', null);
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => new LoginPage()));
  }
}
