import 'package:bloc/bloc.dart';
import 'package:vietnamese_learning/src/states/learn_vocabulary_state.dart';

class LearnVocabularyCubit extends Cubit<LearnVocabularyState>{
  LearnVocabularyCubit() : super(LearnVocabularyInitial());

  Future<void> learnFlashCard(int vocabulariesIndex) async{
    if(vocabulariesIndex > 10){
      emit(LearnVocabularyDone());
    }
    else {
      emit(LearnVocabularyFlashCard(vocabulariesIndex));
    }
  }

  Future<void> learnWriting(int vocabulariesIndex) async{
    if(vocabulariesIndex > 10){
      emit(LearnVocabularyDone());
    }
    else {
      emit(LearnVocabularyWriting(vocabulariesIndex));
    }
  }
}