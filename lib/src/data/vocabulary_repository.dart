
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/providers/vocabulary_provider.dart';

class VocabularyRepository{
  VocabularyProvider _vocabularyProvider = new VocabularyProvider();

  Future<List<Vocabulary>> getVocabulariesByLessonId(String lessonId, String token){
    return _vocabularyProvider.getVocabularyByLessonId(lessonId, token);
  }

}