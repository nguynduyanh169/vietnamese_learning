import 'package:flutter/material.dart';
Widget button(title, BuildContext context, uri,
    [color = const Color.fromRGBO(68, 68, 76, .8)]) {
  return Container(
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            uri,
            width: 30.0,
          ),
          Padding(
            padding: new EdgeInsets.only(left: 35.0),
          ),
        ],
      ),
    ),
  );
}
