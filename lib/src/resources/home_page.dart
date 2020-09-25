import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final tabs = [
    Container(
      child: Center(
        child: Text('Home', style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text('Games', style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text('Speak', style: TextStyle(fontSize: 30),),
      ),
    ),Container(
      child: Center(
        child: Text('Quiz', style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text('Profile', style: TextStyle(fontSize: 30),),
      ),
    )

  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
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
