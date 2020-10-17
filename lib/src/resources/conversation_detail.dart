import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'home_screen.dart';

class ConversationDetail extends StatefulWidget {
  ConversationDetail({Key key}) : super(key: key);

  _ConversationDetailState createState() => _ConversationDetailState();
}

class _ConversationDetailState extends State<ConversationDetail> {

  final List<String> entries = <String>['Xin Chào', 'Bạn tên gì', 'Bạn bao nhiêu tuổi'];
  final List<String> english = <String>['Hello', 'What is your name', 'How old are you'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Conversation Detail",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black),  onPressed: () => Navigator.of(context).pop(),),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
        ),
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              width: SizeConfig.blockSizeVertical *60,
              height: SizeConfig.blockSizeHorizontal * 40,
              child: Image(
                image: AssetImage('assets/images/chaohoi.png'),
              ),
            ),
            Container(
                height: SizeConfig.blockSizeHorizontal *15,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.volume_up, color: Colors.white),
                      ),
                      width: SizeConfig.blockSizeHorizontal * 10,
                      margin: const EdgeInsets.all(8),
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Xin chào",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Hello",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
            Container(
                height: SizeConfig.blockSizeHorizontal *15,
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
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Hello, what is your name?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal *15,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tôi tên Nam, còn bạn tên gì?",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "My name is Nam, what is you name?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal *15,
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
                        "Tôi tên là Mạnh",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "My name is Mạnh",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal *15,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bạn có khoẻ không?",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "How are you?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal *15,
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
                        "Tôi khỏe, cảm ơn. Còn bạn?",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "I'm fine, thank you. And you?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal *15,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tôi khỏe, cảm ",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "I'm fine, thanks",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal *15,
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
                        "Tôi khỏe, cảm ơn. Còn bạn?",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "I'm fine, thank you. And you?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal *15,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    margin: const EdgeInsets.all(8),
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tôi khỏe, cảm ơn",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "I'm fine, thanks",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
