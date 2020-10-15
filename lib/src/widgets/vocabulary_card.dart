import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class VocabularyCard extends StatelessWidget {
  final String english;
  final String vietnamese;
  final Function nextHandler;
  final String img;

  VocabularyCard({this.english, this.vietnamese, this.img , this.nextHandler});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlipCard(
          front: Container(
            width: SizeConfig.blockSizeHorizontal * 85,
            height: SizeConfig.blockSizeVertical * 58,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 40,
                    height: SizeConfig.blockSizeVertical * 30,
                    child: Image.asset('$img'),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4,
                  ),
                  Text(
                    '$vietnamese',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(fontSize: 25)
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: ClipOval(
                          child: Container(
                            color: Colors.amberAccent,
                            width: SizeConfig.blockSizeHorizontal * 18,
                            height: SizeConfig.blockSizeVertical * 10,
                            child: Center(
                              child: Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print('Sound');
                        },
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 30,
                      ),
                      InkWell(
                        child: ClipOval(
                          child: Container(
                            color: Colors.amberAccent,
                            width: SizeConfig.blockSizeHorizontal * 18,
                            height: SizeConfig.blockSizeVertical * 10,
                            child: Center(
                              child: Icon(
                                Icons.mic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print('Micro');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          back: Container(
            width: SizeConfig.blockSizeHorizontal * 85,
            height: SizeConfig.blockSizeVertical * 58,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 10,
                  ),
                  Container(
                    child: Text('$vietnamese', style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 30))),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Text(
                    '$english (n)',
                    style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 25)),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: ClipOval(
                          child: Container(
                            color: Colors.amberAccent,
                            width: SizeConfig.blockSizeHorizontal * 18,
                            height: SizeConfig.blockSizeVertical * 10,
                            child: Center(
                              child: Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print('Sound');
                        },
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 30,
                      ),
                      InkWell(
                        child: ClipOval(
                          child: Container(
                            color: Colors.amberAccent,
                            width: SizeConfig.blockSizeHorizontal * 18,
                            height: SizeConfig.blockSizeVertical * 10,
                            child: Center(
                              child: Icon(
                                Icons.mic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print('Micro');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          direction: FlipDirection.HORIZONTAL,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Text(
          'Touch to flip card',
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(fontSize: 24)
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        ButtonTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: RaisedButton(
              onPressed: nextHandler,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 8,
                child: Center(
                  child: Text(
                    'Continue',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(fontSize: 25, color: Colors.white)
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
