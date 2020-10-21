import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/presenters/login_screen_presenter.dart';
import 'package:vietnamese_learning/src/resources/forgetpassword_screen.dart';
import 'package:vietnamese_learning/src/resources/signup_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginScreenContract {
  BuildContext _ctx;
  TextEditingController _usernameController, _passwordController;
  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username');
    final String token = prefs.getString('accessToken');
    print(token);
    print(username);
    if (username != null) {
      setState(() {
        isLoggedIn = true;
        name = username;
      });
      Navigator.of(_ctx).pushReplacementNamed("/home");
      return;
    }
  }
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _username;

  LoginScreenPresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginScreenPresenter(this);
  }

  void _submit() {
    _username = _usernameController.text;
    _password = _passwordController.text;
    _presenter.doLogin(_username, _password);
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  final color = const Color(0xffF2CE5E);

  Widget _loginScreen() {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 1.5, image: AssetImage('assets/images/VL.png'))),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Username",
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Enter your Username',
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
                "Password",
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Enter your Password',
                    prefixIcon: Icon(Icons.lock)),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Container(
              child: InkWell(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 85,
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: Colors.blueAccent[100],
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
              height: SizeConfig.blockSizeVertical * 5,
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'OpenSans'),
                    ),
                    padding: new EdgeInsets.only(left: 0.0),
                  ),
                ),
              ),
              onPressed: _submit,
              color: Colors.blue,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Container(
              child: Text(
                "- OR -",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Container(
              child: Text(
                "Sign in with",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(58, 89, 152, 1.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      scale: 13,
                      image: AssetImage('assets/images/facebook_logo.png'),
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      scale: 13,
                      image: AssetImage('assets/images/google_logo.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 28),
              child: Row(
                children: <Widget>[
                  Text("Don't have an Account? "),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SizeConfig().init(context);
    _ctx = context;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: _loginScreen(),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
  }

  @override
  Future<void> onLoginSuccess(LoginResponse response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _showSnackBar("Login successful!");
    Navigator.of(_ctx).pushReplacementNamed("/home");
    setState(() {
      name = prefs.getString('username');
      isLoggedIn = true;
    });
  }
}
