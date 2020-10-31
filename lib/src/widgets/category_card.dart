import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/image_utils.dart';

class CategoryCard extends StatelessWidget {
  final String img;
  final String title;
  final String progressStatus;
  final Function press;

  const CategoryCard(
      {Key key, this.img, this.title, this.press, this.progressStatus})
      : super(key: key);

  Widget _lock() {
    print(progressStatus);
    if (progressStatus == 'lock') {
      return Container(
        child: IconButton(
          icon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          onPressed: null,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: Colors.black,
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: press,
            // child: Padding(
            //   padding: const EdgeInsets.only(
            //       left: 20, right: 20.0, top: 10, bottom: 0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 3),
                  child: Container(
                    width: 180,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(230, 157, 0, 30),
                    ),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: _lock(),
                    ),
                    // child: Image(
                    //   width: 90,
                    //   height: 90,
                    //   image: NetworkImage(GoogleImageUtil.editUrl(img)),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 4),
                  alignment: Alignment.topLeft,
                  child: Text(
                    title.trim(),
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "3 Courses",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
