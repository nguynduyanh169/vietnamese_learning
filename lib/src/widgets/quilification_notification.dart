import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class QualificationNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/qualification.png'),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Your have completed the test",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica',
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Text(
                "Unlock 13% of the course",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Helvetica',
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 20,
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
                        "Finish",
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
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => null));
                },
                color: Color.fromRGBO(255, 210, 77, 10),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
            ],
          ),
        ));
  }
}
