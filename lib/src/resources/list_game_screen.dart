import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/game_screen.dart';
import 'package:vietnamese_learning/src/resources/home_screen_hangman.dart';
import 'package:vietnamese_learning/src/resources/memory_game.dart';
import 'package:vietnamese_learning/src/resources/memory_game_level.dart';
import 'package:vietnamese_learning/src/resources/new_matching_card_game.dart';
import 'package:vietnamese_learning/src/widgets/game_intro.dart';

class ListGameScreen extends StatefulWidget {
  ListGameScreen({Key key}) : super(key: key);

  @override
  _ListGameScreenState createState() => _ListGameScreenState();
}

class _ListGameScreenState extends State<ListGameScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 239, 204, 100),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 239, 215, 100),
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 239, 215, 100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(45)),
                            color: const Color.fromRGBO(255, 190, 51, 100),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    'Game',
                                    style: GoogleFonts.sansita(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '',
                                style: GoogleFonts.sansita(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),

                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 10,
                  ),

                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 8,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 85,
                    height: SizeConfig.blockSizeVertical * 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage("assets/images/matchingcard.png"),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => pushNewScreen(context,
                          screen: GameIntroScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
