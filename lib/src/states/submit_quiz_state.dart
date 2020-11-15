abstract class SubmitQuizState{
  const SubmitQuizState();
}
class SubmitQuizInit extends SubmitQuizState{
  const SubmitQuizInit();
}
class SubmittingQuiz extends SubmitQuizState{
  const SubmittingQuiz();
}
class SubmitQuizSuccess extends SubmitQuizState{
  const SubmitQuizSuccess();
}

class SubmitQuizFailed extends SubmitQuizState{
  final String message;
  const SubmitQuizFailed(this.message);
}

