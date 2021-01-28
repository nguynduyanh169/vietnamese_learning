abstract class LearnConversationState {
  const LearnConversationState();
}

class LearnConversationInitial extends LearnConversationState {
  const LearnConversationInitial();
}

class LearnConversationFlashCard extends LearnConversationState {
  final int conversationsIndex;
  const LearnConversationFlashCard(this.conversationsIndex);
}

class LearnConversationWriting extends LearnConversationState {
  final int conversationsIndex;
  const LearnConversationWriting(this.conversationsIndex);
}

class LearnConversationSpeaking extends LearnConversationState {
  final int conversationsIndex;
  const LearnConversationSpeaking(this.conversationsIndex);
}

class LearnConversationPuzzle extends LearnConversationState {
  final int conversationsIndex;
  const LearnConversationPuzzle(this.conversationsIndex);
}

class LearnConversationDone extends LearnConversationState {
  final int conversationsLength;
  const LearnConversationDone(this.conversationsLength);
}

class SubmittingProgress extends LearnConversationState{
  const SubmittingProgress();
}

class SubmittedProgress extends LearnConversationState{
  const SubmittedProgress();
}
