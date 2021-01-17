import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/data/vocabulary_repository.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/states/lesson_details_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class LessonDetailsCubit extends Cubit<LessonDetailsState>{
  final VocabularyRepository _vocabularyRepository;
  final ConversationRepository _conversationRepository;
  HiveUtils _hiveUtils = new HiveUtils();

  LessonDetailsCubit(this._vocabularyRepository, this._conversationRepository) : super(InitialState());

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

  Future<void> loadLessonFromLocalStorage(String lessonId) async{
    emit(LoadingLocalLesson());
    List<Vocabulary> vocabularies = await _vocabularyRepository.getVocabulariesFromLocalStorage(lessonId);
    List<Conversation> conversations = await _conversationRepository.getConversationsFromLocalStorage(lessonId);
    SaveProgressLocal saveProgressLocal = _hiveUtils.getLocalProgress(boxName: HiveBoxName.PROGRESS_BOX, lessonId: lessonId);
    if(vocabularies != null && conversations != null){
      emit(LoadLocalLessonSuccess(vocabularies, conversations, saveProgressLocal));
    }else{
      emit(CannotLoadLocalLesson('Please download lesson before learn!'));
    }
  }
}