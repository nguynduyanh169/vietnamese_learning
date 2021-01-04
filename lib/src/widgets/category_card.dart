import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/url_utils.dart';

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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(0, 0, 0, 100),
          ),
          child: Column(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 80,
                child: IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(
                    CupertinoIcons.lock_fill,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
              )
            ],
          ),
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
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (context, url) => CupertinoActivityIndicator(radius: 15,),
                    imageBuilder: (context, imageProvider) => Container(
                      width: 180,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(230, 157, 0, 30),
                          // image: DecorationImage(
                          //     image: NetworkImage(img),
                          //     fit: BoxFit.fill)
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill
                        )
                      ),
                      child: Container(
                        alignment: Alignment.topRight,
                        child: _lock(),
                      ),
                    ),
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
                    //textAlign: TextAlign.center,
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 10),
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     "3 Courses",
                //     style: TextStyle(
                //       fontFamily: 'Helvetica',
                //       fontSize: 13,
                //     ),
                //   ),
                // ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
