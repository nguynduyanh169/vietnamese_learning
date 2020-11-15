import 'package:flutter/cupertino.dart';
import 'package:vietnamese_learning/src/resources/home_page.dart';
import 'package:vietnamese_learning/src/resources/intro_screen.dart';
import 'package:vietnamese_learning/src/resources/level_screen.dart';
import 'package:vietnamese_learning/src/resources/login_page.dart';
import 'package:vietnamese_learning/src/resources/quiz_getstarted.dart';

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/level': (BuildContext context) => new LevelScreen(),
  '/': (BuildContext context) => new IntroScreen(),
};
