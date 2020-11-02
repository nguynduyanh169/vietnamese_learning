import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/register_cubit.dart';
import 'package:vietnamese_learning/src/resources/level_screen.dart';
import 'package:vietnamese_learning/src/states/register_state.dart';

import '../data/user_repository.dart';
import 'level_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController _emailController,
      _passwordController,
      _usernameController;

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _usernameController = new TextEditingController();
  }

  String _password, _username, _email;
  void _submit(BuildContext context) {
    _username = _usernameController.text;
    _password = _passwordController.text;
    _email = _emailController.text;
    BlocProvider.of<RegisterCubit>(context)
        .doRegister(_username, _password, _email);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => RegisterCubit(UserRepository()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegistedError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is RegistedSuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LevelScreen()));
            }
          },
          builder: (context, state) {
            return _registerScreen(context);
          },
        ),
      ),
    );
  }

  Widget _registerScreen(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/signupbackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeVertical * 26),
              child: Text(
                'Sign Up Here',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                style: TextStyle(fontFamily: 'Helvetica'),
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Username',
                  prefixIcon: Icon(CupertinoIcons.person),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                style: TextStyle(fontFamily: 'Helvetica'),
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Email',
                  prefixIcon: Icon(CupertinoIcons.mail),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                style: TextStyle(fontFamily: 'Helvetica'),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            // SizedBox(
            //   height: SizeConfig.blockSizeVertical * 1.5,
            // ),
            // Container(
            //   width: SizeConfig.blockSizeHorizontal * 85,
            //   child: TextField(
            //     obscureText: true,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(20.0)),
            //       labelText: 'Confirm Password',
            //     ),
            //   ),
            // ),
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
                      "Sign Up",
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
                _submit(context);
              },
              color: const Color.fromRGBO(255, 190, 51, 60),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 7,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 28),
              child: Row(
                children: <Widget>[
                  Text("Already a member? "),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: Text(
                      "Sign In here",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
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
    );
  }
}
