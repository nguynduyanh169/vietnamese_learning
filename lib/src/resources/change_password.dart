import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/change_password_cubit.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/states/change_password_state.dart';
import 'package:vietnamese_learning/src/utils/firebase_util.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

import 'login_page.dart';

class ChangePasswordScreen extends StatelessWidget{
  String username;
  String email;
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtConfirmPassword = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  ChangePasswordScreen({this.email, this.username});
  String error;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
        create: (context) => ChangePasswordCubit(UserRepository()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state){
              if(state is ChangePasswordSuccess){
                Navigator.pop(context);
                logout(context);
              }else if(state is ChangingPassword){
                CustomProgressDialog.progressDialog(context);
              }else if(state is ChangePasswordFailed){
                Navigator.pop(context);
                error = 'Confirm password is not correct';
              }else if(state is NoInternet){
                Navigator.pop(context);
                Toast.show('No internet connection!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white);
              }
            },
            builder:(context, state) {
              return Container(
                color: Color.fromRGBO(255, 239, 215, 100),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 15,
                            ),
                            Text(
                              'Change password',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Helvetica'),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                        Text('Set up your new password',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 85,
                          child: TextFormField(
                            validator: ValidationBuilder()
                                .minLength(
                                8, 'Password must be at least 8 character')
                                .maxLength(
                                16, 'Password must be at most 16 character')
                                .build(),
                            obscureText: true,
                            controller: txtPassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                labelText: 'New Password',
                                prefixIcon: Icon(CupertinoIcons.lock_fill)),
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 85,
                          child: TextFormField(
                            obscureText: true,
                            controller: txtConfirmPassword,
                            decoration: InputDecoration(
                                errorText: error,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                labelText: 'Confirm New Password',
                                prefixIcon: Icon(CupertinoIcons.lock_fill)),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 7,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.75,
                            height: 50.0,
                            child: Center(
                              child: Padding(
                                child: Text(
                                  "Finish",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Helvetica',
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                ),
                                padding: new EdgeInsets.only(left: 0.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              BlocProvider.of<ChangePasswordCubit>(context)
                                  .changePassword(
                                  email, txtPassword.text,
                                  txtConfirmPassword.text);
                            }
                          },
                          color: const Color.fromRGBO(255, 190, 51, 60),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 7,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ),
    );
  }


  Future<Null> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('accessToken');
    prefs.remove(username + 'profile');
    prefs.remove(username  + "SearchHistory");
    prefs.remove(username + 'schedule');
    signOutUser();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }



}

