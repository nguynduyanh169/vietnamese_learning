import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/resources/conversation_detail.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


import 'home_screen.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen({Key key}) : super(key: key);

  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  final List<String> entries = <String>['Hello', 'How are you', 'Where do you live'];
  final List<String> vietnamese = <String>['Xin chào', 'Bạn khỏe không', 'Bạn sống ở đâu'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Conversation",
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
              height: 100,
              child: InkWell(
                onTap: () => pushNewScreen(
                  context,
                  screen: ConversationDetail(),
                  withNavBar: true,
                ),
                child: Row(
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage('assets/images/chaohoi.png'),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${entries[index]}', style: TextStyle(fontSize: 20),),
                          Text('${vietnamese[index]}', style: TextStyle(fontSize: 20),),
                          SizedBox(height: 20,),
                          Container(
                            width: 80,
                            height: 25,
                            child: Center(
                              child: Text(
                                "Study Now",
                                style: TextStyle(
                                  color: Colors.redAccent
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.redAccent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}
