import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class SetupScheduleScreen extends StatefulWidget{
  SetupScheduleScreen({Key key}): super(key: key);

  _SetupScheduleState createState() => new _SetupScheduleState();
}

class _SetupScheduleState extends State<SetupScheduleScreen>{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  TextEditingController _txtTime ;
  String time;

  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool iosStyle = true;
  Time setupTime;
  bool isSetup = false;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Future<void> _loadSettingTime() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    String previousTime = prefs.getString(username + 'schedule');
    if(previousTime == '' || previousTime == null){
      setupTime = new Time(10, 0, 0);
      showDailyAtTime(setupTime);
      setState(() {
        _txtTime.text = setupTime.hour.toString() + ':' + setupTime.minute.toString().padLeft(2, '0');
      });
    }else{
      _txtTime.text = previousTime;
    }
  }

  @override
  void initState() {
    _txtTime = new TextEditingController();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(
        initSettings);
    _loadSettingTime();
    super.initState();
  }

  Future<void> showDailyAtTime(Time time) async {
    print(time.minute);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Study time',
      'Hey! Time for study Vietnamese',
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    prefs.setString(username + 'schedule', time.hour.toString() +':'+ time.minute.toString().padLeft(2,'0'));
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 15,),
                Text(
                  'Set up your schedule',
                  style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 20,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Setup schedule",
                style: TextStyle(fontFamily: 'Helvetica'),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextFormField(
                onTap: (){
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time,
                      onChange: onTimeChanged,
                      minuteInterval: MinuteInterval.ONE,
                      disableHour: false,
                      disableMinute: false,
                      minMinute: 7,
                      maxMinute: 56,
                      // Optional onChange to receive value as DateTime
                      onChangeDateTime: (DateTime dateTime) {
                        setState(() {
                          isSetup = true;
                          _txtTime.text = dateTime.hour.toString() + ":" + dateTime.minute.toString().padLeft(2, '0');
                        });
                        setupTime = new Time(dateTime.hour, dateTime.minute, 0);
                      },
                    ),
                  );
                },
                readOnly: true,
                controller: _txtTime,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: const Color.fromRGBO(230, 172, 0, 10),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Choose schedule time',
                  labelStyle: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    CupertinoIcons.clock_fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 4,),
            ButtonTheme(
              buttonColor: Color.fromRGBO(255, 190, 51, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: FlatButton(
                  color: Color.fromRGBO(255, 190, 51, 30),
                  onPressed: () {
                    if(isSetup == true) {
                      showDailyAtTime(setupTime);
                    }else{
                      null;
                    }
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    height: SizeConfig.blockSizeVertical * 8,
                    child: Center(
                      child: Text(
                        'Set up time',
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }


}