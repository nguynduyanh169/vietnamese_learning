import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/widgets/search_result.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 48,
      margin: EdgeInsets.only(top: 16, bottom: 9),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(fontFamily: 'Helvetica'),
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchResult()));
        },
      ),
    );
  }
}
