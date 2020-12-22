import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/game_data.dart';
import 'package:vietnamese_learning/src/models/memory_model.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/game_state.dart';

class Game_Cubit extends Cubit<GameStates>{
  final GameRepo _gameRepo;

  Game_Cubit(this._gameRepo) : super(GameLoading());

  Future<void> loadVocabularyByLevel() async{
    try{
      final SharedPreferences pref = await SharedPreferences.getInstance();
      String username = pref.get('username');
      UserProfile userProfile = UserProfile.fromJson(json.decode(pref.getString(username + 'profile')));
      int levelID = userProfile.studentLevel;
      String token = pref.getString('accessToken');
      List<TileModel> model = await _gameRepo.getVocabularyByLevel(levelID, token);
      emit(GameLoaded(model));
    }on Exception{
      emit(GameLoadError('Load Vocabularies Error!'));
    }
  }
}