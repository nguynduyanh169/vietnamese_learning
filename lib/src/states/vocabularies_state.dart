
import 'package:vietnamese_learning/src/models/vocabulary.dart';

abstract class VocabulariesState {
  const VocabulariesState();
}

class VocabulariesLoading extends VocabulariesState{
  const VocabulariesLoading();
}

class DownloadingPercentage extends VocabulariesState{
  final double percent;
  const DownloadingPercentage(this.percent);
}

class VocabulariesLoaded extends VocabulariesState{
  final List<Vocabulary> vocabularies;

  const VocabulariesLoaded(this.vocabularies);
}

class VocabulariesLoadError extends VocabulariesState{
  final String error;
  const VocabulariesLoadError(this.error);
}