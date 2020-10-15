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
    {'english': 'Bird', 'vietnamese': 'Con chim', 'img': 'assets/images/demovocab/bird.png'},
    {'english': 'Chicken', 'vietnamese': 'Con gà', 'img': 'assets/images/demovocab/chicken.png'},
    {'english': 'Phone', 'vietnamese': 'Cái điện thoại', 'img': 'assets/images/demovocab/phone.png'},
    {'english': 'Dog', 'vietnamese': 'Con chó', 'img': 'assets/images/demovocab/dog.png'},
    {'english': 'Mouse', 'vietnamese': 'Con chuột', 'img': 'assets/images/demovocab/mouse.png'},
    {'english': 'Car', 'vietnamese': 'Xe hơi', 'img': 'assets/images/demovocab/car.png'},
    {'english': 'Wind', 'vietnamese': 'Gió', 'img': 'assets/images/demovocab/bird.png'},
    {'english': 'Alcohol', 'vietnamese': 'Rượu', 'img': 'assets/images/demovocab/dog.png'},
    {'english': 'Bike', 'vietnamese': 'Xe đạp', 'img': 'assets/images/demovocab/bike.png'},
    {'english': 'Tree', 'vietnamese': 'Cái cây', 'img': 'assets/images/demovocab/tree.png'},
    {'english': 'TV', 'vietnamese': 'Cái ti vi', 'img': 'assets/images/demovocab/bird.png'}
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
