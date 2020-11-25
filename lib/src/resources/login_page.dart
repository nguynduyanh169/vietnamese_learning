import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:the_validator/the_validator.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/login_cubit.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/resources/forgetpassword_screen.dart';
import 'package:vietnamese_learning/src/resources/signup_screen.dart';
import 'package:vietnamese_learning/src/states/login_state.dart';
import 'package:vietnamese_learning/src/utils/firebase_util.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext _ctx;
  TextEditingController _usernameController, _passwordController;
  ProgressDialog pr;
  String name = '';


  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initApp();
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  void initApp() async{
    FirebaseApp defaultApp = await Firebase.initializeApp();

  }


  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _username;

  void _submit(BuildContext context) {
    if(_form.currentState.validate()){
      _username = _usernameController.text;
      _password = _passwordController.text;
      BlocProvider.of<LoginCubit>(context).doLogin(_username, _password);
    }
  }

  final color = const Color(0xffF2CE5E);

  Widget _loginScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 239, 215, 100),
      ),
      child: Center(
        child: Form(
          key: _form,
            child: SingleChildScrollView(
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
                  style: TextStyle(fontFamily: 'Helvetica'),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: TextFormField(
                  validator: FieldValidator.required(
                      message: 'Username is required',

                  ),
                  controller: _usernameController,
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
                  "Password",
                  style: TextStyle(fontFamily: 'Helvetica'),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: TextFormField(
                  validator: FieldValidator.required(
                    message: 'Password is required'
                  ),
                  controller: _passwordController,
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
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                child: InkWell(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 85,
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Colors.blueAccent[100],
                      ),
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
                height: SizeConfig.blockSizeVertical * 4,
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
                          color: Colors.grey[700],
                          fontSize: 23.0,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: new EdgeInsets.only(left: 0.0),
                    ),
                  ),
                ),
                onPressed: () {
                  _submit(context);
                },
                color: const Color.fromRGBO(255, 190, 51, 60),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                child: Text(
                  "- OR -",
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                child: Text(
                  "Sign in with",
                  style: TextStyle(
                    fontFamily: 'Helvetica',
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
                  InkWell(
                    child: Container(
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
                    onTap: () => googleSignIn(),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                padding:
                EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 28),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(fontFamily: 'Helvetica', fontSize: 13),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'Helvetica',
                            fontSize: 13),
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
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    pr = new ProgressDialog(
        context, showLogs: true, isDismissible: false
    );
    pr.style(
        progressWidget: CupertinoActivityIndicator(), message: 'Please wait...');
    SizeConfig().init(context);
    _ctx = context;
    return BlocProvider(
      create: (context) => LoginCubit(UserRepository()),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              pr.hide();
              Toast.show("Invalid Username or Password!", context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white);
            } else if (state is LoginProcess) {
              pr.hide();
              Navigator.of(_ctx).pushReplacementNamed("/home");
            } else if(state is NewLoginProcess){
              pr.hide();
              Navigator.of(_ctx).pushReplacementNamed("/level");
            } else if(state is DoingLogin){
              pr.show();
            }
          },
          builder: (context, state) {
            return _loginScreen(context);
          },
        ),
      ),
    );
  }
}
