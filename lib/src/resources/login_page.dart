import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:vietnamese_learning/src/resources/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Widget _continueWithGoogleButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image(
  //               image: AssetImage("assets/images/google_logo.png"),
  //               height: 35.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Continue with Google',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _continueWithFacebookButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {},
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image(
  //               image: AssetImage("assets/images/facebook_logo.png"),
  //               height: 35.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Continue with Facebook',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _continueWithTwitterButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {},
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image(
  //             image: AssetImage("assets/images/twitter_logo.png"),
  //             height: 35.0,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Continue with Twitter',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/vietnameselearn.png'))),
              ),
              SizedBox(height: 100),
              SignInButton(
                  buttonType: ButtonType.google,
                  buttonSize: ButtonSize.large,
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HomePage(),
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
                  }),
              SizedBox(height: 10),
              SignInButton(
                  buttonType: ButtonType.facebook,
                  buttonSize: ButtonSize.large,
                  onPressed: () {}),
              SizedBox(height: 10),
              SignInButton(
                  buttonType: ButtonType.twitter,
                  buttonSize: ButtonSize.large,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
