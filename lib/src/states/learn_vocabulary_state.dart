abstract class LearnVocabularyState {
  const LearnVocabularyState();
}

class LearnVocabularyInitial extends LearnVocabularyState {
  const LearnVocabularyInitial();
}

class LearnVocabularyFlashCard extends LearnVocabularyState {
  final int vocabulariesIndex;
  const LearnVocabularyFlashCard(this.vocabulariesIndex);
}

class LearnVocabularyWriting extends LearnVocabularyState {
  final int vocabulariesIndex;
  const LearnVocabularyWriting(this.vocabulariesIndex);
}

class LearnVocabularySpeaking extends LearnVocabularyState {
  final int vocabulariesIndex;
  const LearnVocabularySpeaking(this.vocabulariesIndex);
}

class LearnVocabularyPuzzle extends LearnVocabularyState {
  final int vocabulariesIndex;
  const LearnVocabularyPuzzle(this.vocabulariesIndex);
}

class LearnVocabularyDone extends LearnVocabularyState {
  final int vocabulariesLength;
  const LearnVocabularyDone(this.vocabulariesLength);
}

class SubmittingProgress extends LearnVocabularyState{
  const SubmittingProgress();
}

class SubmittedProgress extends LearnVocabularyState{
  const SubmittedProgress();
}
