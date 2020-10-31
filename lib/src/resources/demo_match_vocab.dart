import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class DemoMatchVocab extends StatefulWidget {
  DemoMatchVocab({Key key}) : super(key: key);

  _MatchVocabState createState() => _MatchVocabState();
}

class _MatchVocabState extends State<DemoMatchVocab> {
  String result = 'CHÚ BẢO HỒNG';
  List<String> chars;
  List<Widget> _tiles;

  Widget _element(String content){
    return Container(
      width: 30,
      height: 30,
      child: Center(child: Text('$content', style: TextStyle(fontFamily: 'Helvetica'),),),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _tiles = new List();
    chars = result.split('').toList();
    for(String item in chars){
      _tiles.add(_element(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _tiles.removeAt(oldIndex);
        String char = chars.removeAt(oldIndex);
        _tiles.insert(newIndex, row);
        chars.insert(newIndex, char);
      });
    }

    var wrap = ReorderableWrap(
        spacing: 8.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(8),
        children: _tiles,
        onReorder: _onReorder,
        onNoReorder: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
        });

    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[wrap],
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            column,
            MaterialButton(
                onPressed: (){
                  String check = chars.join('');
                  for(String item in chars){
                    print(item);
                  }
                  print(check);
                },
                child: Text('Check'),
            )
          ]
        ),
      ),
    );
  }
}
