import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/forget_password_cubit.dart';
import 'package:vietnamese_learning/src/states/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Widget _sendEmail(BuildContext context) {
      return Center(
        child: Column(
          children: <Widget>[
            Text('Change Password',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Text('Enter your email to receive confirmation code',
                style: TextStyle(fontFamily: 'Helvetica', fontSize: 15)),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Email',
                    prefixIcon: Icon(CupertinoIcons.mail_solid)),
              ),
            ),
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
                      "Send confirmation code",
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
                BlocProvider.of<ForgetPasswordCubit>(context).sendEmail();
              },
              color: const Color.fromRGBO(255, 190, 51, 60),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 7,
            ),
            Container(
              child: InkWell(
                child: Text(
                  "Back to Sign In",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget _enterCode(BuildContext context) {
      return Center(
        child: Column(
          children: <Widget>[
            Text('Verification',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Text('Enter your confirmation code sent to your email',
                style: TextStyle(fontFamily: 'Helvetica', fontSize: 15)),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
                maxLength: 4,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Code',
                    prefixIcon: Icon(CupertinoIcons.lock_open_fill)),
              ),
            ),
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
                      "Verify",
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
                BlocProvider.of<ForgetPasswordCubit>(context).enterCode();
              },
              color: const Color.fromRGBO(255, 190, 51, 60),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 7,
            ),
            Container(
              child: InkWell(
                child: Text(
                  "Back to Sign In",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget _changePassword(BuildContext context){
      return Center(
        child: Column(
          children: <Widget>[
            Text('Change Password',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Text('Set your new password',
                style: TextStyle(fontFamily: 'Helvetica', fontSize: 15)),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: TextField(
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
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Confirm New Password',
                    prefixIcon: Icon(CupertinoIcons.lock_fill)),
              ),
            ),
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
                      "Finish",
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
                BlocProvider.of<ForgetPasswordCubit>(context).changePassword();
              },
              color: const Color.fromRGBO(255, 190, 51, 60),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 7,
            ),
            Container(
              child: InkWell(
                child: Text(
                  "Back to Sign In",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    }

    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signupbackground.png"),
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state){
                if(state is ChangePasswordSuccess){
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state){
                if(state is EnterCode){
                  return _enterCode(context);
                }else if(state is ChangePassword){
                  return _changePassword(context);
                }
                else{
                  return _sendEmail(context);
                }
              },
            )),
      ),
    );
  }
}
