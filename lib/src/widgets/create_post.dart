import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class CreatePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 239, 215, 1),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.7,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black26,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                Text(
                  "Create Post",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Helvetica',
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 53,
                ),
                InkWell(
                  child: Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      width: SizeConfig.blockSizeHorizontal * 15,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.05),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ]),
                      child: Center(
                        child: Text(
                          "Post",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Helvetica',
                            color: Colors.black45,
                          ),
                        ),
                      )),
                  onTap: () {
                    print('create');
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Ho Quang Bao',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontFamily: 'Helvetica'),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '20/11/2020',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 95,
            height: SizeConfig.blockSizeVertical * 20,
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
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Enter title here',
                labelStyle: TextStyle(fontFamily: 'Helvetica', fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 95,
            height: SizeConfig.blockSizeVertical * 43,
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
            child: TextField(
              maxLines: 13,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Enter content here',
                labelStyle: TextStyle(fontFamily: 'Helvetica', fontSize: 15,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
