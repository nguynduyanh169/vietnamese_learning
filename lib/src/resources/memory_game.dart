import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/data/game_data.dart';
import 'package:vietnamese_learning/src/resources/memory_game_level.dart';
import 'package:vietnamese_learning/src/widgets/game_result.dart';

class MemoryGamePage extends StatefulWidget {
  // final Level _level;
  // MemoryGamePage(this._level);
  @override
  _MemoryGamePageState createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  Level _level;
  List<GlobalKey<FlipCardState>> cardStateKey = [
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
  ];
  List<bool> cardFlips = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  List<String> data = [
    "Bánh mì",
    "Bread",
    "Xin Chào",
    "Hello",
    "Tạm Biệt",
    "Goodbye",
    "Màu đỏ",
    "Red",
    "Màu vàng",
    "Yellow",
    "Trái tim",
    "Heart"
  ];

  bool isFinished = false;

  int previouseIndex = -1;
  bool flip = false;
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    data.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          height: SizeConfig.blockSizeVertical * 100,
          color: Color.fromRGBO(255, 239, 215, 100),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
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
                      width: SizeConfig.blockSizeHorizontal * 13,
                    ),
                    Text(
                      'Memory Card Game',
                      style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                    )
                  ],
                ),
              ),
              (time > 0)
                  ? Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Time left: $time s",
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w600,
                              fontSize: 25)))
                  : Center(
                      child: Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, fontFamily: 'Helvetica'),
                      ),
                    ),
              (time > 0)
                  ? Theme(
                      data: ThemeData.dark(),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => FlipCard(
                            key: cardStateKey[index],
                            onFlip: () {
                              if (!flip) {
                                flip = true;
                                previouseIndex = index;
                                print(cardFlips);
                              } else {
                                flip = false;

                                if (previouseIndex != index) {
                                  if (data[previouseIndex] != data[index]) {
                                    print(previouseIndex);
                                    print(index);
                                    if (data[previouseIndex]
                                            .contains("Bánh mì") &&
                                        data[index].contains("Bread")) {
                                      cardFlips[previouseIndex] = false;
                                      cardFlips[index] = false;
                                    } else if (data[previouseIndex]
                                            .contains("Xin Chào") &&
                                        data[index].contains("Hello")) {
                                      cardFlips[previouseIndex] = false;
                                      cardFlips[index] = false;
                                    } else if (data[previouseIndex]
                                            .contains("Màu vàng") &&
                                        data[index].contains("Yellow")) {
                                      cardFlips[previouseIndex] = false;
                                      cardFlips[index] = false;
                                    } else if (data[previouseIndex]
                                            .contains("Màu đỏ") &&
                                        data[index].contains("Red")) {
                                      cardFlips[previouseIndex] = false;
                                      cardFlips[index] = false;
                                    } else if (data[previouseIndex]
                                            .contains("Trái tim") &&
                                        data[index].contains("Heart")) {
                                      cardFlips[previouseIndex] = false;
                                      cardFlips[index] = false;
                                    } else if (data[previouseIndex]
                                            .contains("Tạm Biệt") &&
                                        data[index].contains("Goodbye")) {
                                      cardFlips[previouseIndex] = false;
                                      cardFlips[index] = false;
                                    } else {
                                      cardStateKey[previouseIndex]
                                          .currentState
                                          .toggleCard();
                                      previouseIndex = index;
                                    }
                                    if (cardFlips.every((t) => t == false)) {
                                      print("Won");
                                      showResult();
                                    }
                                  } else {
                                    cardFlips[previouseIndex] = false;
                                    cardFlips[index] = false;
                                  }
                                }
                              }
                            },
                            direction: FlipDirection.HORIZONTAL,
                            flipOnTouch: true,
                            front: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/quest.png",
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26.withOpacity(0.05),
                                        offset: Offset(0.0, 6.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 0.10)
                                  ]),
                              margin: EdgeInsets.all(4.0),
                              // child: Container(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Image(
                              //       image: AssetImage("assets/images/quest.png"),
                              //     ),
                              // ),
                            ),
                            back: Container(
                              margin: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26.withOpacity(0.05),
                                        offset: Offset(0.0, 6.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 0.10)
                                  ]),
                              child: Center(
                                child: Text("${data[index]}",
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                          itemCount: data.length,
                        ),
                      ),
                    )
                  : GameResult()
            ],
          ),
        )),
      ),
    );
  }

  showResult() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("You Won!!"),

              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MemoryGamePage()),
                    );
                  },
                  child: Text("Next"),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => MemoryGameLevelPage()),
                    );
                  },
                  child: Text("Choose another level"),
                )
              ],
            ));
    timer.cancel();
  }

  restart() {
    // showDialog(context: context,
    //     barrierDismissible: false,
    //     builder: (context) => AlertDialog(
    //       title: Text("You failed!!!"),
    //       content: Text("You have run out of time"),
    //       actions: <Widget>[
    //         FlatButton(onPressed: (){
    //           Navigator.of(context).pushReplacement(
    //               MaterialPageRoute(
    //                   builder:(context) => MemoryGamePage()
    //               )
    //           );
    //         },
    //           child: Text("Replay"),
    //         ),
    //
    //         FlatButton(
    //           onPressed: (){
    //             Navigator.of(context).pushReplacement(
    //               MaterialPageRoute(
    //                   builder: (context) => MemoryGameLevelPage()
    //               ),
    //             );
    //           },
    //           child: Text("Choose another level"),
    //         )
    //       ],
    //     )
    // );

    FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MemoryGamePage()),
        );
      },
      child: Text("Replay"),
    );
  }
