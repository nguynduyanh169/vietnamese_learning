import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/memory_game.dart';
import 'package:vietnamese_learning/src/resources/memory_game_level.dart';

class GameResult extends StatelessWidget {
  const GameResult({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(top: 40),
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeVertical * 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text(
              "Game Over",
              style: GoogleFonts.sansita(
                fontSize: 35,
                color: Colors.brown,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text(
              "You Lose",
              style: GoogleFonts.sansita(
                fontSize: 25,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/tryagain.png',),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 10,
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 190, 51, 1),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black54,
                    ),
                    iconSize: 50,
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MemoryGamePage(),
                          ))
                    },
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 23,
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 190, 51, 1),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.list,
                      color: Colors.black54,
                    ),
                    iconSize: 50,
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MemoryGameLevelPage(),
                          ))
                    },
                  ),
                )
              ],
            )
          ],
        ));
  }
}
