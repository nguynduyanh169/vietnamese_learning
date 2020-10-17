import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/resources/vocabulary_screen.dart';
import 'package:vietnamese_learning/src/resources/writing_vocab_screen.dart';

class VocabDetailScreen extends StatefulWidget {
  VocabDetailScreen({Key key}) : super(key: key);

  _VocabDetailScreenState createState() => _VocabDetailScreenState();
}

class _VocabDetailScreenState extends State<VocabDetailScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: Text(
            "Vocabulary",
            style: TextStyle(color: Colors.white70),
          ),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white70),  onPressed: () => Navigator.of(context).pop(),),
          backgroundColor: Colors.green,
          shadowColor: Colors.green,
        ),
        body: Container(
          width: SizeConfig.blockSizeHorizontal * 99,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage('assets/images/vocabulary_logo.png'),
                  width: 160,
                  height: 160,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Lesson 1 | 10 Vocabulary ",
                  style: GoogleFonts.sansita(
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 13,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 70.0,
                child: Card(
                  color: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    child: Center( child: Text(
                      'FlashCard',
                      style: GoogleFonts.sansita(
                        fontSize: 40,
                        color: Colors.white,
                      ),),),
                    onTap: () => pushNewScreen(
                      context,
                      screen: VocabularyScreen(),
                    ),

                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 70.0,
                child: Card(
                color: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    child: Center(child: Text('Writing',
                      style: GoogleFonts.sansita(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),),
                    onTap: () => pushNewScreen(
                          context,
                          screen: WritingVocabScreen(),
                        )),
              ),)
            ],
          ),
        ));
  }
}
