import 'package:vietnamese_learning/src/providers/progress_provider.dart';

class ProgressRepository {
  ProgressProvider _progressProvider = new ProgressProvider();

  Future<bool> createProgress(int levelId, String token){
    return _progressProvider.createProgress(levelId, token);
  }
}