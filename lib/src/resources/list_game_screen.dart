
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/game_screen.dart';

class ListGameScreen extends StatefulWidget{

  ListGameScreen({Key key}) : super(key:key);

  @override
  _ListGameScreenState createState() => _ListGameScreenState();

}

class _ListGameScreenState extends State<ListGameScreen>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 7),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text('Game', style: GoogleFonts.sansita(
                      fontSize: 20,
                    ),),
                    SizedBox(height: SizeConfig.blockSizeVertical* 5,),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 85,
                      height: SizeConfig.blockSizeVertical * 30,
                      child: InkWell(
                        child: Card(
                          color: Colors.green,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 2),
                                  child: Text(
                                    'Matching game',
                                    style: GoogleFonts.sansita(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        onTap: () => pushNewScreen(context,
                            screen: GameScreen(),
                            withNavBar: false,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 85,
                      height: SizeConfig.blockSizeVertical * 30,
                      child: InkWell(
                        child: Card(
                          color: Colors.amberAccent,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 2),
                                  child: Text(
                                    'Card game',
                                    style: GoogleFonts.sansita(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
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