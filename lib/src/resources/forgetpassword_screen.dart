import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/signupbackground.png"),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Change Password',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text('Enter your email to receive confirmation code',
                    style: TextStyle(fontFamily: 'Helvetica', fontSize: 15)),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 85,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Email',
                        prefixIcon: Icon(CupertinoIcons.mail_solid)),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 7,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50.0,
                    child: Center(
                      child: Padding(
                        child: Text(
                          "Send confirmation code",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica',
                            color: Colors.grey[700],
                            fontSize: 23,
                          ),
                        ),
                        padding: new EdgeInsets.only(left: 0.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                  },
                  color: const Color.fromRGBO(255, 190, 51, 60),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 7,
                ),
                Container(
                  child: InkWell(
                    child: Text(
                      "Back to Sign In",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
