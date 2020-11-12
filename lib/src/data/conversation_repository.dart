import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/providers/conversation_provider.dart';

class ConversationRepository {
  ConversationProvider _conversationProvider = new ConversationProvider();

  Future<List<Conversation>> getConversationsByLessonId(
      String lessonId, String token) {
    return _conversationProvider.getConversationByLessonId(lessonId, token);
  }
}
