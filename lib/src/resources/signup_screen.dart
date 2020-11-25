import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_validator/the_validator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/register_cubit.dart';
import 'package:vietnamese_learning/src/states/register_state.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vietnamese_learning/src/widgets/choose_nation.dart';

import '../data/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController _emailController,
      _passwordController,
      _nationController,
      _usernameController;
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  FocusNode myFocusNode3 = new FocusNode();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  var nationIndex = 0;

  final List nationList = const [
    {
      'nation': 'Vietnam',
      'imgPath': 'assets/images/vietnamflag.png',
    },
    {
      'nation': 'USA',
      'imgPath': 'assets/images/usaflag.png',
    },
    {
      'nation': 'France',
      'imgPath': 'assets/images/franceflag.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _usernameController = new TextEditingController();
    _nationController = new TextEditingController(text: '');
  }

  Widget _chooseNation(List nation) {
    return ChooseNation(
      nation: nation,
    );
  }

  String _password, _username, _email;
  void _submit(BuildContext context) {
    print(_form.currentState.validate());
    if (_form.currentState.validate()) {
      _username = _usernameController.text;
      _password = _passwordController.text;
      _email = _emailController.text;
      print(_username);
      print(_password);
      print(_email);
      print('hello');
      BlocProvider.of<RegisterCubit>(context)
          .doRegister(_username, _password, _email);
    }
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
              print('hello');
            } else if (state is RegistedSuccess) {
              Navigator.pop(context);
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
            Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          validator: FieldValidator.required(),
                          focusNode: myFocusNode,
                          style: TextStyle(fontFamily: 'Helvetica'),
                          controller: _usernameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: const Color.fromRGBO(230, 172, 0, 10),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 15,
                              color: myFocusNode.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.person_solid,
                              color: myFocusNode.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          validator: FieldValidator.email(),
                          focusNode: myFocusNode1,
                          style: TextStyle(fontFamily: 'Helvetica'),
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: const Color.fromRGBO(230, 172, 0, 10),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 15,
                              color: myFocusNode1.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.mail_solid,
                              color: myFocusNode1.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          validator: FieldValidator.password(
                            minLength: 8,
                            errorMessage: "Invalid Password",
                          ),
                          focusNode: myFocusNode2,
                          style: TextStyle(fontFamily: 'Helvetica'),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: const Color.fromRGBO(230, 172, 0, 10),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 15,
                              color: myFocusNode2.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.lock_fill,
                              color: myFocusNode2.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          validator: FieldValidator.required(),
                          focusNode: myFocusNode3,
                          controller: _nationController,
                          style: TextStyle(fontFamily: 'Helvetica'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: const Color.fromRGBO(230, 172, 0, 10),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 15,
                              color: myFocusNode3.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                            labelText: 'Nation',
                            prefixIcon: Icon(
                              Icons.public,
                              color: myFocusNode3.hasFocus
                                  ? Colors.black54
                                  : Colors.black54,
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              expand: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context, scrollController) =>
                                  _chooseNation(nationList),
                            ).then(
                                (value) => {_nationController.text = '$value'});
                          },
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                      InkWell(
                        onTap: () {
                          _submit(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.87,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromRGBO(255, 217, 102, 10),
                                const Color.fromRGBO(230, 172, 0, 10),
                              ],
                            ),
                          ),
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
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 7,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 28),
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
                )),
          ],
        ),
      ),
    );
  }
}
