import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelScreen extends StatefulWidget {
  LevelScreen({Key key}) : super(key: key);

  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 30,
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 80.0,
              child : Card(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () => pushNewScreen(
                      context,
                      screen: HomeScreen(),
                      withNavBar: true,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "Beginner",
                          style: GoogleFonts.sansita(
                            fontSize: 45,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/rocket.png"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ),
            ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 80.0,
            child: Card(
              color: Colors.yellow[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        "Intermediate",
                        style: GoogleFonts.sansita(
                          fontSize: 45,
                          color: Colors.white,
                        )
                    ),
                  ],
                )
            ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 80.0,
            child: Card(
                color: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                        "Advanced",
                        style: GoogleFonts.sansita(
                          fontSize: 45,
                          color: Colors.white,
                        ),
                    ),
                  ],
                )
            ),
            )
          ],
        ),
      ),
    );
  }
}
