import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/conversation_repository.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/states/conversation_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class ConversationsCubit extends Cubit<ConversationState> {
  final ConversationRepository _conversationRepository;
  HiveUtils _hiveUtils = new HiveUtils();

  ConversationsCubit(this._conversationRepository)
      : super(ConversationsLoading());

  Future<void> loadConversationsByLessonId(String lessonId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Conversation> conversations = await _conversationRepository
          .getConversationsByLessonId(lessonId, token);
      var connectivityResult = await (Connectivity().checkConnectivity());
      double percent = 0;
      int index = 0;
      if(connectivityResult != ConnectivityResult.none){
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
          percent = index * (1 / (conversations.length));
          emit(DownloadingPercentage(percent));
        }
      }
      emit(ConversationsLoaded(conversations));
    } on Exception {
      emit(ConversationLoadError('Load Conversation Error!'));
    }
  }
}