// int _previousIndex = -1;
// bool _flip = false;
// bool _start = false;
// bool _wait = false;
// Timer _timer;
// int _time = 5;
// int _left;
// bool _isFiinished;
// List<String> _data;
//
// List<bool> _cardFlips;
// List<GlobalKey<FlipCardState>> _cardStateKey;
//
// Widget getItem(int index){
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.grey[100],
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black45,
//           blurRadius: 3,
//           spreadRadius: 0.8,
//           offset: Offset(2.0,1),
//         )
//       ],
//       borderRadius: BorderRadiusDirectional.circular(5)
//     ),
//     margin: EdgeInsets.all(4.0),
//     child: Text(_data[index]),
//   );
// }
//
// startTimer(){
//   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//     setState(() {
//       _time = _time -1;
//     });
//   });
// }
//
// void restart(){
//   startTimer();
//   _data = getSourceArray(_level);
//   _cardFlips = getInitialItemState(_level);
//   _cardStateKey = getCardStateKeys(_level);
//   _time = 5;
//   _left = (_data.length ~/ 2);
//   _isFiinished = false;
//   Future.delayed(const Duration(seconds: 6),(){
//     setState(() {
//       _start = true;
//       _timer.cancel();
//     });
//   });
// }
//
// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();
//   restart();
// }
//
// @override
// void dispose() {
//   // TODO: implement dispose
//   super.dispose();
// }
//
// @override
// Widget build(BuildContext context) {
//   return _isFiinished ? Scaffold(
//     body: Center(
//       child: GestureDetector(
//         onTap: (){
//           setState(() {
//             restart();
//           });
//         },
//         child: Container(
//           height: 50,
//             width: 200,
//             alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: Text("Replay",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 17,
//               fontWeight: FontWeight.w500
//             ),
//           ),
//         ),
//       ),
//     ),
//   ) : Scaffold(
//     body: SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: _time > 0 ? Text('$_time',
//                 style: Theme.of(context).textTheme.headline3,
//               ) : Text(
//                 'Left:$_left',
//                 style: Theme.of(context).textTheme.headline3,
//               )
//             ),
//             Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                 ),
//                 itemBuilder: (context, index) => _start ? FlipCard(
//                   key: _cardStateKey[index],
//                   onFlip: (){
//                     if(!_flip){
//                       _flip = true;
//                       _previousIndex = index;
//                     }else{
//                       _flip = false;
//                       if(_previousIndex!= index){
//
//                       }
//                     }
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
//

}
