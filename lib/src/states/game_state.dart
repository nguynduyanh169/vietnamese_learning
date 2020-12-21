import 'package:vietnamese_learning/src/models/memory_model.dart';

abstract class GameStates{
  const GameStates();
}

class GameLoading extends GameStates{
  const GameLoading();
}

class GameLoaded extends GameStates{
  final List<TileModel> model;
  const GameLoaded(this.model);
}

class GameLoadError extends GameStates{
  final String error;
  const GameLoadError(this.error);
}