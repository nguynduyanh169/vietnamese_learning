import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/resources/quiz_screen.dart';

class QuizGetStarted extends StatefulWidget {
  QuizGetStarted({Key key}) : super(key: key);

  _QuizGetStartedState createState() => _QuizGetStartedState();
}

class _QuizGetStartedState extends State<QuizGetStarted> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Quiz',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Helvetica',
                  ),
                )
              ],
            ),
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
                "Lesson Greeting",
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
            SizedBox(
              height: SizeConfig.blockSizeVertical * 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              height: 80.0,
              child: Card(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    onTap: () {
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
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
