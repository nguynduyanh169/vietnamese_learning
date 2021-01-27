import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/states/lesson_details_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class LessonDetailsCubit extends Cubit<LessonDetailsState>{
  final VocabularyRepository _vocabularyRepository;
  final ConversationRepository _conversationRepository;
  final ProgressRepository _progressRepository;
  HiveUtils _hiveUtils = new HiveUtils();

  LessonDetailsCubit(this._vocabularyRepository, this._conversationRepository, this._progressRepository) : super(InitialState());

  Future<void> downloadLesson(String lessonId) async{
    try{
      emit(DownloadingLesson(0));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Vocabulary> vocabularies = await _vocabularyRepository.getVocabulariesByLessonId(lessonId, token);
      List<Conversation> conversations = await _conversationRepository.getConversationsByLessonId(lessonId, token);
      var connectivityResult = await (Connectivity().checkConnectivity());
      double percent = 0;
      int totalLength = vocabularies.length + conversations.length;
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
          percent = index * (1 / totalLength);
          emit(DownloadingLesson(percent));
        }
        for(Conversation conversation in conversations){
          bool fileImageExist = _hiveUtils.fileExist(url: conversation.conversationImage, boxName: 'CacheFile');
          bool fileAudioExist = _hiveUtils.fileExist(url: conversation.voiceLink, boxName: 'CacheFile');
          if(!fileImageExist){
            if(conversation.conversationImage != null){
              String fileImagePath = await _hiveUtils.downloadFile(conversation.conversationImage);
              _hiveUtils.addFile(filePath: fileImagePath, url: conversation.conversationImage, boxName: 'CacheFile');
            }
          }
          if(!fileAudioExist){
            if(conversation.voiceLink != null){
              String fileAudioPath = await _hiveUtils.downloadFile(conversation.voiceLink);
              _hiveUtils.addFile(filePath: fileAudioPath, url: conversation.voiceLink, boxName: 'CacheFile');
            }
          }
          index = index + 1;
          percent = index * (1 / totalLength);
          emit(DownloadingLesson(percent));
        }
      }
      emit(DownloadLessonSuccess(vocabularies, conversations));
    } on Exception{
      emit(DownloadLessonFailed('Load Vocabularies Error!'));
    }
  }

  Future<void> syncNewProgress(Progress progress, SaveProgressLocal progressLocal) async{
    emit(SyncingProgress());
    try{
      DateTime localProgressUpdateDate = progressLocal.updateTime;
      DateTime apiProgressDate = DateTime.parse(progress.updateDate.replaceAll('+00:00', ''));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      if(localProgressUpdateDate.compareTo(apiProgressDate) > 0){
        progress.converPercent = progressLocal.converProgress * 10;
        progress.vocabPercent = progressLocal.vocabProgress * 10;
        progress.quizPercent = progressLocal.quizProgress * 10;
        progress.updateDate = localProgressUpdateDate.toIso8601String();
        Progress updatedProgress = await _progressRepository.syncProgress(token, progress);
        print('Update Online' + updatedProgress.toJson().toString());
        emit(SyncProgressSuccess(progressLocal));
      }else if(localProgressUpdateDate.compareTo(apiProgressDate) < 0){
        progressLocal.quizProgress = progress.quizPercent / 10;
        progressLocal.vocabProgress = progress.vocabPercent / 10;
        progressLocal.converProgress = progress.converPercent / 10;
        progressLocal.updateTime = apiProgressDate;
        print('Update Local' + progressLocal.updateTime.toString());
        _hiveUtils.updateLocalProgress(progressLocal: progressLocal, boxName: HiveBoxName.PROGRESS_BOX);
        emit(SyncProgressSuccess(progressLocal));
      }
    }on Exception{
      emit(SyncProgressFailed('Sync Failed!'));
    }

  }

  Future<void> loadLessonFromLocalStorage(String lessonId, Progress progress) async{
    emit(LoadingLocalLesson());
    SaveProgressLocal saveProgressLocal;
    bool isSyncProgress = false;
    List<Vocabulary> vocabularies = await _vocabularyRepository.getVocabulariesFromLocalStorage(lessonId);
    List<Conversation> conversations = await _conversationRepository.getConversationsFromLocalStorage(lessonId);
    bool localProgressExist = _hiveUtils.isProgressExist(lessonID: lessonId, boxName: HiveBoxName.PROGRESS_BOX);
    if(!localProgressExist){
      saveProgressLocal = new SaveProgressLocal(lessonID: lessonId, vocabProgress: progress.vocabPercent / 10, converProgress: progress.converPercent / 10, quizProgress: progress.quizPercent / 10, updateTime: DateTime.parse(progress.updateDate.replaceAll('+00:00', '')), isSync: true);
      _hiveUtils.addProgress(progressLocal: saveProgressLocal, boxName: HiveBoxName.PROGRESS_BOX);
      isSyncProgress = true;
    }else{
      saveProgressLocal = _hiveUtils.getLocalProgress(boxName: HiveBoxName.PROGRESS_BOX, lessonId: lessonId);
      DateTime localProgressUpdateDate = saveProgressLocal.updateTime;
      DateTime apiProgressDate = DateTime.parse(progress.updateDate.replaceAll('+00:00', ''));
      print('online: ' + apiProgressDate.toLocal().toString());
      print('local ' + localProgressUpdateDate.toString());
      if(localProgressUpdateDate.compareTo(apiProgressDate) == 0){
        isSyncProgress = true;
      }else{
        isSyncProgress = false;
      }
    }
    if(vocabularies != null && conversations != null){
      emit(LoadLocalLessonSuccess(vocabularies, conversations, saveProgressLocal, isSyncProgress));
    }else{
      emit(CannotLoadLocalLesson('Please download lesson before learn!', saveProgressLocal, isSyncProgress));
    }
  }
}