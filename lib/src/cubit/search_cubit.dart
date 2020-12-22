import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/models/search_history.dart';
import 'package:vietnamese_learning/src/states/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  PostRepository _postRepository;
  SearchCubit(this._postRepository) : super(InitialSearch());

  Future<void> searchPost(String search) async {
    try {
      List<SearchHistory> searchList = new List<SearchHistory>();
      emit(Searching());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString("username");
      String token = prefs.getString('accessToken');
      if(search == ''){
        emit(SearchFailed());
      }else {
        if (prefs.getString(username + "SearchHistory") == null) {
          List<Content> searchPost = await _postRepository.searchPosts(
              token, search);
          if (searchPost.isNotEmpty) {
            SearchHistory searchHistory = new SearchHistory(
                date: DateTime.now(), searchString: search);
            searchList.add(searchHistory);
            prefs.setString(
                username + "SearchHistory", SearchHistory.encoder(searchList));
            print(prefs.getString(username + "SearchHistory"));
            emit(SearchSuccess(SearchHistory.decoder(
                prefs.getString(username + "SearchHistory")), search,
                searchPost));
          } else {
            emit(SearchFailed());
          }
        }
        else {
          List<Content> searchPost = await _postRepository.searchPosts(
              token, search);
          print(searchPost.length);
          if (searchPost.isNotEmpty) {
            searchList = SearchHistory.decoder(
                prefs.getString(username + "SearchHistory"));
            SearchHistory searchHistory = new SearchHistory(
                date: DateTime.now(), searchString: search);
            searchList.add(searchHistory);
            prefs.setString(
                username + "SearchHistory", SearchHistory.encoder(searchList));
            emit(SearchSuccess(SearchHistory.decoder(
                prefs.getString(username + "SearchHistory")), search,
                searchPost));
          }
          else {
            emit(SearchFailed());
          }
        }
      }
    } on Exception{
      emit(SearchFailed());
    }
  }

  Future<void> getListSearch() async {
    emit(LoadingSearchHistory());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    List<SearchHistory> searchList = SearchHistory.decoder(prefs.getString(username + "SearchHistory"));
    emit(LoadedSearchHistory(searchList));
  }

  Future<void> deleteSearchHistory(SearchHistory searchHistory) async{
    List<SearchHistory> searchList = new List<SearchHistory>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    searchList = SearchHistory.decoder(prefs.getString(username + "SearchHistory"));
    searchList.removeWhere((element) => element.date == searchHistory.date);
    prefs.setString(username + "SearchHistory", SearchHistory.encoder(searchList));
    emit(DeleteSearchHistory(SearchHistory.decoder(prefs.getString(username + "SearchHistory"))));
  }
   Future<void> clearSearchHistory() async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     String username = prefs.getString("username");
     prefs.remove(username + "SearchHistory");
     emit(ClearSearchHistory());
   }
}
