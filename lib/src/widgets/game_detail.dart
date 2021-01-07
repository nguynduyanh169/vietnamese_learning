import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/resources/memory_game_level.dart';
import 'package:vietnamese_learning/src/resources/new_matching_card_game.dart';

import '../config/size_config.dart';

class GameDetail extends StatefulWidget {
  @override
  _GameDetailState createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 239, 215, 1)
        ),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
              child: Text(
                "Matching Card",
                style: GoogleFonts.modak(
                  textStyle: TextStyle(
                    color: Colors.yellow[900],
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              "M    E    M    O    R    Y        G    A    M    E",
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow[900],
                fontWeight: FontWeight.w100,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 15,
            ),
            InkWell(
              onTap: () {
                pushNewScreen(context,
                    screen: NewMatchingGame(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: 300,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(255, 198, 26, 60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow[900],
                  ),
                  child: Center(
                    child: Text(
                      "START GAME",
                      style: GoogleFonts.teko(
                        textStyle: TextStyle(
                          color: Color.fromRGBO(255, 204, 51, 1),
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.all(8),
                width: 300,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(255, 198, 26, 60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow[900],
                  ),
                  child: Center(
                    child: Text(
                      "BACK",
                      style: GoogleFonts.teko(
                        textStyle: TextStyle(
                          color: Color.fromRGBO(255, 204, 51, 1),
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
