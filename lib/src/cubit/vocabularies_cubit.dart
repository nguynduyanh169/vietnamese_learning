
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/states/vocabularies_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class VocabulariesCubit extends Cubit<VocabulariesState>{
  final VocabularyRepository _vocabularyRepository;
  HiveUtils _hiveUtils = new HiveUtils();

  VocabulariesCubit(this._vocabularyRepository): super(VocabulariesLoading());

  Future<void> loadVocabulariesByLessonId(String lessonId) async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Vocabulary> vocabularies = await _vocabularyRepository.getVocabulariesByLessonId(lessonId, token);
      var connectivityResult = await (Connectivity().checkConnectivity());
      double percent = 0;
      int index = 0;
      if(connectivityResult != ConnectivityResult.none){
        for(Vocabulary vocabulary in vocabularies){
          bool fileImageExist = _hiveUtils.fileExist(url: vocabulary.image, boxName: 'CacheFile');
          bool fileAudioExist = _hiveUtils.fileExist(url: vocabulary.voice_link, boxName: 'CacheFile');
          if(!fileImageExist){
            if(vocabulary.image != null){
              String fileImagePath = await _hiveUtils.downloadFile(vocabulary.image);
              _hiveUtils.addFile(filePath: fileImagePath, url: vocabulary.image, boxName: 'CacheFile');
            }
          }
          if(!fileAudioExist){
            if(vocabulary.voice_link != null){
              String fileAudioPath = await _hiveUtils.downloadFile(vocabulary.voice_link);
              _hiveUtils.addFile(filePath: fileAudioPath, url: vocabulary.voice_link, boxName: 'CacheFile');
            }
          }
          index = index + 1;
          percent = index * (1 / (vocabularies.length));
          emit(DownloadingPercentage(percent));
        }
      }
      emit(VocabulariesLoaded(vocabularies));
    } on Exception{
      emit(VocabulariesLoadError('Load Vocabularies Error!'));
    }
  }
}