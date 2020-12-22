import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:the_validator/the_validator.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/register_cubit.dart';
import 'package:vietnamese_learning/src/models/nation.dart';
import 'package:vietnamese_learning/src/states/register_state.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vietnamese_learning/src/widgets/choose_nation.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

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

  List<Nation> nationList;

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _usernameController = new TextEditingController();
    _nationController = new TextEditingController(text: ' ');
    nationList = new List();
    nationList.add(new Nation(nation: 'Vietnam', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fvietnam.png?alt=media&token=4d353d03-50f4-469c-aaa8-96afabb59fd9'));
    nationList.add(new Nation(nation: 'France', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Ffrance.png?alt=media&token=d01979d1-f5cc-4dcf-a939-86717eb5e7af'));
    nationList.add(new Nation(nation: 'United State', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Funited-states.png?alt=media&token=15d0039d-e9df-437f-aed7-6b03f2569172'));
    nationList.add(new Nation(nation: 'United Kingdom', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Funited-kingdom.png?alt=media&token=cea37a6c-2566-4cbf-a5b4-f04b0891998d'));
    nationList.add(new Nation(nation: 'Korea', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fsouth-korea.png?alt=media&token=c7c69d25-cc3a-4c43-a54c-bcb647bae90b'));
    nationList.add(new Nation(nation: 'Japan', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fjapan.png?alt=media&token=8792c7c8-2719-4cf1-9dbc-3043cdb8b59a'));
    nationList.add(new Nation(nation: 'Germany', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fgermany.png?alt=media&token=0accf5ad-2e96-41b8-8572-e5e766cedd2b'));
    nationList.add(new Nation(nation: 'China', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fchina.png?alt=media&token=de3069c8-b177-418b-828e-32683c6d176b'));
  }

  Widget _chooseNation() {
    return ChooseNation(
      nations: nationList,
    );
  }

  String _password, _username, _email, nationLink;
  void _submit(BuildContext context) {
    print(_form.currentState.validate());
    if (_form.currentState.validate()) {
      _username = _usernameController.text;
      _password = _passwordController.text;
      _email = _emailController.text;
      print(_username);
      print(_password);
      print(_email);
      BlocProvider.of<RegisterCubit>(context)
          .doRegister(_username, _password, _email, nationLink);
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
              Navigator.pop(context);
              Toast.show(state.message, context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white);
            } else if (state is RegistedSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else if(state is Registering){
              CustomProgressDialog.progressDialog(context);
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
                          validator: ValidationBuilder().minLength(6, 'Username must be at least 6 character').maxLength(15, 'Username must be at most 15 character').build(),
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
                          validator: ValidationBuilder().email('Email must be valid format').build(),
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
                          validator: ValidationBuilder().minLength(8, 'Password must be at least 8 character').maxLength(16, 'Password must be at most 16 character').build(),
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
                          validator: ValidationBuilder().minLength(2, 'Please choose a nation').build(),
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
                                  _chooseNation(),
                            ).then((value){
                              Nation nation = value;
                              _nationController.text = nation.nation;
                              nationLink = nation.image;
                            });
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
