import 'package:bloc/bloc.dart';
import 'package:vietnamese_learning/src/states/learn_vocabulary_state.dart';

class LearnVocabularyCubit extends Cubit<LearnVocabularyState>{
  int vocabulariesLength;
  LearnVocabularyCubit(this.vocabulariesLength) : super(LearnVocabularyInitial());

  Future<void> learnFlashCard(int vocabulariesIndex) async{
    print(vocabulariesIndex);
    if(vocabulariesIndex > vocabulariesLength -1 ){
      print(vocabulariesIndex);
      emit(LearnVocabularyDone(vocabulariesLength));
    }
    else {
      emit(LearnVocabularyFlashCard(vocabulariesIndex));
    }
  }

  Future<void> learnWriting(int vocabulariesIndex) async{
    if(vocabulariesIndex > vocabulariesLength - 1){
      emit(LearnVocabularyDone(vocabulariesLength));
    }
    else {
      emit(LearnVocabularyWriting(vocabulariesIndex));
    }
  }

  Future<void> learnMatching(int vocabulariesIndex) async{
    if(vocabulariesIndex > vocabulariesLength - 1){
      emit(LearnVocabularyDone(vocabulariesLength));
    }
    else {
      emit(LearnVocabularyPuzzle(vocabulariesIndex));
    }
  }
}