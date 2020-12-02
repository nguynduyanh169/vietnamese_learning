import 'package:bloc/bloc.dart';
import 'package:vietnamese_learning/src/states/search_state.dart';

class SearchCubit extends Cubit<SearchState>{

  SearchCubit(): super(InitialSearch());

  Future<void> searchPost(String search) async{}

}