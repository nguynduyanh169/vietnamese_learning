
abstract class LearnVocabularyState{
  const LearnVocabularyState();
}

class LearnVocabularyInitial extends LearnVocabularyState{
  const LearnVocabularyInitial();
}

class LearnVocabularyFlashCard extends LearnVocabularyState{
  final int vocabulariesIndex;
  const LearnVocabularyFlashCard(this.vocabulariesIndex);
}

class LearnVocabularyWriting extends LearnVocabularyState{
  final int vocabulariesIndex;
  const LearnVocabularyWriting(this.vocabulariesIndex);
}

class LearnVocabularyDone extends LearnVocabularyState{
  const LearnVocabularyDone();
}