import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/resources/conversation_detail.dart';
import 'package:vietnamese_learning/src/resources/conversation_screen.dart';
import 'package:vietnamese_learning/src/resources/quiz_screen.dart';

class ConversationGetStarted extends StatefulWidget {
  ConversationGetStarted({Key key}) : super(key: key);

  _ConversationGetStartedState createState() => _ConversationGetStartedState();
}

class _ConversationGetStartedState extends State<ConversationGetStarted> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.amber[400],
        appBar: AppBar(
          title: Text(
            "Conversation",
            style: TextStyle(color: Colors.white70),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.amber[400],
          shadowColor: Colors.amber[400],
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 50, left: 77, right: 80),
              width: SizeConfig.blockSizeHorizontal * 60,
              child: Image(
                image: AssetImage('assets/images/conversation_logo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Lesson 1: Greeting",
                style: GoogleFonts.sansita(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Greeting Conversation",
                style: GoogleFonts.sansita(
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              height: 80.0,
              child: Card(
                color: Colors.brown[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ConversationDetail(),
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Learn Now",
                              style: GoogleFonts.sansita(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
