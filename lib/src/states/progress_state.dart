abstract class ProgressState{
  const ProgressState();
}

class InitialCreateProgress extends ProgressState{
  const InitialCreateProgress();
}

class CreateProgressSuccess extends ProgressState{
  const CreateProgressSuccess();
}

class CreateProgressFail extends ProgressState{
  const CreateProgressFail();
}

class CreatingProgress extends ProgressState{
  const CreatingProgress();
}