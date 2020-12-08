import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/search_cubit.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/search_state.dart';
import 'package:vietnamese_learning/src/widgets/search_bar.dart';
import 'package:vietnamese_learning/src/widgets/search_result.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Map<String, dynamic> searchHistory = new Map<String, dynamic>();
  Widget _searchHistoryElement(String searchHistory) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  searchHistory,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.xmark_circle),
            onPressed: () {
              print("delete history");
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SearchCubit(PostRepository())..getListSearch(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is Searching) {
            print("Searching");
          } else if (state is SearchSuccess) {
            print('success');
            searchHistory.clear();
            searchHistory = state.searchList;
            List<Content> searchPosts = state.searchPosts;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchResult(searchPosts: searchPosts,)));
          }else if(state is LoadingSearchHistory){
            print('loading');
          }else if(state is LoadedSearchHistory){
            print('success');
            searchHistory = state.searchList;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(255, 239, 215, 1),
            body: Container(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: IconButton(
                          iconSize: 20,
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Container(
                        width: 320,
                        height: 48,
                        margin: EdgeInsets.only(top: 16, bottom: 9),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29.5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search by title",
                            hintStyle: TextStyle(fontFamily: 'Helvetica'),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            print(value);
                            BlocProvider.of<SearchCubit>(context)
                                .searchPost(value);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SearchResult()));
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black26,
                          width: 1.0,
                        ),
                        top: BorderSide(
                          color: Colors.black26,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Search history",
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 54,
                          ),
                          InkWell(
                            onTap: (){
                              print('delete histories');
                            },
                            child: Text(
                            "CLEAR",
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Helvetica'),
                          ),)

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: searchHistory.length,
                        itemBuilder: (BuildContext context, int index){
                          String key = searchHistory.keys.elementAt(index);
                          return _searchHistoryElement(searchHistory[key]);
                        },
                  ))
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Container(
                  //         padding: EdgeInsets.only(
                  //             left: SizeConfig.blockSizeHorizontal * 5),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Text(
                  //               'hsfgihsadbfhjsdbf',
                  //               style: TextStyle(
                  //                 fontFamily: 'Helvetica',
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(CupertinoIcons.xmark_circle),
                  //         onPressed: null,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Container(
                  //         padding: EdgeInsets.only(
                  //             left: SizeConfig.blockSizeHorizontal * 5),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Text(
                  //               'hsfgihsadbfhjsdbf',
                  //               style: TextStyle(
                  //                 fontFamily: 'Helvetica',
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(CupertinoIcons.xmark_circle),
                  //         onPressed: null,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Container(
                  //         padding: EdgeInsets.only(
                  //             left: SizeConfig.blockSizeHorizontal * 5),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Text(
                  //               'hsfgihsadbfhjsdbf',
                  //               style: TextStyle(
                  //                 fontFamily: 'Helvetica',
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(CupertinoIcons.xmark_circle),
                  //         onPressed: null,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Container(
                  //         padding: EdgeInsets.only(
                  //             left: SizeConfig.blockSizeHorizontal * 5),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Text(
                  //               'hsfgihsadbfhjsdbf',
                  //               style: TextStyle(
                  //                 fontFamily: 'Helvetica',
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(CupertinoIcons.xmark_circle),
                  //         onPressed: null,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


