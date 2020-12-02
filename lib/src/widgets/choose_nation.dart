import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/models/nation.dart';

class ChooseNation extends StatefulWidget {
  List<Nation> nations;
  ChooseNation({Key key, this.nations}) : super(key: key);

  _ChooseNationState createState() => _ChooseNationState(nations: nations);
}

class _ChooseNationState extends State<ChooseNation> {
  List<Nation> nations;
  _ChooseNationState({this.nations});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Container(
          color: Color.fromRGBO(255, 236, 215, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 340,
                height: 48,
                margin: EdgeInsets.only(top: 16, bottom: 9),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29.5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(fontFamily: 'Helvetica'),
                    border: InputBorder.none,
                    prefixIcon: Icon(CupertinoIcons.search),
                  ),
                  onSubmitted: (value) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => null));
                  },
                ),
              ),
              ListTile(
                title: Text(nations[0].nation),
                leading: Container(
                    child: Image(
                  image: NetworkImage(nations[0].image),
                )),
                onTap: () => Navigator.pop(context, nations[0]),
              ),
              ListTile(
                title: Text(nations[1].nation),
                leading: Container(
                    child: Image(
                      image: NetworkImage(nations[1].image),
                    )),
                onTap: () => Navigator.pop(context, nations[1]),
              ),
              ListTile(
                title: Text(nations[2].nation),
                leading: Container(
                    child: Image(
                      image: NetworkImage(nations[2].image),
                    )),
                onTap: () => Navigator.pop(context, nations[2]),
              ),
              ListTile(
                title: Text(nations[3].nation),
                leading: Container(
                    child: Image(
                      image: NetworkImage(nations[3].image),
                    )),
                onTap: () => Navigator.pop(context, nations[3]),
              ),
              ListTile(
                title: Text(nations[4].nation),
                leading: Container(
                    child: Image(
                      image: NetworkImage(nations[4].image),
                    )),
                onTap: () => Navigator.pop(context, nations[4]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
