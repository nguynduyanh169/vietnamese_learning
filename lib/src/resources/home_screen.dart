import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/widgets/category_card.dart';
import 'package:vietnamese_learning/src/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget{
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: <Widget>[
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
    ]);
  }
}
