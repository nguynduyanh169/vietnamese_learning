import 'package:flutter/material.dart';

Widget button(title, BuildContext context, uri,
    [color = const Color.fromRGBO(68, 68, 76, .8)]) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    height: 60.0,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            uri,
            width: 25.0,
          ),
          Padding(
            child: Text(
              "Continue with $title",
              style: TextStyle(color: color, fontSize: 20),
            ),
            padding: new EdgeInsets.only(left: 35.0),
          ),
        ],
      ),
    ),
  );
}
