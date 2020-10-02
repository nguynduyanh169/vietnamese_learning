import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/widgets/sign_in_button.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Container(
        alignment: Alignment.center,
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            width: SizeConfig.blockSizeHorizontal * 35,
                            height: 130.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new ExactAssetImage(
                                    'assets/images/profile.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 90.0, right: 100.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 25.0,
                              child: new Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  margin: const EdgeInsets.only(left: 100.0),
                  child: Text(
                    "Hồ Quang Bảo",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 3.0),
                child: ListTile(
                  title: new LinearPercentIndicator(
                    width: SizeConfig.blockSizeHorizontal * 80,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    percent: 0.2,
                    center: Text("20.0%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.blueAccent,
                  ),
                  subtitle: Text('Learning Progress'),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 26.3,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 25),
                                ),
                                Text("Days learn")
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
                            width: SizeConfig.blockSizeHorizontal * 26.3,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 25),
                                ),
                                Text("Practice done")
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
                            width: SizeConfig.blockSizeHorizontal * 26.3,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "140",
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 25),
                                ),
                                Text("Stars")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 26.3,
                      height: 450,
                      child: Column(
                        children: <Widget>[
                          Card(
                              child: ListTile(
                                leading: Icon(Icons.feedback),
                                title: Text("Feedback"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              )),
                          Card(
                              child: ListTile(
                                leading: Icon(Icons.language),
                                title: Text("Language"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              )),
                          Card(
                              child: ListTile(
                                leading: Icon(Icons.notifications),
                                title: Text("Notification Setting"),
                                trailing: Switch(value: false, onChanged: null),
                              )),
                          Card(
                              child: ListTile(
                                leading: Icon(Icons.perm_identity),
                                title: Text("Sign out"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              )),
                        ],
                      ),
                    )
                ),
              ),

            ],
          ),
        ));
  }
}
