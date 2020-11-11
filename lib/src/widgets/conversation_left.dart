import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/widgets/conversation_detail.dart';

class ConversationLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 15,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ConversationDetail1()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 190, 51, 5),
              ),
              child: IconButton(
                icon: Icon(Icons.volume_up, color: Colors.white),
                onPressed: null,
              ),
              width: SizeConfig.blockSizeHorizontal * 10,
              margin: const EdgeInsets.all(8),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Xin chào",
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      color: Colors.redAccent,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hello",
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
