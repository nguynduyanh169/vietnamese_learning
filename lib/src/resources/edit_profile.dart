import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';

class EditProfileScreen extends StatelessWidget{
  UserProfile userProfile;

  EditProfileScreen({this.userProfile});

  TextEditingController txtUsername, txtFullname, txtEmail, txtNation;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 239, 215, 100),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 24,
                  ),
                  Text(
                    'Edit profile',
                    style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 18,
                  ),
                  InkWell(
                    child: Container(
                        height: SizeConfig.blockSizeVertical * 5,
                        width: SizeConfig.blockSizeHorizontal * 15,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.05),
                                  offset: Offset(0.0, 6.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.10)
                            ]),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Helvetica',
                              color: Colors.white,
                            ),
                          ),
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            Container(
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 45,
                    backgroundImage:
                    AssetImage('assets/images/profile.png'),
                  ),
                  Positioned(
                    left: SizeConfig.blockSizeHorizontal * 17,
                    bottom: SizeConfig.blockSizeVertical * 8,
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 6,
                      height: SizeConfig.blockSizeVertical * 7,
                      child: Icon(CupertinoIcons.pen, size: 15, color: Colors.white,),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent),
                    )
                    )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Username",
                style: TextStyle(fontFamily: 'Helvetica'),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Enter your Username',
                  labelStyle: TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Name",
                style: TextStyle(fontFamily: 'Helvetica'),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Enter your name',
                    labelStyle:
                    TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                    prefixIcon: Icon(CupertinoIcons.person_solid)),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Email",
                style: TextStyle(fontFamily: 'Helvetica'),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Enter your Email',
                  labelStyle: TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                  prefixIcon: Icon(CupertinoIcons.mail_solid),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Password",
                style: TextStyle(fontFamily: 'Helvetica'),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Enter your Password',
                    labelStyle:
                    TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                    prefixIcon: Icon(Icons.lock)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}