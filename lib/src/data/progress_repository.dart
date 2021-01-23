import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/sync_progress.dart';
import 'package:vietnamese_learning/src/providers/progress_provider.dart';

class ProgressRepository {
  ProgressProvider _progressProvider = new ProgressProvider();

  Future<bool> createProgress(int levelId, String token){
    return _progressProvider.createProgress(levelId, token);
  }

  Future<Progress> syncProgress(String token, Progress progress){
    return _progressProvider.syncProgress(token, progress);
  }
}