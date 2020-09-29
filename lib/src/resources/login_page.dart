import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:vietnamese_learning/src/resources/home_page.dart';
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
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/vietnameselearn.png'))),
              ),
              SizedBox(height: 50),
              MaterialButton(
                child: button('Google', 'assets/images/google_logo.png'),
                onPressed: (){
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
                color: Colors.white,
              ),
              SizedBox(height: 13),
              MaterialButton(
                child: button('Facebook', 'assets/images/facebook_logo.png', Colors.white),
                  onPressed: (){

                  },
                  color: Color.fromRGBO(58, 89, 152, 1.0),
              ),
              SizedBox(height: 13),
              MaterialButton(
                  child: button('Apple', 'assets/images/apple_logo.png', Colors.white),
                  onPressed: (){

                  },
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
