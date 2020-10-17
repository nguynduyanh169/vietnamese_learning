import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/resources/quiz_screen.dart';
import 'package:vietnamese_learning/src/widgets/quiz.dart';
import 'package:vietnamese_learning/src/widgets/quiz1.dart';

class QuizGetStarted extends StatefulWidget {
  QuizGetStarted({Key key}) : super(key: key);

  _QuizGetStartedState createState() => _QuizGetStartedState();
}

class _QuizGetStartedState extends State<QuizGetStarted> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: Text(
            "Quiz",
            style: TextStyle(color: Colors.white70),
          ),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white70),  onPressed: () => Navigator.of(context).pop(),),
          backgroundColor: Colors.lightBlue,
          shadowColor: Colors.lightBlue,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 50, left: 77, right: 80),
              width: SizeConfig.blockSizeHorizontal * 60,
              child: Image(
                image: AssetImage('assets/images/quiz_logo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Lesson 1: Greeting",
                style: GoogleFonts.sansita(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  "Quiz 1 | 20pts | 10 Questions",
                  style: GoogleFonts.sansita(
                    textStyle: TextStyle(
                    fontSize: 16,
                    ),
                  ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 15,),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              height: 80.0,
              child : Card(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Quiz Now",
                              style: GoogleFonts.sansita(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
