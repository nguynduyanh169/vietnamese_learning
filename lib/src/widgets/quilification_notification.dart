import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/progress_cubit.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/resources/home_page.dart';
import 'package:vietnamese_learning/src/states/progress_state.dart';

class QualificationNotification extends StatelessWidget {
  int level;
  LoginResponse loginResponse;
  String username;
  ProgressDialog pr;
  BuildContext _ctx;
  QualificationNotification({Key key, this.level, this.loginResponse, this.username});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _ctx = context;
    pr = new ProgressDialog(context, showLogs: true, isDismissible: false);
    pr.style(
        progressWidget: CupertinoActivityIndicator(),
        message: 'Please wait...');
    return BlocProvider(
        create: (context) => ProgressCubit(ProgressRepository()),
        child: BlocConsumer<ProgressCubit, ProgressState>(
          listener: (context, state){
            if(state is CreatingProgress){
              pr.show();
            }else if(state is CreateProgressSuccess){
              print('success');
              pr.hide().whenComplete(() => Navigator.of(_ctx).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage())));
            }
          },
          builder: (context, state){
            return Container(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/qualification.png'),
                      fit: BoxFit.fill),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                      Text(
                        "Your have completed the entrance test",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica',
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Text(
                        "You have achieved level",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Helvetica',
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 20,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 60.0,
                          child: Center(
                            child: Padding(
                              child: Text(
                                "Finish",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Helvetica'),
                              ),
                              padding: new EdgeInsets.only(left: 0.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print(loginResponse.accessToken);
                          print(username);
                          BlocProvider.of<ProgressCubit>(context).createProgress(level, loginResponse, username);
                        },
                        color: Color.fromRGBO(255, 210, 77, 10),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                    ],
                  ),
                ));
          },
        ),
    );
  }
}
