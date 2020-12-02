abstract class SearchState {
  const SearchState();
}

class InitialSearch extends SearchState{
}

class Searching extends SearchState{
}
class SearchSuccess extends SearchState{}

class SearchFailed extends SearchState{}