import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/lesson_detail.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';

class HomeScreen extends StatefulWidget{
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Stack(children: <Widget>[
    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                alignment: Alignment.center,
                child: Image(
                    width: 50,
                    height: 50,
                    image: AssetImage('assets/images/logolearning.png')
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: .85,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    CategoryCard(
                      title: "Tieng Viet 1",
                      svgSrc: "assets/images/logo.png",
                      press: () => pushNewScreen(
                          context,
                          screen: LessonDetail(),
                          withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino
                      )
                    ),
                    CategoryCard(
                      title: "Tieng Viet 2",
                      svgSrc: "assets/images/logo.png",
                      press: () {},
                    ),
                    CategoryCard(
                      title: "Tieng Viet 3",
                      svgSrc: "assets/images/logo.png",
                      press: () {},
                    ),
                    CategoryCard(
                      title: "Tieng Viet 4",
                      svgSrc: "assets/images/logo.png",
                      press: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ]);
  }
}
