import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressDialog {
  static void progressDialog(BuildContext context){
    print('show');
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
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DownloadProgressDialog{
  static void downloadProgressDialog(BuildContext context, double percent){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        child: Center(
          child: Container(
            width: 200.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: LinearProgressIndicator(
                value: percent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}