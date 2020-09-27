import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';
import 'package:vietnamese_learning/src/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final tabs = [
    Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage("assets/images/background.png"),
          ),
        ),
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SearchBar(),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: .85,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    CategoryCard(
                      title: "Tieng Viet 1",
                      svgSrc: "assets/images/tiengviet1.svg",
                      press: () {},
                    ),
                    CategoryCard(
                      title: "Tieng Viet 2",
                      svgSrc: "assets/images/tiengviet1.svg",
                      press: () {},
                    ),
                    CategoryCard(
                      title: "Tieng Viet 3",
                      svgSrc: "assets/images/tiengviet1.svg",
                      press: () {},
                    ),
                    CategoryCard(
                      title: "Tieng Viet 4",
                      svgSrc: "assets/images/tiengviet1.svg",
                      press: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]),
    Container(
      child: Center(
        child: Text(
          'Games',
          style: TextStyle(fontSize: 30),
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          'Speak',
          style: TextStyle(fontSize: 30),
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          'Quiz',
          style: TextStyle(fontSize: 30),
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 30),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.lightBlue[400],
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.lightBlue[400]),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.games,
                color: Colors.black,
              ),
              title: Text(
                'Game',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mic,
                color: Colors.black,
              ),
              title: Text(
                'Speak',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.question_answer,
                color: Colors.black,
              ),
              title: Text(
                'Quiz',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
