class GameModel {
  String imageAssetPath;
  String title;
  String desc;

  GameModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<GameModel> getSlidesGame() {
  List<GameModel> slides = new List<GameModel>();
  GameModel gameModel = new GameModel();

  //1
  gameModel.setDesc(
      "Matching all the same card to win this game. Play to practice your memory.");
  gameModel.setTitle("Matching Card");
  gameModel.setImageAssetPath("assets/images/cardgame.gif");
  slides.add(gameModel);

  gameModel = new GameModel();

  return slides;
}
