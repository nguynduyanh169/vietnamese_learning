import 'package:bloc/bloc.dart';
import 'package:vietnamese_learning/src/states/learn_converasation_state.dart';

class LearnConversationCubit extends Cubit<LearnConversationState> {
  int conversationsLength;
  LearnConversationCubit(this.conversationsLength)
      : super(LearnConversationInitial());

  Future<void> learnFlashCard(int conversationsIndex) async {
    print(conversationsIndex);
    if (conversationsIndex > conversationsLength - 1) {
      print(conversationsIndex);
      emit(LearnConversationDone(conversationsLength));
    } else {
      emit(LearnConversationFlashCard(conversationsIndex));
    }
  }

  Future<void> learnSpeaking(int conversationsIndex) async {
    if (conversationsIndex > conversationsLength - 1) {
      emit(LearnConversationDone(conversationsLength));
    } else {
      emit(LearnConversationSpeaking(conversationsIndex));
    }
  }

  Future<void> learnMatching(int conversationsIndex) async {
    if (conversationsIndex > conversationsLength - 1) {
      emit(LearnConversationDone(conversationsLength));
    } else {
      emit(LearnConversationPuzzle(conversationsIndex));
    }
  }
}
