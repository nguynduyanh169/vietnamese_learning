import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/widgets/search_bar.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 239, 215, 12),
      body: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SearchBar(),
              ],
            ),
            Container(
              width: double.infinity,
              height: 35,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black26,
                    width: 1.0,
                  ),
                  top: BorderSide(
                    color: Colors.black26,
                    width: 1.0,
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Search history",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 56,
                    ),
                    Text(
                      "CLEAR",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phan nan ve dich vu',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 35,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: null,
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phan nan ve dich vu',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 35,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: null,
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phan nan ve dich vu',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 35,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: null,
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phan nan ve dich vu',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 35,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: null,
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phan nan ve dich vu',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 35,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: null,
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phan nan ve dich vu',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 35,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: null,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
