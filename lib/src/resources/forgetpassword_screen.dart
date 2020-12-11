
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/forget_password_cubit.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/states/forget_password_state.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

class ForgetPasswordScreen extends StatelessWidget {
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtCode = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtConfirmPassword = new TextEditingController();
  String code;
  String email;
  @override
  Widget build(BuildContext context) {
    String emailInvalid, codeInvalid, confirmPasswordInvalid;
    SizeConfig().init(context);
    Widget _sendEmail(BuildContext context) {
      return Center(
        child: Column(
          children: <Widget>[
            Text('Enter Your Email',
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
              child: TextFormField(
                controller: txtEmail,
                decoration: InputDecoration(
                  errorText: emailInvalid,
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
                BlocProvider.of<ForgetPasswordCubit>(context).sendEmail(txtEmail.text);
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
              child: TextFormField(
                controller: txtCode,
                maxLength: 4,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  errorText: codeInvalid,
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
                BlocProvider.of<ForgetPasswordCubit>(context).enterCode(code, txtCode.text);
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
              child: TextFormField(
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
                controller: txtConfirmPassword,
                decoration: InputDecoration(
                  errorText: confirmPasswordInvalid,
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
                BlocProvider.of<ForgetPasswordCubit>(context).changePassword(email, txtPassword.text, txtConfirmPassword.text);
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
      create: (context) => ForgetPasswordCubit(UserRepository()),
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
                  Navigator.pop(context);
                  Navigator.of(context).pop();
                }else if(state is EnterCode){
                  Navigator.pop(context);
                  email = txtEmail.text;
                  code = state.code;
                  print(code);
                }else if(state is SendEmailFailed){
                  Navigator.pop(context);
                  emailInvalid = "Your email is invalid";
                }else if(state is  EnterCodeInvalid){
                  codeInvalid = "Your enter code is not correct";
                } else if(state is SendEmail){
                  CustomProgressDialog.progressDialog(context);
                } else if(state is ChangingPassword){
                  CustomProgressDialog.progressDialog(context);
                } else if(state is ChangePasswordFailed){
                  Navigator.pop(context);
                  confirmPasswordInvalid = "Confirm password is not correct";
                }
              },
              builder: (context, state){
                if(state is EnterCode || state is EnterCodeInvalid){
                  return _enterCode(context);
                }else if(state is ChangePassword || state is ChangePasswordFailed){
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
