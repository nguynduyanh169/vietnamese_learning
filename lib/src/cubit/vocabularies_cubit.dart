
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/states/vocabularies_state.dart';

class VocabulariesCubit extends Cubit<VocabulariesState>{
  final VocabularyRepository _vocabularyRepository;

  VocabulariesCubit(this._vocabularyRepository): super(VocabulariesLoading());

  Future<void> loadVocabulariesByLessonId(String lessonId) async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Vocabulary> vocabularies = await _vocabularyRepository.getVocabulariesByLessonId(lessonId, token);
      emit(VocabulariesLoaded(vocabularies));
    } on Exception{
      emit(VocabulariesLoadError('Load Vocabularies Error!'));
    }
  }
}