import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/data/quiz_repository.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/quiz.dart';
import 'package:vietnamese_learning/src/states/quiz_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class QuizCubit extends Cubit<QuizState>{

  final QuizRepository _quizRepository;
  HiveUtils _hiveUtils = new HiveUtils();

  QuizCubit(this._quizRepository): super(QuizLoading());

  Future<void> loadQuiz(String lessonId) async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Question> questions = await _quizRepository.getQuestionsByQuizId(token, lessonId);
      for(Question question in questions){
        if(question.quizType == 3){
          bool fileImageExist = _hiveUtils.fileExist(url: question.question, boxName: HiveBoxName.CACHE_FILE_BOX);
          if(!fileImageExist){
            String fileImagePath = await _hiveUtils.downloadFile(question.question);
            _hiveUtils.addFile(filePath: fileImagePath, url: question.question, boxName: HiveBoxName.CACHE_FILE_BOX);
          }
        }
        if(question.quizType == 2){
          bool fileAudioExist = _hiveUtils.fileExist(url: question.question, boxName: HiveBoxName.CACHE_FILE_BOX);
          if(!fileAudioExist){
            String fileAudioPath = await _hiveUtils.downloadFile(question.question);
            _hiveUtils.addFile(filePath: fileAudioPath, url: question.question, boxName: HiveBoxName.CACHE_FILE_BOX);
          }
        }
      }
      emit(QuizLoaded(questions));
    } on Exception{
      emit(QuizLoadError('Load Quiz Error!'));
    }
  }


}