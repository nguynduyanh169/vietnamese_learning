class GameModel{

  String vocabulary;
  bool isSelected;
  String image;

  GameModel({this.vocabulary, this.isSelected, this.image});

  String getImage(){
    return image;
  }

  void setImage(String newImage){
    image = newImage;
  }
  String getVocabulary(){
    return vocabulary;
  }

  void setVocabulary(String newVocabulary){
    vocabulary = newVocabulary;
  }

  void setIsSelected(bool getIsSelected){
    isSelected = getIsSelected;
  }

  bool getIsSelected(){
    return isSelected;
  }
}