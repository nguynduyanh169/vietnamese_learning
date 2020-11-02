import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class VocabularyResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Awesome!!!',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Text(
                'You have just archive',
                style: TextStyle(
                    fontSize: 27, fontFamily: "Helvetica", color: Colors.blue),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(230, 157, 0, 100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 239, 215, 10),
                      ),
                      child: Center(
                        child: Text(
                          "10 Words",
                          style: TextStyle(
                            fontSize: 27,
                            color: Colors.grey[700],
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(context),
                child: Text(
                  "Back to Lesson Introduction",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Helvetica",
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 8,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60.0,
                  child: Center(
                    child: Padding(
                      child: Text(
                        "Review",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                      padding: new EdgeInsets.only(left: 0.0),
                    ),
                  ),
                ),
                onPressed: () {},
                color: Colors.blueGrey,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60.0,
                  child: Center(
                    child: Padding(
                      child: Text(
                        "Archive more",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica'),
                      ),
                      padding: new EdgeInsets.only(left: 0.0),
                    ),
                  ),
                ),
                onPressed: () {},
                color: Color.fromRGBO(255, 210, 77, 10),
              ),
            ],
          ),
        ));
  }
}