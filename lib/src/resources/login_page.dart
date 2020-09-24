import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Widget _loginWithAppleButton() {
    return SignInButton(
        buttonType: ButtonType.apple,
        buttonSize: ButtonSize.large, // small(default), medium, large
        btnText: 'Continue to Apple',
        onPressed: () {
          print('click');
        }
    );
  }

  Widget _loginWithFaceBookButton() {
    return SignInButton(
        buttonType: ButtonType.facebook,
        buttonSize: ButtonSize.large,
        btnText: "Continue to Facebook",// small(default), medium, large
        onPressed: () {
          print('click');
        }
    );
  }


  Widget _loginWithGoogleButton() {
    return SignInButton(
        buttonType: ButtonType.google,
        buttonSize: ButtonSize.large,
        btnText: 'Continue to Google',// small(default), medium, large
        onPressed: () {
          print('click');
        }
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Vietnamese Learning',
          style: TextStyle(color: Colors.white54, fontSize: 40)
      ),
    );
  }

  Widget _title2() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Sign Up/Login',
          style: TextStyle(color: Colors.white54, fontSize: 15)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF8A65), Color(0xFF4A148C)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 150,
              ),
              _title2(),
              SizedBox(
                height: 20,
              ),
              _loginWithAppleButton(),
              SizedBox(
                height: 20,
              ),
              _loginWithFaceBookButton(),
              SizedBox(
                height: 20,
              ),
              _loginWithGoogleButton()
            ],
          ),
        ),
      ),
    );
  }
}
