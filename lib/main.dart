import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/route.dart';
import 'package:vietnamese_learning/src/utils/messaging_utils.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(ResponseAPIAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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
