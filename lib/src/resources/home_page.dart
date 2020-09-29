import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/resources/home_screen.dart';
import 'package:vietnamese_learning/src/resources/profile_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final tabs = [
    new HomeScreen(),
    Container(
      child: Center(
        child: Text(
          'Game',
          style: TextStyle(fontSize: 30),
        ),
      ),
    ),
    new ProfileScreen(),
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
              ),
              title: Text(
                'Home'
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
