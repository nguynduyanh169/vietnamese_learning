import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressDialog {
  static void progressDialog(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        child: Center(
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoActivityIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}