import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/route.dart';
import 'package:vietnamese_learning/src/utils/messaging_utils.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(SaveProgressLocalAdapter());
  Hive.registerAdapter(ResponseAPIAdapter());
  await Hive.openBox(HiveBoxName.JSON_BOX);
  await Hive.openBox(HiveBoxName.CACHE_FILE_BOX);
  await Hive.openBox(HiveBoxName.PROGRESS_BOX);
  runApp(MyApp());
}


class MyApp extends StatefulWidget{

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    final Messaging _notification = Messaging();
    _notification.initialise();
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Vietnamese Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
