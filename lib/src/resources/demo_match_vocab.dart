import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class DemoMatchVocab extends StatefulWidget {
  DemoMatchVocab({Key key}) : super(key: key);

  _MatchVocabState createState() => _MatchVocabState();
}

class _MatchVocabState extends State<DemoMatchVocab> {
  List<Widget> _rows;

  @override
  void initState() {
    super.initState();
    _rows = List<Widget>.generate(2,
            (int index) =>
            Row(key: ValueKey(index), children: [(Text('$index 1')), Text('$index 2')],)
    );
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
    }

    return Scaffold(
      body: ReorderableColumn(
        header: Text('THIS IS THE HEADER ROW'),
        footer: Text('THIS IS THE FOOTER ROW'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _rows,
        onReorder: _onReorder,
      ),
    );
  }
}
