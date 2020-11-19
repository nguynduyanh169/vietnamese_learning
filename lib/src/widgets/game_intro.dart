import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/intro_cubit.dart';
import 'package:vietnamese_learning/src/resources/login_page.dart';
import 'package:vietnamese_learning/src/states/intro_state.dart';
import 'package:vietnamese_learning/src/widgets/game_detail.dart';
import 'package:vietnamese_learning/src/widgets/game_model.dart';

class GameIntroScreen extends StatefulWidget {
  @override
  _GameIntroScreenState createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen> {
  List<GameModel> mySLides = new List<GameModel>();
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
    super.initState();
    mySLides = getSlidesGame();
    controller = new PageController();
  }

  Widget _intro(BuildContext context) {
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
            ],
          ),
        ),
        bottomSheet: slideIndex != 0
            ? Container(
                height: 70,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(255, 190, 51, 10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // FlatButton(
                    //   onPressed: () {
                    //     controller.animateToPage(3,
                    //         duration: Duration(milliseconds: 400),
                    //         curve: Curves.linear);
                    //   },
                    //   splashColor: Colors.blue[50],
                    //   child: Text(
                    //     "SKIP",
                    //     style: TextStyle(
                    //         color: Colors.grey[30],
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 17),
                    //   ),
                    // ),
                    Container(
                      child: Row(
                        children: [
                          for (int i = 0; i < 1; i++)
                            i == slideIndex
                                ? _buildPageIndicator(true)
                                : _buildPageIndicator(false),
                        ],
                      ),
                    ),
                    // FlatButton(
                    //   onPressed: () {
                    //     print("this is slideIndex: $slideIndex");
                    //     controller.animateToPage(slideIndex + 1,
                    //         duration: Duration(milliseconds: 500),
                    //         curve: Curves.linear);
                    //   },
                    //   splashColor: Colors.blue[50],
                    //   child: Text(
                    //     "NEXT",
                    //     style: TextStyle(
                    //         color: Colors.grey[30],
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 17),
                    //   ),
                    // ),
                  ],
                ),
              )
            : InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameDetail()));
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

  Widget _loading() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 239, 215, 100),
      ),
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

  @override
  Widget build(BuildContext context) {
    return _intro(context);
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Image.asset(imagePath),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 30,
              color: Colors.yellow[900],
            ),
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
