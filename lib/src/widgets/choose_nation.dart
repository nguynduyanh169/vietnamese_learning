import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseNation extends StatefulWidget {
  List nation;
  ChooseNation({Key key, this.nation}) : super(key: key);

  _ChooseNationState createState() => _ChooseNationState(nation: nation);
}

class _ChooseNationState extends State<ChooseNation> {
  List nation;
  _ChooseNationState({this.nation});
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
                title: Text(nation[0]['nation']),
                leading: Container(
                    child: Image(
                  image: AssetImage(nation[0]['imgPath']),
                )),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text(nation[1]['nation']),
                leading: Container(
                    child: Image(
                  image: AssetImage(nation[1]['imgPath']),
                )),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: Text(nation[2]['nation']),
                leading: Container(
                    child: Image(
                  image: AssetImage(nation[2]['imgPath']),
                )),
                onTap: () => Navigator.of(context).pop(),
              ),
              // ListTile(
              //   title: Text('Move'),
              //   leading: Icon(Icons.folder_open),
              //   onTap: () => Navigator.of(context).pop(),
              // ),
              // ListTile(
              //   title: Text('Delete'),
              //   leading: Icon(Icons.delete),
              //   onTap: () => Navigator.of(context).pop(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
