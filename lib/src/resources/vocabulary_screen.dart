import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/widgets/vocabulary.dart';
import 'package:vietnamese_learning/src/widgets/vocabulary_result.dart';

class VocabularyScreen extends StatefulWidget {
  VocabularyScreen({Key key}) : super(key: key);

  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  var _vocabularyIndex = 0;
  final _vocabularies = const [
    {'english': 'Bird', 'vietnamese': 'Con Chim'},
    {'english': 'Chicken', 'vietnamese': 'Con Ga'},
    {'english': 'Phone', 'vietnamese': 'Cai Dien Thoai'},
    {'english': 'Water', 'vietnamese': 'Nuoc'},
    {'english': 'Fire', 'vietnamese': 'Lua'},
    {'english': 'Ear', 'vietnamese': 'Tai'},
    {'english': 'Wind', 'vietnamese': 'Gio'},
    {'english': 'Alcohol', 'vietnamese': 'Ruou'},
    {'english': 'Bike', 'vietnamese': 'Xe Dap'},
    {'english': 'Tree', 'vietnamese': 'Cai Cay'},
    {'english': 'TV', 'vietnamese': 'Cai TV'}
  ];

  void nextQuestion() {
    setState(() {
      _vocabularyIndex = _vocabularyIndex + 1;
    });
    print('VocabularyIndex:$_vocabularyIndex');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _vocabularyIndex < _vocabularies.length
            ? Vocabulary(
                vocabularies: _vocabularies,
                nextHandler: nextQuestion,
                vocabularyIndex: _vocabularyIndex)
            : VocabularyResult(),
      ),
    );
  }
}
