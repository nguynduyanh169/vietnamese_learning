import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/quiz_repository.dart';
import 'package:vietnamese_learning/src/models/quiz_submit.dart';
import 'package:vietnamese_learning/src/states/submit_quiz_state.dart';

class SubmitQuizCubit extends Cubit<SubmitQuizState> {
  final QuizRepository _quizRepository;

  SubmitQuizCubit(this._quizRepository) : super(SubmitQuizInit());

  Future<void> submitQuiz({List<ListAswer> listAnswer, Progress progress, int quizId, double quizMark, String lessonId}) async {
    emit(SubmittingQuiz());
    DateTime dateTime = DateTime.now();
    QuizSubmit quizSubmit = new QuizSubmit(
        lessonId: lessonId,
        progress: progress,
        listAswers: listAnswer,
        quizMark: quizMark,
        startDate: dateTime);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      bool check = await _quizRepository.submitQuiz(token, quizSubmit);
      if (check == true) {
        emit(SubmitQuizSuccess());
      } else if (check == false) {
        emit(SubmitQuizFailed('Submit Quiz Failed!'));
      }
    } on Exception {
      emit(SubmitQuizFailed('Submit Quiz Failed!'));
    }
  }
}
