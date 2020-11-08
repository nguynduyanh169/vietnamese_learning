import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/memory_game.dart';

class MemoryGameLevelPage extends StatefulWidget {
  @override
  _MemoryGameLevelPageState createState() => _MemoryGameLevelPageState();
}

class _MemoryGameLevelPageState extends State<MemoryGameLevelPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 15,
                    ),
                    Text(
                      'Choose your level',
                      style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 13,),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => _list[index].goto,
                            )
                        );
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _list[index].secondaryColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black45,
                                      spreadRadius: 0.5,
                                      offset: Offset(3,4)
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _list[index].primaryColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black12,
                                      spreadRadius: 0.3,
                                      offset: Offset(5,3)
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      _list[index].name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black26,
                                              blurRadius: 2,
                                              offset: Offset(1,2),
                                            ),
                                            Shadow(
                                                color: Colors.green,
                                                blurRadius: 2,
                                                offset: Offset(0.5,2)
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: genarateStar(_list[index].noOfStar),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }
              ),
            ],
          )
        ),
      )
    );
  }
  List<Widget> genarateStar(int no){
    List<Widget> _icons = [];
    for(int i = 0; i<no; i++){
    _icons.insert(i, Icon(Icons.star_outlined, color: Colors.yellow,));
    }
    return _icons;
  }
}

class Details{
  String name;
  Color primaryColor;
  Color secondaryColor;
  Widget goto;
  int noOfStar;
  Details({this.name, this.primaryColor, this.secondaryColor, this.noOfStar, this.goto});
}

List<Details> _list = [
  Details(name: "Easy",
      primaryColor: Colors.green,
      secondaryColor: Colors.green[300],
      noOfStar: 1,
      goto: MemoryGamePage()
  ),
  Details(name: "Medium",
      primaryColor: Colors.orange[300],
      secondaryColor: Colors.orange,
      noOfStar: 2
  ),
  Details(name: "Hard",
      primaryColor: Colors.red,
      secondaryColor: Colors.red[300],
      noOfStar: 3
  ),

];