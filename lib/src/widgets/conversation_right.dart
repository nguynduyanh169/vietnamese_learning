import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class ConversationRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 15,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Xin chào, bạn tên gì?",
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.redAccent,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Hello, what is your name?",
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 3,
          ),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Color.fromRGBO(255, 190, 51, 5)),
            child: IconButton(
              icon: Icon(CupertinoIcons.volume_up, color: Colors.white),
              onPressed: null,
            ),
            width: SizeConfig.blockSizeHorizontal * 10,
            margin: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
