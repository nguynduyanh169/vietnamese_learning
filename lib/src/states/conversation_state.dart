import 'package:vietnamese_learning/src/models/conversation.dart';

abstract class ConversationState {
  const ConversationState();
}

class ConversationsLoading extends ConversationState {
  const ConversationsLoading();
}

class ConversationsLoaded extends ConversationState {
  final List<Conversation> conversations;

  const ConversationsLoaded(this.conversations);
}

class ConversationLoadError extends ConversationState {
  final String error;
  const ConversationLoadError(this.error);
}
