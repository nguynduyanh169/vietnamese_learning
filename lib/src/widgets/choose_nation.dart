import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/nation.dart';

class ChooseNation extends StatefulWidget {
  List<Nation> nations;

  ChooseNation({Key key, this.nations}) : super(key: key);

  _ChooseNationState createState() => _ChooseNationState(nations: nations);
}

class _ChooseNationState extends State<ChooseNation> {
  final List<Nation> nations;
  TextEditingController txtSearch = new TextEditingController();
  _ChooseNationState({this.nations});

  @override
  Widget build(BuildContext context) {
    List<Nation> newNations = List.from(nations);
    onItemChanged(String value) {
      setState(() {
        newNations = nations
            .where((data) => data.nation.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
      print(newNations.toString());
    }
    return Material(
      child: SafeArea(
        top: false,
        child: Container(
          height: SizeConfig.blockSizeVertical * 70,
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
                  controller: txtSearch,
                  decoration: InputDecoration(
                    hintText: "Search Nation",
                    hintStyle: TextStyle(fontFamily: 'Helvetica'),
                    border: InputBorder.none,
                    prefixIcon: Icon(CupertinoIcons.search),
                  ),
                  onChanged: onItemChanged,
                ),
              ),
              Expanded(
                  child: ListView(
                    children: newNations.map((data) {
                      return ListTile(
                        title: Text(data.nation),
                        leading: Container(
                            child: Image(
                              image: NetworkImage(data.image),
                            )),
                        onTap: () => Navigator.pop(context, data),
                      );
                    }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
