import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/resources/qualification_quiz.dart';
import 'package:vietnamese_learning/src/resources/quiz_screen.dart';

class LevelScreen extends StatefulWidget {
  static final String routeName = "level";

  LevelScreen({Key key}) : super(key: key);

  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  BuildContext _ctx;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _ctx = context;
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundlevel.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 8,
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Text(
                'CHOOSE YOUR LEVEL',
                style: GoogleFonts.sansita(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 130.0,
              child: Card(
                color: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    onTap: () => pushNewScreen(
                          context,
                          screen: null,
                          withNavBar: true,
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 3,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Beginner",
                                  style: GoogleFonts.sansita(
                                    fontSize: 33,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Start learning from the begin",
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 11,
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 15.5,
                              height: SizeConfig.blockSizeVertical * 10,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/owlexpertcolor.png'),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 130.0,
              child: Card(
                color: Colors.red[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    onTap: () => pushNewScreen(
                          context,
                          screen: QualificationQuiz(),
                          withNavBar: true,
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/owlwithclassescolor.png'),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeVertical * 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Advanced",
                                  style: GoogleFonts.sansita(
                                    fontSize: 33,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Test your qualification",
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
