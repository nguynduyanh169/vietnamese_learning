import 'package:flutter/material.dart';

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
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 80,
                // child: InkWell(
                //   onTap: () => pushNewScreen(
                //     context,
                //     screen: ConversationDetail(),
                //     withNavBar: true,
                //   ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const ShapeDecoration(
                          color: Colors.red,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.volume_up, color: Colors.white,), onPressed: (null),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${entries[index]}', style: TextStyle(fontSize: 20, color: Colors.red),),
                            SizedBox(height: 10,),
                            Text('${english[index]}', style: TextStyle(fontSize: 15,),),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}
