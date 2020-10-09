import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/resources/quiz_screen.dart';

class LessonDetail extends StatefulWidget {
  LessonDetail({Key key}) : super(key: key);

  @override
  _LessonDetailState createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 15.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop(),),
                  Text("Introduction", style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40.0),
              height: 500, // card height
              child: PageView(
                controller: PageController(viewportFraction: 0.7),
                children: <Widget>[
                  Card(
                    color: Colors.green,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Vocabulary',
                          style: GoogleFonts.sansita(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Image(
                          image: AssetImage('assets/images/vocabulary_logo.png'),
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.greenAccent,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.play_arrow),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        QuizScreen(),
                                    transitionsBuilder:
                                        (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Vocabulary is the key to mastering a language',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]),
                  ),
                  Card(
                    color: Colors.amberAccent,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Conversation',
                          style: GoogleFonts.sansita(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Image(
                          image: AssetImage('assets/images/conversation_logo.png'),
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.amber,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.play_arrow),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Conversation makes you feel more confident',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]),
                  ),
                  Card(
                    color: Colors.lightBlue,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Quiz',
                          style: GoogleFonts.sansita(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Image(
                          image: AssetImage('assets/images/quiz_logo.png'),
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.blueAccent,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.play_arrow),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        QuizScreen(),
                                    transitionsBuilder:
                                        (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 4.0, right: 4.0),
                        child: Text(
                          'Do the quiz to test your memory',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
