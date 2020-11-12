import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/states/conversation_state.dart';

class ConversationsCubit extends Cubit<ConversationState> {
  final ConversationRepository _conversationRepository;

  ConversationsCubit(this._conversationRepository)
      : super(ConversationsLoading());

  Future<void> loadConversationsByLessonId(String lessonId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Conversation> conversations = await _conversationRepository
          .getConversationsByLessonId(lessonId, token);
      emit(ConversationsLoaded(conversations));
    } on Exception {
      emit(ConversationLoadError('Load Vocabularies Error!'));
    }
  }
}
