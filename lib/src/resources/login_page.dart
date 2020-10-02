import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/forgetpassword_screen.dart';
import 'package:vietnamese_learning/src/resources/home_page.dart';
import 'package:vietnamese_learning/src/resources/signup_screen.dart';
import 'package:vietnamese_learning/src/widgets/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/vietnameselearn.png'))),
              ),
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
              SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
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
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                child: InkWell(
                  child: Text("Forget password?", style: TextStyle(color: Colors.blueAccent),),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ForgetPasswordScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
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
                        "Sign in",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      padding: new EdgeInsets.only(left: 0.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                color: Colors.blue,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: button('Facebook', context,
                    'assets/images/facebook_logo.png', Colors.white),
                onPressed: () {},
                color: Color.fromRGBO(58, 89, 152, 1.0),
              ),
              SizedBox(
                  height: SizeConfig.blockSizeVertical * 2
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: button('Google', context,
                    'assets/images/google_logo.png', Colors.black),
                onPressed: () {},
                color: Colors.white,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Container(
                padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 28),
                child: Row(
                  children: <Widget>[
                    Text("Not a member? "),
                    SizedBox(width: 5,),
                    InkWell(
                      child: Text("Sign up here", style: TextStyle(color: Colors.blueAccent),),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                SignUpScreen(),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
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
