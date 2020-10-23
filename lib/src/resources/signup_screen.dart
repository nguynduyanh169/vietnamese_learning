import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/level_screen.dart';

class SignUpScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Sign Up here', style: GoogleFonts.secularOne(
                fontSize: 25,
              ),),
              SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
              Container(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Name',
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
              Container(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
              Container(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
              Container(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 7,),
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
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      padding: new EdgeInsets.only(left: 0.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LevelScreen()),
                  );
                },
                color: Colors.blue,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 7,),
              Container(
                padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 28),
                child: Row(
                  children: <Widget>[
                    Text("Already a member? "),
                    SizedBox(width: 5,),
                    InkWell(
                      child: Text("Sign In here", style: TextStyle(color: Colors.blueAccent),),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}