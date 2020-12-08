import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  PostRepository _postRepository;
  SearchCubit(this._postRepository) : super(InitialSearch());

  Future<void> searchPost(String search) async {
    try {
      Map<String, dynamic> searchList = new Map<String, dynamic>();
      emit(Searching());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString("username");
      String token = prefs.getString('accessToken');
      if(prefs.getString(username) == null){
        List<Content> searchPost = await _postRepository.searchPosts(token, search);
        if(searchPost.isNotEmpty){
          searchList[DateTime.now().toString()] = search;
          prefs.setString(username, json.encode(searchList));
          emit(SearchSuccess(json.decode(prefs.getString(username)), search, searchPost));
        }else{
          emit(SearchFailed());
        }

      }else {
        List<Content> searchPost = await _postRepository.searchPosts(token, search);
        if(searchPost.isNotEmpty){
          searchList = json.decode(prefs.getString(username));
          searchList[DateTime.now().toString()] = search;
          prefs.setString(username, json.encode(searchList));
          emit(SearchSuccess(json.decode(prefs.getString(username)), search, searchPost));
        }
        else{
          emit(SearchFailed());
        }
      }
    } on Exception {
      emit(SearchFailed());
    }
  }

  Future<void> getListSearch() async {
    Map<String, dynamic> searchList = new Map<String, dynamic>();
    emit(LoadingSearchHistory());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    //prefs.setString(username, json.encode(searchList));
    searchList = json.decode(prefs.getString(username));
    emit(LoadedSearchHistory(searchList));
  }
}
