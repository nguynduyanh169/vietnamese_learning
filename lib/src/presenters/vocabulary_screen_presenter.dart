
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';

abstract class VocabularyScreenContract {
  void onLoadVocabularySuccess(List<Vocabulary> vocabularies);

  void onLoadVocabularyError(String error);

}

class VocabularyScreenPresenter{
  VocabularyScreenContract _view;
  VocabularyRepository _vocabularyRepository = new VocabularyRepository();

  VocabularyScreenPresenter(this._view);

  loadVocabularyByLessonId(String lessonId) async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Vocabulary> vocabularies = await _vocabularyRepository.getVocabulariesByLessonId(lessonId, token);
      _view.onLoadVocabularySuccess(vocabularies);
    }catch(e){
      _view.onLoadVocabularyError(e.toString());
    }
  }
}