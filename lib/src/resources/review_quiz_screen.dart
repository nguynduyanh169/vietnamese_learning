import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/models/review_quiz.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

class ReviewQuizScreen extends StatelessWidget {
  List<ReviewQuiz> incorrects;

  ReviewQuizScreen({this.incorrects});

  Widget _questionWidget(String question, int type){
    if(type == 1 || type == 4){
      return Text(
        question,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Helvetica'),
      );
    }else if(type == 2){
      return Container(
        width: 45,
        height: 45,
        //margin: EdgeInsets.only(left: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Color.fromRGBO(255, 190, 51, 100),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(255, 190, 51, 100),
              spreadRadius: 1,
              blurRadius: 1,
              offset:
              Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: IconButton(
            icon: Icon(
              CupertinoIcons.volume_up,
              color: Colors.white,
            ),
            onPressed: () {
              print('hear');
            }
        ),
      );
    }else if(type == 3){
      return Container(
        child: Image(
          width: SizeConfig.blockSizeHorizontal * 20,
          height: SizeConfig.blockSizeVertical * 18,
          image: NetworkImage(UrlUtils.editImgUrl(question)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 239, 215, 100),
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 15,
                  ),
                  Text(
                    'Review your quiz',
                    style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Expanded(
                child: ListView.separated(
                  itemCount: incorrects.length,
                  separatorBuilder: (context, index){
                    return SizedBox(height: SizeConfig.blockSizeVertical * 2,);
                  },
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 5,
                          right: SizeConfig.blockSizeHorizontal * 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.05),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                          _questionWidget(incorrects[index].question, incorrects[index].questionType),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                          Text(
                            'Correct answer is: ${incorrects[index].correct}',
                            style: TextStyle(fontFamily: 'Helvetica', color: Colors.green),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                          Text(
                            'Your answer is: ${incorrects[index].userAns}',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Helvetica', color: Colors.redAccent),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                        ],
                      ),
                    );
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
