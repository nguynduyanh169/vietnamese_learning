import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/models/search_history.dart';

abstract class SearchState {
  const SearchState();
}

class InitialSearch extends SearchState{
  const InitialSearch();
}

class Searching extends SearchState{
  const Searching();
}
class SearchSuccess extends SearchState{
  final List<SearchHistory> searchList;
  final String searchKey;
  final List<Content> searchPosts;
  const SearchSuccess(this.searchList, this.searchKey, this.searchPosts);
}

class SearchFailed extends SearchState{
  const SearchFailed();
}

class LoadingSearchHistory extends SearchState{
  const LoadingSearchHistory();
}

class LoadedSearchHistory extends SearchState{
  final List<SearchHistory> searchList;
  const LoadedSearchHistory(this.searchList);
}

class DeleteSearchHistory extends SearchState{
  final List<SearchHistory> searchList;
  const DeleteSearchHistory(this.searchList);
}

class ClearSearchHistory extends SearchState{
  const ClearSearchHistory();
}