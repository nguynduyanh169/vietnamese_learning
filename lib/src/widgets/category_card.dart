import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/utils/image_utils.dart';

class CategoryCard extends StatelessWidget {
  final String img;
  final String title;
  final Function press;

  const CategoryCard({
    Key key,
    this.img,
    this.title,
    this.press,
  }) : super(key: key);

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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20.0, top: 10, bottom: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      title.trim(),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      width: 90,
                      height: 90,
                      image: NetworkImage(
                          GoogleImageUtil.editUrl(img)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
