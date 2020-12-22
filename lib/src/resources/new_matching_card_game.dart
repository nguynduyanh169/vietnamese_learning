
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/game_cubit.dart';
import 'package:vietnamese_learning/src/models/memory_model.dart';
import 'package:vietnamese_learning/src/data/game_data.dart';
import 'package:vietnamese_learning/src/states/game_state.dart';

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
  }

  void reStart() {
    myPairs = getFromAPi;
    myPairs.shuffle();

    gridViewTiles = myPairs;

    Future.delayed(const Duration(seconds: 1), () {
// Here you can write your code
      setState(() {
        print("2 seconds done");
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });
    });
  }

  Widget _gameDetails(List<TileModel> list) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.blockSizeVertical * 100,
            color: Color.fromRGBO(255, 239, 215, 100),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                        width: SizeConfig.blockSizeHorizontal * 10,
                      ),
                      Text(
                        'Memory Card Game',
                        style: TextStyle(fontSize: 25, fontFamily: 'Helvetica'),
                      )
                    ],
                  ),
                ),
                // (time > 0)
                //     ? Padding(
                //         padding: EdgeInsets.all(12.0),
                //         child: Text("Time left: $time s",
                //             style: TextStyle(
                //                 fontFamily: 'Helvetica',
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 25)))
                //     : Center(
                //         child: Text(
                //           "",
                //           textAlign: TextAlign.center,
                //           style:
                //               TextStyle(fontSize: 30, fontFamily: 'Helvetica'),
                //         ),
                //       ),
                SizedBox(height: SizeConfig.blockSizeVertical * 10),
                points != 800
                    ? GridView(
                  shrinkWrap: true,
                  //physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 0.0, maxCrossAxisExtent: 100.0),
                  children: List.generate(list.length, (index) {
                    for (int i = 0; i < list.length; i++) {
                      TileModel question = new TileModel();
                      question.setImage("assets/images/question.png");
                      question.setIsSelected(false);
                      questionPairs.add(question);
                    }
                    myPairs = list;
                    return Tile(
                      imagePathUrl: list[index].getImage(),
                      tileIndex: index,
                      parent: this,
                    );
                  }),
                )
                    : Container(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              points = 0;
                              reStart();
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              "Replay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
              List<TileModel> clone = []..addAll(getFromAPi);

              var newList = [...getFromAPi, ...clone];

              return _gameDetails(newList);
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
      color: Colors.green,
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
}

class Tile extends StatefulWidget {
  String imagePathUrl;
  int tileIndex;
  _NewMatchingGameState parent;

  Tile({this.imagePathUrl, this.tileIndex, this.parent});

  @override
  _TileState createState() => _TileState();
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
          //print(myPairs[widget.tileIndex].isSelected.toString());
          if (selectedTile != "") {
            /// testing if the selected tiles are same

            if (selectedTile == myPairs[widget.tileIndex].getVocabulary()) {
              print(myPairs[widget.tileIndex].getIsSelected());
              print("so sanh");
              TileModel tileModel = new TileModel();
              print(widget.tileIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                tileModel.setVocabulary("");
                myPairs[widget.tileIndex] = tileModel;
                print(selectedIndex);
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
              selectedTile = myPairs[widget.tileIndex].getVocabulary();
              selectedIndex = widget.tileIndex;
            });

            print("selected title " + selectedTile);
            print("selected index " + selectedIndex.toString());
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