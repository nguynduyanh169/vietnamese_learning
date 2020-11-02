import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/intro_cubit.dart';
import 'package:vietnamese_learning/src/resources/login_page.dart';
import 'package:vietnamese_learning/src/states/intro_state.dart';
import 'package:vietnamese_learning/src/widgets/slide_model.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;
  BuildContext _ctx;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
    mySLides = getSlides();
    controller = new PageController();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username');
    final String token= prefs.getString('accessToken');
    if (username != null || token != null) {
      Navigator.of(_ctx).pushReplacementNamed("/home");
      return;
    }
  }

  Widget _intro(BuildContext context){
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 239, 215, 1),
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySLides[0].getImageAssetPath(),
                title: mySLides[0].getTitle(),
                desc: mySLides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[1].getImageAssetPath(),
                title: mySLides[1].getTitle(),
                desc: mySLides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[2].getImageAssetPath(),
                title: mySLides[2].getTitle(),
                desc: mySLides[2].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[3].getImageAssetPath(),
                title: mySLides[3].getTitle(),
                desc: mySLides[3].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 3
            ? Container(
          height: 70,
          decoration:
          BoxDecoration(color: Color.fromRGBO(255, 190, 51, 10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  controller.animateToPage(3,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "SKIP",
                  style: TextStyle(
                      color: Colors.grey[30],
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 4; i++)
                      i == slideIndex
                          ? _buildPageIndicator(true)
                          : _buildPageIndicator(false),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      color: Colors.grey[30],
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
            ],
          ),
        )
            : InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: Color.fromRGBO(255, 190, 51, 10),
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(
                color: Colors.grey[30],
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    SizeConfig().init(context);
    return Scaffold(
      body: _intro(context),
        
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))
        ],
      ),
    );
  }
}
