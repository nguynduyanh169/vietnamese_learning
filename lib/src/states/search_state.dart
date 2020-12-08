import 'package:vietnamese_learning/src/models/post.dart';

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
  final Map<String, dynamic> searchList;
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
  final Map<String, dynamic> searchList;
  const LoadedSearchHistory(this.searchList);
}