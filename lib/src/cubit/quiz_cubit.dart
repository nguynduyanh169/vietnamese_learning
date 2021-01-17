import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/quiz_repository.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/quiz.dart';
import 'package:vietnamese_learning/src/states/quiz_state.dart';

class QuizCubit extends Cubit<QuizState>{

  final QuizRepository _quizRepository;

  QuizCubit(this._quizRepository): super(QuizLoading());

  Future<void> loadQuiz(String lessonId) async{
    print(lessonId);
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Question> questions = await _quizRepository.getQuestionsByQuizId(token, lessonId);
      emit(QuizLoaded(questions));
    } on Exception{
      emit(QuizLoadError('Load Quiz Error!'));
    }
  }


}