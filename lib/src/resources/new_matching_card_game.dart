import 'dart:async';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/game_cubit.dart';
import 'package:vietnamese_learning/src/models/memory_model.dart';
import 'package:vietnamese_learning/src/data/game_data.dart';
import 'package:vietnamese_learning/src/states/game_state.dart';
import 'package:vietnamese_learning/src/widgets/game_result.dart';

class NewMatchingGame extends StatefulWidget {
  @override
  _NewMatchingGameState createState() => _NewMatchingGameState();
}

class _NewMatchingGameState extends State<NewMatchingGame> {
  List<TileModel> gridViewTiles = new List<TileModel>();
  List<TileModel> questionPairs = new List<TileModel>();
  List<TileModel> getFromAPi = new List<TileModel>();

  int time = 60;
  Timer timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (this.mounted) {
        setState(() {
          if (time > 0) {
            time--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myPairs = new List<TileModel>();
    selected = false;
    points = 0;
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void reStart(BuildContext context) {
    BlocProvider.of<Game_Cubit>(context).loadVocabularyByLevel();
    myPairs = new List<TileModel>();
    selected = false;
    points = 0;
    time = 60;
    startTimer();
  }


  bool checkFinish(int point){
    bool check = false;
    if(point ==800){
      timer.cancel();
      check = true;
    }
    return check;
  }
  Widget _gameDetails(List<TileModel> list, BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.blockSizeVertical * 100,
            color: Color.fromRGBO(255, 239, 215, 100),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 8,
                      ),
                      Text(
                        'Memory Card Game',
                        style: TextStyle(fontSize: 25, fontFamily: 'Helvetica'),
                      )
                    ],
                  ),
                ),
                (time > 0)
                    ? Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Time left: $time s",
                            style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w600,
                                fontSize: 25)))
                    : Center(
                        child: Text(
                          "",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 30, fontFamily: 'Helvetica'),
                        ),
                      ),
                SizedBox(height: SizeConfig.blockSizeVertical * 10),
                (time > 0) && points != 800
                    ? GridView(
                        shrinkWrap: true,
                        //physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 5.0, maxCrossAxisExtent: 120.0),
                        children: List.generate(list.length, (index) {
                          for (int i = 0; i < list.length; i++) {
                            TileModel question = new TileModel();
                            question.setImage("assets/images/question.png");
                            question.setIsSelected(false);
                            questionPairs.add(question);
                          }
                          List<String> str = generateList(list);
                          str.shuffle();

                          for (int i = 0; i < str.length; i++) {
                            TileModel tile = new TileModel();
                            tile.vocabulary = str[i];
                            tile.isSelected = false;
                            for (int j = 0; j < list.length; j++) {
                              if(list[j].description == tile.vocabulary){
                                tile.image = list[j].image;
                              }
                              if(list[j].vocabulary == tile.vocabulary){
                                tile.image = list[j].image;
                              }
                            }
                            myPairs.add(tile);
                          }
                          return Tile(
                            imagePathUrl: list[index].getImage(),
                            tileIndex: index,
                            parent: this,
                          );
                        }),
                      )
                    : checkFinish(points) ? Container(
                    child: Container(
                        margin: EdgeInsets.only(top: 10),
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
                              "Congratulation",
                              style: GoogleFonts.sansita(
                                fontSize: 35,
                                color: Colors.brown,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 1,
                            ),
                            Text(
                              "You win",
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
                                  image: AssetImage('assets/images/medal.png',),
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
                                    onPressed: () => reStart(context),
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
                                      Icons.arrow_back_rounded,
                                      color: Colors.black54,
                                    ),
                                    iconSize: 50,
                                    onPressed: () => {
                                      Navigator.pop(
                                        context,
                                      )
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ))
                ):Container(
                    margin: EdgeInsets.only(top: 10),
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
                                onPressed: () => reStart(context),
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
                                  Icons.arrow_back_rounded,
                                  color: Colors.black54,
                                ),
                                iconSize: 50,
                                onPressed: () => {
                                  Navigator.pop(
                                      context,
                                      )
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );

    
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => Game_Cubit(GameRepo())..loadVocabularyByLevel(),
      child: Scaffold(
        body: BlocBuilder<Game_Cubit, GameStates>(
          builder: (context, state) {
            if (state is GameLoaded) {
              getFromAPi = state.model;
              for (int i = 0; i < getFromAPi.length; i++) {
                if (getFromAPi[i].image == null) {
                  getFromAPi[i].image = 'abc';
                }
                getFromAPi[i].isSelected = false;
              }
              getFromAPi.shuffle();
              List<TileModel> clone = []..addAll(getFromAPi);

              var newList = [...getFromAPi, ...clone];

              return _gameDetails(newList, context);
            } else if (state is GameLoadError) {
              return Center(
                child: Text('Something went wrong'),
              );
            } else {
              return _loadingVocabulary();
            }
          },
        ),
      ),
    );
  }

  Widget _loadingVocabulary() {
    return Container(
      color: Color.fromRGBO(255, 239, 215, 100),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: 20,
            ),
            Text(
              'Loading....',
              style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
            )
          ],
        ),
      ),
    );
  }

  List<String> generateList(List<TileModel> list) {
    List<String> str = new List<String>();
    for (int i = 0; i < list.length; i++) {
      str.add(list[i].vocabulary);
      str.add(list[i].description);
    }
    var distinct = str.toSet().toList();
    // for(int i=0; i<distinct.length; i++){
    //   return distinct[i];
    // }
    return distinct;
  }
}

class Tile extends StatefulWidget {
  String imagePathUrl;
  int tileIndex;
  _NewMatchingGameState parent;

  Tile({this.imagePathUrl, this.tileIndex, this.parent});

  @override
  _TileState createState() => _TileState();
}

List<String> generateList(List<TileModel> list) {
  List<String> str = new List<String>();
  for (int i = 0; i < list.length; i++) {
    str.add(list[i].vocabulary);
    str.add(list[i].description);
  }
  var distinct = str.toSet().toList();
  // for(int i=0; i<distinct.length; i++){
  //   return distinct[i];
  // }
  return distinct;
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selected == false) {
          setState(() {
            myPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedTile != "") {
            print(myPairs[widget.tileIndex].getImage());
            if (selectedTile == myPairs[widget.tileIndex].getImage()) {
              points = points+100;
              TileModel tileModel = new TileModel();
              selected = true;
              Future.delayed(const Duration(seconds: 1), () {
                tileModel.setVocabulary("");
                myPairs[widget.tileIndex] = tileModel;
                myPairs[selectedIndex] = tileModel;
                this.widget.parent.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              selected = true;
              Future.delayed(const Duration(seconds: 1), () {
                this.widget.parent.setState(() {
                  myPairs[widget.tileIndex].setIsSelected(false);
                  myPairs[selectedIndex].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });
              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex].getImage();
              selectedIndex = widget.tileIndex;
              print(selectedTile);
            });
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: myPairs[widget.tileIndex].getVocabulary() != ""
            ? (myPairs[widget.tileIndex].getIsSelected()
                ? Container(
                    child: Center(
                      child: Text(myPairs[widget.tileIndex].getVocabulary(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Helvetica')),
                    ),
                    decoration: new BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10)),
                  )
                : Image.asset("assets/images/quest.png"))
            : Container(
                color: Colors.white,
                child: Image.asset("assets/images/correct.png"),
              ),
      ),
    );
  }
}
