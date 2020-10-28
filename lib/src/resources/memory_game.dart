import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class MemoryGamePage extends StatefulWidget {
  @override
  _MemoryGamePageState createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  List<GlobalKey<FlipCardState>> cardStateKey=[
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
  List<bool> cardFlips = [true, true, true, true, true, true, true,true ,true ,true,true, true];
  List<String> data = ["Bánh mì","Bread","Xin Chào","Hello", "Tạm Biệt","Goodbye", "Màu đỏ","Red", "Màu vàng","Yellow", "Trái tim","Heart"];


  int previouseIndex = -1;
  bool flip = false;
  int time = 0;
  Timer timer;
  startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time +1;
      });
    });
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Memory Card Game'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "$time",
                    style: Theme.of(context).textTheme.display2,)
              ),
              Theme(
                data: ThemeData.dark(),
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context,index) =>FlipCard(
                      key: cardStateKey[index],
                      onFlip: (){
                        if(!flip){
                          flip = true;
                          previouseIndex = index;
                          print(cardFlips);
                        }else{
                          flip = false;

                          if(previouseIndex!=index){
                            if(data[previouseIndex]!=data[index]){
                              print(previouseIndex);
                              print(index);
                              if(data[previouseIndex].contains("Bánh mì") && data[index].contains("Bread")){
                                cardFlips[previouseIndex] = false;
                                cardFlips[index] = false;
                              }else
                              if(data[previouseIndex].contains("Xin Chào") && data[index].contains("Hello")){
                                cardFlips[previouseIndex] = false;
                                cardFlips[index] = false;
                              }else
                              if(data[previouseIndex].contains("Màu vàng") && data[index].contains("Yellow")){
                                cardFlips[previouseIndex] = false;
                                cardFlips[index] = false;
                              }else
                              if(data[previouseIndex].contains("Màu đỏ") && data[index].contains("Red")){
                                cardFlips[previouseIndex] = false;
                                cardFlips[index] = false;
                              }else
                              if(data[previouseIndex].contains("Trái tim") && data[index].contains("Heart")){
                                cardFlips[previouseIndex] = false;
                                cardFlips[index] = false;
                              }else
                              if(data[previouseIndex].contains("Tạm Biệt") && data[index].contains("Goodbye")){
                                cardFlips[previouseIndex] = false;
                                cardFlips[index] = false;
                              }else{
                                cardStateKey[previouseIndex]
                                    .currentState
                                    .toggleCard();
                                previouseIndex = index;
                              }
                              if(cardFlips.every((t) => t == false)){
                                print("Won");
                                showResult();
                              }
                            }else{
                              cardFlips[previouseIndex] = false;
                              cardFlips[index] = false;

                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: true,
                      front: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.deepOrange.withOpacity(0.3),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.deepOrange.withOpacity(0.3),
                        child: Center(
                          child: Text("${data[index]}", style: Theme.of(context).textTheme.bodyText1,),

                        ),
                      ),
                    ),

                    itemCount: data.length,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  showResult(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("You Won!!"),
          content: Text("Time $time"),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => MemoryGamePage()
                ),
              );
            },
              child: Text("Next"),)
          ],
        ));
  }

}